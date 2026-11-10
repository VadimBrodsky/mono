#!/usr/bin/env bash
set -euo pipefail
umask 077

usage() {
  cat >&2 <<'EOF'
Usage: bootstrap-1password-token.sh <dev|prod> <1password-item-name> [field-name]

Example:
  bootstrap-1password-token.sh dev homelab-dev-service-account

The default field name is "credential". Dev uses the kind-homelab-dev context,
the local dev kubeconfig, and the Private vault. Prod requires HOMELAB_PROD_CONTEXT
and HOMELAB_PROD_VAULT; it uses HOMELAB_PROD_KUBECONFIG if set, otherwise ~/.kube/config.
EOF
  exit 2
}

[[ $# -ge 2 && $# -le 3 ]] || usage

environment="$1"
item_name="$2"
field_name="${3:-credential}"

case "$environment" in
  dev)
    script_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
    context="kind-homelab-dev"
    export KUBECONFIG="$(cd -- "$script_dir/../clusters/dev" && pwd)/.state/kubeconfig"
    vault="Private"
    ;;
  prod)
    context="${HOMELAB_PROD_CONTEXT:-}"
    vault="${HOMELAB_PROD_VAULT:-}"
    if [[ -z "$context" || -z "$vault" ]]; then
      echo "error: set HOMELAB_PROD_CONTEXT and HOMELAB_PROD_VAULT for prod" >&2
      exit 2
    fi
    export KUBECONFIG="${HOMELAB_PROD_KUBECONFIG:-$HOME/.kube/config}"
    ;;
  *)
    echo "error: environment must be 'dev' or 'prod'" >&2
    usage
    ;;
esac

command -v op >/dev/null || { echo "error: 1Password CLI (op) is required" >&2; exit 1; }
command -v jq >/dev/null || { echo "error: jq is required" >&2; exit 1; }
command -v kubectl >/dev/null || { echo "error: kubectl is required" >&2; exit 1; }

if ! op whoami >/dev/null 2>&1; then
  echo "error: 'op whoami' could not verify a 1Password CLI sign-in." >&2
  echo "Sign in with 'op signin', then retry." >&2
  exit 1
fi

if ! kubectl --context "$context" cluster-info >/dev/null 2>&1; then
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

kubectl --context "$context" create namespace external-secrets \
  --dry-run=client -o yaml \
  | kubectl --context "$context" apply -f - >/dev/null

kubectl --context "$context" -n external-secrets \
  create secret generic onepassword-service-account-token \
  --from-file=token="$tmpdir/token" \
  --dry-run=client -o yaml \
  | kubectl --context "$context" apply -f - >/dev/null

echo "Bootstrapped the 1Password token Secret in context '$context'."
