#!/usr/bin/env bash
set -euo pipefail
umask 077

# Called by the per-cluster entry points.
kubeconfig="${1:?expected kubeconfig}"
context="$2"
vault="${3:?expected 1Password vault}"
item_name="${4:?expected 1Password item name}"
field_name="${5:-credential}"

command -v op >/dev/null || { echo "error: 1Password CLI (op) is required" >&2; exit 1; }
command -v jq >/dev/null || { echo "error: jq is required" >&2; exit 1; }
command -v kubectl >/dev/null || { echo "error: kubectl is required" >&2; exit 1; }

if [[ -z "$context" ]]; then
  context="$(kubectl --kubeconfig "$kubeconfig" config current-context)"
fi

kube() {
  kubectl --kubeconfig "$kubeconfig" --context "$context" "$@"
}

if ! op whoami >/dev/null 2>&1; then
  echo "error: 'op whoami' could not verify a 1Password CLI sign-in." >&2
  echo "Sign in with 'op signin', then retry." >&2
  exit 1
fi

if ! kube cluster-info >/dev/null 2>&1; then
  echo "error: cannot access Kubernetes context '$context'" >&2
  exit 1
fi

if ! token_reference="$(op item get "$item_name" --vault "$vault" \
  --fields "label=$field_name" --format json | jq -er '.reference')"; then
  echo "error: could not resolve field '$field_name' on item '$item_name' in vault '$vault'" >&2
  exit 1
fi

tmpdir="$(mktemp -d "${TMPDIR:-/tmp}/homelab-1password.XXXXXXXX")"
trap 'rm -rf "$tmpdir"' EXIT

op read "$token_reference" | tr -d '\r\n' > "$tmpdir/token"
if [[ ! -s "$tmpdir/token" ]]; then
  echo "error: 1Password returned an empty token" >&2
  exit 1
fi

kube create namespace external-secrets \
  --dry-run=client -o yaml \
  | kube apply -f - >/dev/null

kube -n external-secrets \
  create secret generic onepassword-service-account-token \
  --from-file=token="$tmpdir/token" \
  --dry-run=client -o yaml \
  | kube apply -f - >/dev/null

echo "Bootstrapped the 1Password token Secret in context '$context'."
