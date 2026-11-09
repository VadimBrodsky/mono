#!/usr/bin/env bash
set -euo pipefail
umask 077

cd "${BUILD_WORKSPACE_DIRECTORY:?Run this script using bazel run}/homelab/k8s/clusters/dev"

export KUBECONFIG="$PWD/.state/kubeconfig"
CONTEXT="kind-homelab-dev"
FLUX_VERSION="v2.10.0"

command -v flux >/dev/null || { echo "error: Flux CLI ${FLUX_VERSION} is required" >&2; exit 1; }
command -v kubectl >/dev/null || { echo "error: kubectl is required" >&2; exit 1; }

client_version="$(flux version --client -o json)"
if [[ "$client_version" != *"2.10.0"* ]]; then
  echo "error: expected Flux CLI ${FLUX_VERSION}; found ${client_version}" >&2
  exit 1
fi

kubectl --context "$CONTEXT" wait \
  --for=condition=Ready nodes --all --timeout=120s

flux install \
  --version="$FLUX_VERSION" \
  --components=source-controller,kustomize-controller

kubectl --context "$CONTEXT" apply -k ../../platform/flux/dev/bootstrap

kubectl --context "$CONTEXT" -n flux-system wait \
  --for=condition=Ready gitrepository/homelab --timeout=300s
kubectl --context "$CONTEXT" -n flux-system wait \
  --for=condition=Ready kustomization/flux-system --timeout=1800s

for kustomization in gateway-api-crds external-secrets cert-manager; do
  kubectl --context "$CONTEXT" -n flux-system wait \
    --for=condition=Ready "kustomization/${kustomization}" --timeout=1800s
done

echo "Flux and prerequisite platform components are ready."
echo "Next: bazel run //homelab/k8s/clusters/dev:secret"
echo "Then: bazel run //homelab/k8s/clusters/dev:activate"
