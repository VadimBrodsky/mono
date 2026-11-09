#!/usr/bin/env bash
set -euo pipefail
umask 077

cd "${BUILD_WORKSPACE_DIRECTORY:?Run this script using bazel run}/homelab/k8s/clusters/dev"

export KUBECONFIG="$PWD/.state/kubeconfig"
CONTEXT="kind-homelab-dev"

if ! kubectl --context "$CONTEXT" -n external-secrets \
  get secret onepassword-service-account-token >/dev/null 2>&1; then
  echo "error: the ESO 1Password bootstrap Secret is missing." >&2
  echo "Run: bazel run //homelab/k8s/clusters/dev:secret" >&2
  exit 1
fi

for kustomization in gateway-api-crds external-secrets cert-manager; do
  kubectl --context "$CONTEXT" -n flux-system wait \
    --for=condition=Ready "kustomization/${kustomization}" --timeout=1800s
done

kubectl --context "$CONTEXT" apply \
  -f ../../platform/flux/dev/post-secret/activate.yaml

kubectl --context "$CONTEXT" -n flux-system wait \
  --for=condition=Ready kustomization/dev-post-secret --timeout=3600s

echo "Post-secret GitOps stage is ready, including certificates, Traefik, and apps."
