#!/usr/bin/env bash

# Shared OpenTofu setup for plan.sh and up.sh.

homelab="${BUILD_WORKSPACE_DIRECTORY:?Run this script using bazel run}/homelab"
prod="$homelab/k8s/clusters/prod"
state_dir="$prod/.state"
tofu_dir="$homelab/terraform/proxmox"
plan="$state_dir/provision.tfplan"

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
