#!/usr/bin/env bash

# Source this script to set KUBECONFIG in the current shell:
#   source homelab/k8s/scripts/set-context.sh dev

if [[ -n "${ZSH_VERSION:-}" ]]; then
  if [[ "$ZSH_EVAL_CONTEXT" != *:file ]]; then
    echo "Source this script with an environment: source ${(%):-%x} dev|prod" >&2
    return 2
  fi
  SCRIPTS_DIR="${${(%):-%x}:A:h}"
else
  if [[ "${BASH_SOURCE[0]}" == "$0" ]]; then
    echo "Source this script with an environment: source ${BASH_SOURCE[0]} dev|prod" >&2
    exit 2
  fi
  SCRIPTS_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
fi

if [[ $# -ne 1 ]]; then
  echo "Usage: source homelab/k8s/scripts/set-context.sh <dev|prod>" >&2
  return 2
fi

case "$1" in
  dev)
    KUBECONFIG="$(cd -- "$SCRIPTS_DIR/../clusters/dev" && pwd)/.state/kubeconfig"
    CONTEXT="kind-homelab-dev"
    ;;
  prod)
    CONTEXT="${HOMELAB_PROD_CONTEXT:-}"
    if [[ -z "$CONTEXT" ]]; then
      echo "error: set HOMELAB_PROD_CONTEXT to the prod cluster's kubectl context" >&2
      return 2
    fi
    KUBECONFIG="${HOMELAB_PROD_KUBECONFIG:-$HOME/.kube/config}"
    ;;
  *)
    echo "error: environment must be 'dev' or 'prod'" >&2
    return 2
    ;;
esac

if [[ ! -f "$KUBECONFIG" ]]; then
  echo "error: kubeconfig not found at $KUBECONFIG" >&2
  [[ "$1" == dev ]] && echo "Start the dev cluster first." >&2
  return 1
fi

export KUBECONFIG
kubectl config use-context "$CONTEXT" || return 1

unset SCRIPTS_DIR CONTEXT
