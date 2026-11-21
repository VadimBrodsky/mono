#!/usr/bin/env bash
set -euo pipefail

workspace="${BUILD_WORKSPACE_DIRECTORY:?Run using bazel run //homelab/k8s/clusters/dev:seed-eso}"
clusters="$workspace/homelab/k8s/clusters"

[[ $# -le 1 ]] || { echo "usage: dev:seed-eso [field-name]" >&2; exit 2; }

exec bash "$clusters/lib/seed-eso.sh" "$clusters/dev/.state/talos-kubeconfig" \
  "${HOMELAB_DEV_CONTEXT:-}" Private homelab-dev-service-account "${1:-credential}"
