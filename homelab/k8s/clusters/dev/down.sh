#!/usr/bin/env bash
set -euo pipefail

cd "${BUILD_WORKSPACE_DIRECTORY:?Run this script using bazel run}/homelab/k8s/clusters/dev"

export KIND_EXPERIMENTAL_PROVIDER=docker
export KUBECONFIG="$PWD/.state/kubeconfig"

kind delete cluster \
  --name homelab-dev \
  --kubeconfig "$KUBECONFIG"

rm -f "$KUBECONFIG"
