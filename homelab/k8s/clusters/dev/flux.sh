#!/usr/bin/env bash
set -euo pipefail
umask 077

cd "${BUILD_WORKSPACE_DIRECTORY:?Run this script using bazel run}/homelab/k8s/clusters/dev"

export KUBECONFIG="$PWD/.state/kubeconfig"
CONTEXT="kind-homelab-dev"

command -v kubectl >/dev/null || { echo "error: kubectl is required" >&2; exit 1; }

kubectl --context "$CONTEXT" wait \
  --for=condition=Ready nodes --all --timeout=120s

kubectl --context "$CONTEXT" apply -k ../../platform/flux/install

for deployment in source-controller kustomize-controller; do
  kubectl --context "$CONTEXT" -n flux-system \
    rollout status "deployment/${deployment}" --timeout=300s
done

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
