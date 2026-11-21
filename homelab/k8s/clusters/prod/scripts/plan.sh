#!/usr/bin/env bash
set -euo pipefail
umask 077

source "${BUILD_WORKSPACE_DIRECTORY:?Run this script using bazel run}/homelab/k8s/clusters/prod/scripts/tofu.sh"

[[ $# == 0 ]] || die "usage: prod:plan"
need tofu op jq
mkdir -p "$state_dir"
chmod 700 "$state_dir"
# Never leave a previous plan available for apply after a failed re-plan.
rm -f "$plan"
tofu_run init -input=false -lockfile=readonly "-backend-config=path=$state_dir/proxmox.tfstate"
tofu_run plan -input=false -out="$plan"
echo "Review the output above before running prod:up."
