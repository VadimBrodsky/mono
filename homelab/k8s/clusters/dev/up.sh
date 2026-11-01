#!/usr/bin/env bash
set -euo pipefail
umask 077

cd "${BUILD_WORKSPACE_DIRECTORY:?Run this script using bazel run}/homelab/k8s/clusters/dev"

export KIND_EXPERIMENTAL_PROVIDER=docker
export KUBECONFIG="$PWD/.state/kubeconfig"

CLUSTER_NAME="homelab-dev"

mkdir -p .state

clusters="$(kind get clusters)"

if ! grep -Fxq "$CLUSTER_NAME" <<<"$clusters"; then
  kind create cluster \
    --name "$CLUSTER_NAME" \
    --config kind.yaml \
    --kubeconfig "$KUBECONFIG" \
    --wait 120s
fi

kind export kubeconfig \
  --name "$CLUSTER_NAME" \
  --kubeconfig "$KUBECONFIG"

kubectl --context "kind-${CLUSTER_NAME}" \
  wait --for=condition=Ready nodes --all --timeout=120s

kubectl --context "kind-${CLUSTER_NAME}" get nodes
