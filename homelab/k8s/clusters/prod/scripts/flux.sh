#!/usr/bin/env bash
set -euo pipefail
umask 077

homelab="${BUILD_WORKSPACE_DIRECTORY:?Run this script using bazel run}/homelab"
prod="$homelab/k8s/clusters/prod"
kubeconfig="$prod/.state/talos-kubeconfig"
context="admin@homelab-prod-talos"

die() { echo "error: $*" >&2; exit 1; }

kube() {
  kubectl --kubeconfig "$kubeconfig" --context "$context" "$@"
}

[[ $# == 0 ]] || die "usage: prod:flux"
command -v kubectl >/dev/null || die "kubectl is required"
[[ -s "$kubeconfig" ]] || die "run prod:up first"
[[ "$(kube config view --minify -o 'jsonpath={.clusters[0].cluster.server}')" == 'https://192.168.4.4:6443' ]] ||
  die "prod kubeconfig does not point at the Talos API VIP"
kube get secret onepassword-service-account-token -n external-secrets -o name >/dev/null
kube wait --for=condition=Ready node/talos-prod-01 node/talos-prod-02 node/talos-prod-03 --timeout=120s
kube apply -k "$homelab/k8s/platform/flux/install"
for controller in source-controller kustomize-controller; do
  kube -n flux-system rollout status "deployment/$controller" --timeout=300s
done
kube apply -k "$prod/flux"
for component in flux-system prod-platform gateway-api-crds external-secrets cert-manager longhorn; do
  kube -n flux-system wait --for=condition=Ready "kustomization/$component" --timeout=1200s
done
