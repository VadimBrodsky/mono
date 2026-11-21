#!/usr/bin/env bash
set -euo pipefail

workspace="${BUILD_WORKSPACE_DIRECTORY:?Run using bazel run //homelab/k8s/clusters/prod:seed-eso}"
clusters="$workspace/homelab/k8s/clusters"
kubeconfig="$clusters/prod/.state/talos-kubeconfig"
context="admin@homelab-prod-talos"

[[ $# == 0 ]] || { echo "usage: prod:seed-eso" >&2; exit 2; }
command -v kubectl >/dev/null || { echo "error: kubectl is required" >&2; exit 1; }
if [[ "$(kubectl --kubeconfig "$kubeconfig" --context "$context" config view --minify \
    -o 'jsonpath={.clusters[0].cluster.server}')" != 'https://192.168.4.4:6443' ]]; then
  echo "error: prod kubeconfig does not point at the Talos API VIP" >&2
  exit 1
fi

exec bash "$clusters/lib/seed-eso.sh" "$kubeconfig" "$context" \
  Selfhosted homelab-prod-service-account credential
