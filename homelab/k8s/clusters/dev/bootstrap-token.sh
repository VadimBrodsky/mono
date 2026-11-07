#!/usr/bin/env bash
set -euo pipefail

workspace="${BUILD_WORKSPACE_DIRECTORY:?Run this script using bazel run}"
exec "$workspace/homelab/k8s/scripts/bootstrap-1password-token.sh" \
  dev homelab-dev-service-account "$@"
