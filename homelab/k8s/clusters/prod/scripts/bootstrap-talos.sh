#!/usr/bin/env bash
set -euo pipefail
umask 077

state_dir="${1:?expected prod state directory}"
inventory="${2:?expected prod cluster inventory}"
controlplane_patch="${3:?expected prod Talos control-plane patch}"
cluster="$(jq -er '.name' "$inventory")"
vip="$(jq -er '.api_vip' "$inventory")"
talos_version="$(jq -er '.talos_version' "$inventory")"
kubernetes_version="$(jq -er '.kubernetes_version' "$inventory")"
schematic="$(jq -er '.schematic' "$inventory")"
talosconfig="$state_dir/talosconfig"
marker="$state_dir/etcd-bootstrap-attempted"

die() { echo "error: $*" >&2; exit 1; }
work="$(mktemp -d "$state_dir/.talos.XXXXXXXX")"
trap 'rm -rf "$work"' EXIT
op document get homelab-prod-talos-secrets --vault Selfhosted --out-file "$work/secrets.yaml"
[[ -s "$work/secrets.yaml" ]] || die "missing Talos secrets bundle"

[[ "$vip" =~ ^([0-9]{1,3}\.){3}[0-9]{1,3}$ ]] || die "expected an IPv4 API VIP"
sed "s/@API_VIP@/$vip/g" "$controlplane_patch" > "$work/controlplane.patch.yaml"

ips=()
while IFS=$'\t' read -r node ip; do
  ips+=("$ip")
  cat > "$work/hostname.patch.yaml" <<EOF
apiVersion: v1alpha1
kind: HostnameConfig
hostname: $node
auto: "off"
EOF
  talosctl gen config "$cluster" "https://$vip:6443" \
    --talos-version "$talos_version" --kubernetes-version "$kubernetes_version" \
    --with-secrets "$work/secrets.yaml" --with-examples=false --with-docs=false \
    --install-image "factory.talos.dev/metal-installer/$schematic:$talos_version" \
    --config-patch-control-plane "@$work/controlplane.patch.yaml" \
    --config-patch-control-plane "@$work/hostname.patch.yaml" \
    --output-types controlplane --output "$work/$ip.yaml"
  talosctl validate --mode metal --config "$work/$ip.yaml"
done < <(jq -r '.nodes | to_entries[] | [.key, .value.ip] | @tsv' "$inventory")
[[ ${#ips[@]} == 3 ]] || die "expected exactly three Talos nodes"

talosctl gen config "$cluster" "https://$vip:6443" \
  --talos-version "$talos_version" --with-secrets "$work/secrets.yaml" \
  --output-types talosconfig --output "$work/talosconfig"
talosctl --talosconfig "$work/talosconfig" config endpoint "${ips[@]}"
mv "$work/talosconfig" "$talosconfig"

on_node() {
  local ip="$1"
  shift
  talosctl --talosconfig "$talosconfig" --endpoints "$ip" --nodes "$ip" "$@"
}

wait_for() {
  local attempt
  for ((attempt=1; attempt<=30; attempt++)); do
    if "$@" >/dev/null 2>&1; then
      return 0
    fi
    sleep 5
  done
  "$@"
}

configured() { on_node "$1" get machinestatus; }
maintenance_disks() { talosctl --nodes "$1" get disks --insecure -o json; }
storage_mounted() {
  on_node "$1" get mountstatus u-longhorn -o json |
    jq -es 'any(.[]; .spec.target == "/var/mnt/longhorn")'
}

for ip in "${ips[@]}"; do
  if configured "$ip" >/dev/null 2>&1; then
    echo "$ip already accepts the prod Talos credentials; leaving its config alone."
    continue
  fi
  # Maintenance mode accepts unauthenticated config. Check both intended disks
  # before sending secrets or allowing the installer to write anything.
  wait_for maintenance_disks "$ip"
  maintenance_disks "$ip" | jq -es '
    (map(select(.spec.serial == "talos-os")) | length == 1)
    and (map(select(.spec.serial == "talos-longhorn")) | length == 1)' >/dev/null ||
    die "$ip does not expose the two expected Talos disks"
  talosctl --nodes "$ip" apply-config --insecure --file "$work/$ip.yaml"
done

for ip in "${ips[@]}"; do
  wait_for configured "$ip"
done

initialized=false
all_preparing=true
for ip in "${ips[@]}"; do
  # `etcd members` can block while etcd waits for bootstrap. The Talos service
  # status is available through the management API before etcd starts.
  status="$(on_node "$ip" service etcd)"
  etcd_state="$(awk '$1 == "STATE" { print $2 }' <<< "$status")"
  echo "etcd on $ip: ${etcd_state:-unknown}"
  case "$etcd_state" in
    Running) initialized=true; all_preparing=false ;;
    Preparing) ;;
    *) all_preparing=false ;;
  esac
done
if [[ "$initialized" == false ]]; then
  [[ "$all_preparing" == true ]] ||
    die "etcd is not ready to bootstrap on all three nodes; inspect Talos service status before retrying"
  # Record before sending the request, so a lost reply does not cause a second
  # bootstrap on the next run. Never remove this marker as part of a retry.
  (set -o noclobber; : > "$marker") 2>/dev/null ||
    die "etcd bootstrap was already attempted; inspect etcd before any manual retry"
  echo "Bootstrapping etcd on ${ips[0]}."
  on_node "${ips[0]}" bootstrap
fi

talosctl --talosconfig "$talosconfig" health --nodes "${ips[0]}" \
  --control-plane-nodes "$(IFS=,; echo "${ips[*]}")" --wait-timeout=10m
for ip in "${ips[@]}"; do
  wait_for storage_mounted "$ip" || die "$ip has no mounted Longhorn data volume"
done
on_node "${ips[0]}" kubeconfig "$work/talos-kubeconfig" --merge=false
kubectl --kubeconfig "$work/talos-kubeconfig" --context "admin@$cluster" \
  wait --for=condition=Ready node/talos-prod-01 node/talos-prod-02 node/talos-prod-03 --timeout=180s
mv "$work/talos-kubeconfig" "$state_dir/talos-kubeconfig"
