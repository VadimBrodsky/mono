#!/usr/bin/env bash
set -euo pipefail
umask 077

cd "${BUILD_WORKSPACE_DIRECTORY:?Run this script using bazel run}/homelab/k8s/clusters/dev"

export KUBECONFIG="$PWD/.state/kubeconfig"
CLUSTER_NAME="homelab-dev"
CONTEXT="kind-${CLUSTER_NAME}"

kubectl --context "$CONTEXT" wait \
  --for=condition=Ready nodes --all --timeout=120s

if ! kubectl --context "$CONTEXT" -n external-secrets \
  get secret onepassword-service-account-token >/dev/null 2>&1; then
  echo "error: the ESO 1Password bootstrap Secret is missing." >&2
  echo "Run: bazel run //homelab/k8s/clusters/dev:02_secret" >&2
  exit 1
fi

# Install the cluster-wide Gateway API before applying Gateway resources.
kubectl --context "$CONTEXT" apply --server-side \
  -k ../../platform/gateway-api

kubectl --context "$CONTEXT" wait --for=condition=Established \
  crd/backendtlspolicies.gateway.networking.k8s.io \
  crd/gatewayclasses.gateway.networking.k8s.io \
  crd/gateways.gateway.networking.k8s.io \
  crd/grpcroutes.gateway.networking.k8s.io \
  crd/httproutes.gateway.networking.k8s.io \
  crd/listenersets.gateway.networking.k8s.io \
  crd/referencegrants.gateway.networking.k8s.io \
  crd/tcproutes.gateway.networking.k8s.io \
  crd/tlsroutes.gateway.networking.k8s.io \
  crd/udproutes.gateway.networking.k8s.io \
  --timeout=120s

# Install External Secrets Operator before applying its custom resources.
kubectl --context "$CONTEXT" apply --server-side \
  -k ../../platform/external-secrets/overlays/dev

kubectl --context "$CONTEXT" wait --for=condition=Established \
  crd/clustersecretstores.external-secrets.io \
  crd/externalsecrets.external-secrets.io \
  crd/secretstores.external-secrets.io \
  --timeout=180s

for deployment in external-secrets external-secrets-webhook external-secrets-cert-controller; do
  kubectl --context "$CONTEXT" -n external-secrets \
    rollout status "deployment/${deployment}" --timeout=180s
done

# Install cert-manager before applying its custom resources.
kubectl --context "$CONTEXT" apply --server-side \
  -k ../../platform/cert-manager/install

kubectl --context "$CONTEXT" wait --for=condition=Established \
  crd/certificates.cert-manager.io \
  crd/certificaterequests.cert-manager.io \
  crd/clusterissuers.cert-manager.io \
  crd/issuers.cert-manager.io \
  crd/orders.acme.cert-manager.io \
  crd/challenges.acme.cert-manager.io \
  --timeout=180s

for deployment in cert-manager cert-manager-cainjector cert-manager-webhook; do
  kubectl --context "$CONTEXT" -n cert-manager \
    rollout status "deployment/${deployment}" --timeout=180s
done

# Sync the Cloudflare API token from the homelab-dev 1Password vault.
kubectl --context "$CONTEXT" apply --server-side \
  -k ../../platform/external-secrets/onepassword/dev

kubectl --context "$CONTEXT" -n cert-manager \
  wait --for=condition=Ready externalsecret/cloudflare-api-token --timeout=300s

# Certificates are stored in Traefik's namespace, which Traefik normally creates.
# Create it here first because certificate issuance must finish before Traefik is applied.
kubectl --context "$CONTEXT" create namespace traefik \
  --dry-run=client -o yaml \
  | kubectl --context "$CONTEXT" apply -f - >/dev/null

# Validate DNS-01 with staging before requesting a trusted production cert.
kubectl --context "$CONTEXT" apply --server-side \
  -k ../../platform/cert-manager/dev

kubectl --context "$CONTEXT" -n traefik \
  wait --for=condition=Ready certificate/dev-kind-staging --timeout=600s

kubectl --context "$CONTEXT" apply --server-side \
  -k ../../platform/cert-manager/production

kubectl --context "$CONTEXT" -n traefik \
  wait --for=condition=Ready certificate/dev-kind-production --timeout=600s

# Configure HTTPS only after the production certificate Secret exists.
kubectl --context "$CONTEXT" apply --server-side \
  -k ../../platform/traefik/overlays/dev

kubectl --context "$CONTEXT" -n traefik \
  rollout status deployment/traefik --timeout=180s
