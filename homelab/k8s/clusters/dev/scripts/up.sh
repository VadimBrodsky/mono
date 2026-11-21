#!/usr/bin/env bash
set -euo pipefail
umask 077

workspace="${BUILD_WORKSPACE_DIRECTORY:?Run this script using bazel run}"
cd "$workspace/homelab/k8s/clusters/dev"

repo_dir="$PWD"
cluster_name="homelab-dev-talos"
cluster_cidr="10.200.0.0/24"
cluster_gateway="10.200.0.1"
controlplane_ip="10.200.0.2"
state_dir="$PWD/.state"
qemu_state="$HOME/.talos/homelab-dev-qemu"
talosconfig="$state_dir/talosconfig"
kubeconfig="$state_dir/talos-kubeconfig"
schematic_id_file="$state_dir/longhorn-schematic-id"

for tool in talosctl qemu-system-aarch64 kubectl curl jq; do
  command -v "$tool" >/dev/null || {
    echo "error: $tool is required" >&2
    exit 1
  }
done

mkdir -p "$state_dir" "$HOME/.talos"
chmod 700 "$state_dir"

if [[ ! -s "$schematic_id_file" ]]; then
  curl --fail --silent --show-error \
    -X POST https://factory.talos.dev/schematics \
    -H 'Content-Type: application/yaml' \
    --data-binary @talos/longhorn-extensions.yaml \
    | jq -er '.id' > "$schematic_id_file"
  chmod 600 "$schematic_id_file"
fi

# A previous bootstrap attempt stored QEMU state inside the repository. Clean
# up only that exact, known state location; the short path below avoids
# macOS's Unix-domain socket path limit.
legacy_qemu_state="$state_dir/qemu-state"
if sudo test -d "$legacy_qemu_state/$cluster_name"; then
  sudo -E talosctl cluster destroy \
    --name "$cluster_name" \
    --state "$legacy_qemu_state"
fi

if sudo test -d "$qemu_state/$cluster_name"; then
  echo "Talos QEMU state already exists at $qemu_state/$cluster_name"
else
  (
    cd "$state_dir"
    sudo -E env \
      KUBECONFIG="$kubeconfig" \
      TALOSCONFIG="$talosconfig" \
      PATH="$PATH" \
      talosctl cluster create qemu \
        --name "$cluster_name" \
        --state "$qemu_state" \
        --talosconfig-destination "$talosconfig" \
        --presets iso \
        --cidr "$cluster_cidr" \
        --talos-version v1.14.5 \
        --kubernetes-version v1.35.8 \
        --schematic-id "$(cat "$schematic_id_file")" \
        --controlplanes 1 \
        --workers 0 \
        --cpus-controlplanes 4 \
        --memory-controlplanes 6GiB \
        --disks virtio:40GiB \
        --config-patch-controlplanes "@$repo_dir/talos/controlplane-dev.patch.yaml"
  )
fi

if [[ ! -s "$kubeconfig" ]]; then
  echo "error: Talos cluster exists but kubeconfig is missing at $kubeconfig" >&2
  echo "Inspect the cluster with talosctl before retrying." >&2
  exit 1
fi

# Ensure traffic for the QEMU subnet uses its vmnet bridge, not a VPN/LAN
# route with the same destination.
route_output="$(route -n get "$controlplane_ip" 2>/dev/null || true)"
if ! grep -Eq 'interface: bridge[0-9]+' <<<"$route_output"; then
  if ! sudo route -n add -net "$cluster_cidr" -interface "$cluster_gateway"; then
    echo "error: could not route $cluster_cidr through the Talos QEMU bridge" >&2
    route -n get "$controlplane_ip" >&2 || true
    exit 1
  fi
fi

route_output="$(route -n get "$controlplane_ip" 2>/dev/null || true)"
if ! grep -Eq 'interface: bridge[0-9]+' <<<"$route_output"; then
  echo "error: Talos API traffic is not routing through the QEMU bridge" >&2
  echo "$route_output" >&2
  exit 1
fi

for local_config in \
  "$talosconfig" \
  "$kubeconfig" \
  "$state_dir/controlplane.yaml" \
  "$state_dir/worker.yaml"; do
  if [[ -f "$local_config" ]]; then
    sudo chown "$(id -u):$(id -g)" "$local_config"
    chmod 600 "$local_config"
  fi
done
export KUBECONFIG="$kubeconfig"

kubectl wait --for=condition=Ready nodes --all --timeout=180s
kubectl get nodes

"$repo_dir/scripts/seed-eso.sh" "$@"
