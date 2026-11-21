#!/usr/bin/env bash

if [[ -n "${ZSH_VERSION:-}" ]]; then
  _homelab_context_dir="${${(%):-%x}:A:h}"
elif [[ "${BASH_SOURCE[0]}" != "$0" ]]; then
  _homelab_context_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
else
  echo "Source this script: source $0 [kind]" >&2
  exit 2
fi

case "${1:-dev}" in
  dev)
    source "$_homelab_context_dir/../../lib/set-context.sh" \
      "$_homelab_context_dir/../.state/talos-kubeconfig" "${HOMELAB_DEV_CONTEXT:-}" &&
      { unset _homelab_context_dir; return 0; }
    ;;
  kind)
    source "$_homelab_context_dir/../../lib/set-context.sh" \
      "$_homelab_context_dir/../.state/kubeconfig" kind-homelab-dev &&
      { unset _homelab_context_dir; return 0; }
    ;;
  *)
    unset _homelab_context_dir
    echo "Usage: source set-context.sh [dev|kind]" >&2
    return 2
    ;;
esac
unset _homelab_context_dir
return 1
