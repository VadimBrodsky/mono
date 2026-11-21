#!/usr/bin/env bash
set -euo pipefail
umask 077

source "${BUILD_WORKSPACE_DIRECTORY:?Run this script using bazel run}/homelab/k8s/clusters/prod/scripts/tofu.sh"

need tofu op jq talosctl kubectl
[[ $# == 0 || ($# == 1 && "$1" == "--resume") ]] || die "usage: prod:up [--resume]"
[[ -d "$state_dir" ]] || die "run prod:plan first"
if [[ $# == 0 ]]; then
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
bash "$prod/scripts/bootstrap-talos.sh" \
  "$state_dir" "$tofu_dir/cluster.json" "$prod/talos/controlplane.patch.yaml"
"$prod/scripts/seed-eso.sh"
