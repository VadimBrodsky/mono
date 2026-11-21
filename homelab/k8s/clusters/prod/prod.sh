#!/usr/bin/env bash
set -euo pipefail
umask 077

homelab="${BUILD_WORKSPACE_DIRECTORY:?Run this script using bazel run}/homelab"
prod="$homelab/k8s/clusters/prod"
state_dir="$prod/.state"
tofu_dir="$homelab/terraform/proxmox"
plan="$state_dir/provision.tfplan"
context="admin@homelab-prod-talos"
kubeconfig="$state_dir/talos-kubeconfig"

die() { echo "error: $*" >&2; exit 1; }
need() {
  for tool in "$@"; do
    command -v "$tool" >/dev/null || die "$tool is required"
  done
}

tofu_run() (
  unset TF_ENCRYPTION TF_CLI_ARGS TF_CLI_ARGS_init TF_CLI_ARGS_plan TF_CLI_ARGS_apply TF_CLI_ARGS_show
  unset TF_LOG TF_LOG_PATH TF_LOG_CORE TF_LOG_PROVIDER
  export TF_DATA_DIR="$state_dir/tofu-data"
  export TF_WORKSPACE=default TF_IN_AUTOMATION=1
  # The @ in the item title is not valid in an op:// reference.
  item="$(op item get 'rofu@pve' --vault Selfhosted --format json | jq -er '.id')"
  local_id="$(op read "op://Selfhosted/$item/token-id")"
  [[ "$local_id" == 'rofu@pve!homelab' ]] || die "unexpected Proxmox token ID"
  local_secret="$(op read "op://Selfhosted/$item/token-secret")"
  [[ -n "$local_secret" ]] || die "empty Proxmox token secret"
  export PROXMOX_VE_API_TOKEN="$local_id=$local_secret"
  TF_VAR_state_passphrase="$(op read 'op://Selfhosted/homelab-prod-opentofu/passphrase')"
  export TF_VAR_state_passphrase
  [[ ${#TF_VAR_state_passphrase} -ge 16 ]] || die "OpenTofu passphrase is too short"
  tofu -chdir="$tofu_dir" "$@"
)

kube() {
  kubectl --kubeconfig "$kubeconfig" --context "$context" "$@"
}

case "${1:-}" in
  plan)
    [[ $# == 1 ]] || die "usage: prod:plan"
    need tofu op jq
    mkdir -p "$state_dir"
    chmod 700 "$state_dir"
    # Never leave a previous plan available for apply after a failed re-plan.
    rm -f "$plan"
    tofu_run init -input=false -lockfile=readonly "-backend-config=path=$state_dir/proxmox.tfstate"
    tofu_run plan -input=false -out="$plan"
    echo "Review the output above before running prod:up."
    ;;
  up)
    need tofu op jq talosctl kubectl
    [[ $# == 1 || ($# == 2 && "$2" == "--resume") ]] || die "usage: prod:up [--resume]"
    [[ -d "$state_dir" ]] || die "run prod:plan first"
    if [[ $# == 1 ]]; then
      [[ -s "$plan" ]] || die "no saved plan; run prod:plan, or use --resume after a successful apply"
      op item get homelab-prod-talos-secrets --vault Selfhosted >/dev/null
      op read 'op://Selfhosted/homelab-prod-service-account/credential' >/dev/null
      tofu_run show -json "$plan" |
        jq -e 'all(.resource_changes[]?; .type == "proxmox_virtual_environment_vm"
          and (.change.actions == ["create"] or .change.actions == ["no-op"]))' >/dev/null ||
        die "prod:up only accepts VM creation and no-op changes"
      read -r -p 'Type homelab-prod-talos to apply the reviewed plan: ' confirm
      [[ "$confirm" == "homelab-prod-talos" ]] || die "apply cancelled"
      tofu_run apply -input=false "$plan"
      rm -f "$plan"
    fi
    # Require all three managed VMs even when resuming a failed Talos bootstrap.
    tofu_run state list | diff - <(
      jq -r '.nodes | keys[] | "proxmox_virtual_environment_vm.talos[\"\(.)\"]"' "$tofu_dir/cluster.json"
    ) || die "OpenTofu state does not contain exactly the three prod VMs"
    bash "$homelab/bootstrap/talos-prod.sh" \
      "$state_dir" "$tofu_dir/cluster.json" "$prod/talos/controlplane.patch.yaml"
    HOMELAB_PROD_KUBECONFIG="$kubeconfig" \
      HOMELAB_PROD_CONTEXT="$context" HOMELAB_PROD_VAULT=Selfhosted \
      bash "$homelab/k8s/scripts/bootstrap-1password-token.sh" \
        prod homelab-prod-service-account
    ;;
  flux)
    [[ $# == 1 ]] || die "usage: prod:flux"
    need kubectl
    [[ -s "$kubeconfig" ]] || die "run prod:up first"
    [[ "$(kube config view --minify -o 'jsonpath={.clusters[0].cluster.server}')" == 'https://192.168.4.4:6443' ]] ||
      die "prod kubeconfig does not point at the Talos API VIP"
    kube get secret onepassword-service-account-token -n external-secrets -o name >/dev/null
    kube wait --for=condition=Ready node/talos-prod-01 node/talos-prod-02 node/talos-prod-03 --timeout=120s
    kube apply -k "$homelab/k8s/platform/flux/install"
    for controller in source-controller kustomize-controller; do
      kube -n flux-system rollout status "deployment/$controller" --timeout=300s
    done
    kube apply -k "$prod/flux-platform"
    for component in prod-platform gateway-api-crds external-secrets cert-manager longhorn; do
      kube -n flux-system wait --for=condition=Ready "kustomization/$component" --timeout=1200s
    done
    ;;
  *) die "use the plan, up, or flux Bazel target" ;;
esac
