#!/usr/bin/env bash

if [[ -n "${ZSH_VERSION:-}" ]]; then
  _homelab_context_dir="${${(%):-%x}:A:h}"
elif [[ "${BASH_SOURCE[0]}" != "$0" ]]; then
  _homelab_context_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
else
  echo "Source this script: source $0" >&2
  exit 2
fi

source "$_homelab_context_dir/../../lib/set-context.sh" \
  "${HOMELAB_PROD_KUBECONFIG:-$_homelab_context_dir/../.state/talos-kubeconfig}" \
  "${HOMELAB_PROD_CONTEXT:-admin@homelab-prod-talos}" &&
  { unset _homelab_context_dir; return 0; }
unset _homelab_context_dir
return 1
