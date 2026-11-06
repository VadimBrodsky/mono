#!/usr/bin/env bash
set -euo pipefail
umask 077

usage() {
  cat >&2 <<'EOF'
Usage: bootstrap-1password-token.sh <kube-context> <op-token-reference>

Example:
  bootstrap-1password-token.sh kind-homelab-dev \
    'op://Homelab Bootstrap/ESO dev service account/token'

The referenced 1Password field must contain the 1Password Service Account token.
The token is stored in the external-secrets namespace as
onepassword-service-account-token (key: token).
EOF
  exit 2
}

[[ $# -eq 2 ]] || usage

context="$1"
token_reference="$2"

command -v op >/dev/null || { echo "error: 1Password CLI (op) is required" >&2; exit 1; }
command -v kubectl >/dev/null || { echo "error: kubectl is required" >&2; exit 1; }

if ! op whoami >/dev/null 2>&1; then
  echo "error: sign in to 1Password CLI before running this script" >&2
  exit 1
fi

if ! kubectl --context "$context" cluster-info >/dev/null 2>&1; then
  echo "error: cannot access Kubernetes context '$context'" >&2
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
