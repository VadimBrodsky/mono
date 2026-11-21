#!/usr/bin/env bash
set -euo pipefail

workspace="${BUILD_WORKSPACE_DIRECTORY:?Run this script using bazel run}"
kubeconfig="$workspace/homelab/k8s/clusters/prod/.state/talos-kubeconfig"

if [[ ! -s "$kubeconfig" ]]; then
  echo "error: Talos prod kubeconfig not found at $kubeconfig" >&2
  echo "Run bazel run //homelab/k8s/clusters/prod:up first." >&2
  exit 1
fi

command -v k9s >/dev/null || { echo "error: k9s is required" >&2; exit 1; }

exec k9s --kubeconfig "$kubeconfig" --context admin@homelab-prod-talos --readonly
