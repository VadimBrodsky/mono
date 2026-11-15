#!/usr/bin/env bash
set -euo pipefail

cd "${BUILD_WORKSPACE_DIRECTORY:?Run this script using bazel run}/homelab/k8s/clusters/dev"

cluster_name="homelab-dev-talos"
qemu_state="$HOME/.talos/homelab-dev-qemu"

if sudo test -d "$qemu_state/$cluster_name"; then
  sudo -E talosctl cluster destroy \
    --name "$cluster_name" \
    --state "$qemu_state"
fi

rm -f .state/talos-kubeconfig .state/talosconfig
