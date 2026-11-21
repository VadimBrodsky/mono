#!/usr/bin/env bash

# Sourced by a cluster entry point to update KUBECONFIG in the current shell.
_homelab_set_context() {
  local kubeconfig="$1" context="$2"
  if [[ ! -s "$kubeconfig" ]]; then
    echo "error: kubeconfig not found at $kubeconfig" >&2
    return 1
  fi
  if [[ -z "$context" ]]; then
    context="$(kubectl --kubeconfig "$kubeconfig" config current-context)" || return 1
  fi
  kubectl --kubeconfig "$kubeconfig" config use-context "$context" || return 1
  export KUBECONFIG="$kubeconfig"
}

_homelab_set_context "$@" && { unset -f _homelab_set_context; return 0; }
unset -f _homelab_set_context
return 1
