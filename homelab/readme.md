# Homelab

Infrastructure and Kubernetes configuration for the **homelab**, managed alongside application code in this monorepo.

The setup separates VM provisioning, cluster bootstrap, and Kubernetes workloads. Development is migrating from kind to a local Talos QEMU VM before configuration is promoted to the prod cluster through Git and Flux.

## Folder structure

```text
homelab/
├── bootstrap/                  # Cluster installation and initial setup
├── terraform/
│   └── proxmox/                # Proxmox VM provisioning
└── k8s/
    ├── apps/                   # Application manifests and environment overlays
    │   └── <app>/              # Shared base plus cluster-specific overlays
    │       ├── base/
    │       └── overlays/
    │           ├── dev/
    │           └── prod/
    ├── clusters/
    │   ├── dev/
    │   │   ├── talos/          # Local Talos QEMU configuration
    │   │   ├── kind.yaml       # Retained kind cluster configuration during migration
    │   │   └── flux/           # Dev Flux root and selected declarations
    │   └── prod/
    │       ├── flux-platform/  # Initial prod platform-only reconciliation
    │       └── flux/           # Existing prod app selection; not applied by prod:flux
    └── platform/               # Shared cluster services and controllers
        ├── flux/install/       # Pinned Flux controller and CRD bundle
        ├── gateway-api/        # Cluster-wide Gateway API CRDs
        ├── external-secrets/   # External Secrets Operator
        └── traefik/            # Traefik controller and Gateway
```

This tree summarizes the directory layout rather than listing every manifest.

## Responsibilities

### Infrastructure: `terraform/proxmox/`

Provisions the VMs that will host the prod Kubernetes cluster.

Intended responsibilities include VM resources, disks, network configuration, and initial VM settings. Kubernetes application deployment belongs under `k8s/`, not Terraform.

### Cluster bootstrap: `bootstrap/`

Contains the automation needed to turn provisioned VMs into a working Kubernetes cluster.

Intended responsibilities include installing Kubernetes, joining nodes, configuring cluster access, and initially installing Flux.

### Kubernetes configuration: `k8s/`

Describes the workloads and platform services that run inside each cluster.

- `apps/`: cluster-agnostic app resources in each app's `base/`, with only cluster-specific changes in its `overlays/<cluster>/` directories.
- `platform/`: cluster services such as routing controllers, certificate management, and operators.
- `clusters/<cluster>/flux/`: cluster-specific Flux bootstrap root and the Flux
  `Kustomization` declarations selecting apps and platform components.
- `platform/flux/install/`: pinned Flux installation manifests only.

## Environments

### Development

Runs locally on the MacBook using a Talos QEMU VM. The existing kind cluster is retained during migration and remains the Flux target until Talos validation is complete.

- Talos configuration: `k8s/clusters/dev/talos/`
- Legacy kind configuration: `k8s/clusters/dev/kind.yaml`
- Flux entry point: `k8s/clusters/dev/flux/`
- Application customizations: `k8s/apps/*/overlays/dev/`

This environment is disposable and intended for testing manifests, images, and Kubernetes behaviour. Dev Flux bootstrap targets the Talos cluster through its local kubeconfig.

The dev apps use a separate PostgreSQL 15.17 instance running in OrbStack
Docker, not the production database. Start it before using database-backed dev
apps:

```shell
docker compose -f homelab/k8s/clusters/dev/external/postgres/docker-compose.yaml up -d
```

The Compose service publishes port `15432` on the Mac; the dev Kubernetes
Service forwards port `5432` to it. Its named Docker volume persists data across
container restarts and `docker compose down`. Use `docker compose down -v` only
when you intend to delete the dev database data. Dev-only credentials are in
the Compose file and must not be reused in production.

Create the Talos QEMU cluster and seed the 1Password token:

```shell
bazel run //homelab/k8s/clusters/dev:up
```

`up` provisions one Talos control-plane node, makes it schedulable for dev
workloads, waits for it, and seeds the out-of-band 1Password Service Account
token. It needs QEMU, `talosctl`, `kubectl`, `curl`, `jq`, a signed-in `op`
session, and sudo authorization. Talos/kubeconfig credentials are stored under
the ignored `k8s/clusters/dev/.state/`; QEMU VM state is under
`~/.talos/homelab-dev-qemu` to keep QEMU socket paths short enough for macOS.
The cluster uses `10.200.0.0/24` to avoid overlapping with the connected Tailscale
route at `10.5.0.0/24`.
`bazel run //homelab/k8s/clusters/dev:down` destroys only this Talos cluster;
it leaves the old kind cluster intact.

Longhorn 1.13.0 is installed by Flux from the pinned upstream Kubernetes
manifest under `k8s/platform/longhorn/`; the dev and prod overlays use the
`longhorn` StorageClass as the cluster default. Dev uses one replica because it
has one node. The Talos dev node includes the required iSCSI/util-linux
extensions, privileged pod-security labels, and kubelet mount for
`/var/mnt/longhorn`. The dev cluster is disposable, so Longhorn data on its
current VM disk is not durable across cluster destruction.

Do not run the `flux` target until any old kind Flux reconciliation has been
deliberately stopped and the cutover is ready; the target installs Flux on Talos
using `.state/talos-kubeconfig`. The pinned Flux release requires
Kubernetes 1.35.2 or newer; Talos dev uses Kubernetes 1.35.8.

`up` bootstraps the 1Password Service Account token after starting Talos. Create a
Service Account for the intended vault and store its token in a privileged
1Password item that the Service Account cannot read. This step only seeds the
token Secret; no SecretStore, ExternalSecret, or certificate resources are
installed yet.

The bootstrap helper requires the 1Password CLI to be signed in, plus `op`,
`jq`, and `kubectl` on `PATH`. If token seeding fails, `up` exits before Flux
installation; fix the reported issue and rerun `up`.
The default 1Password field label is `credential`; pass another field label to
`up` after `--` if needed:

```shell
bazel run //homelab/k8s/clusters/dev:up -- token
```

The helper targets the dev context using the local kubeconfig and `Private` vault. It
looks up the item's `credential` field by name, checks the 1Password CLI session
with `op whoami`, and requires `op`, `jq`, and `kubectl`. For prod, set its
context and vault before running the same helper with the prod item name:

```shell
HOMELAB_PROD_CONTEXT='<prod-kubectl-context>' \
HOMELAB_PROD_VAULT='<prod-1password-vault>' \
  homelab/k8s/scripts/bootstrap-1password-token.sh prod '<prod-service-account-item>'
```

Prod uses `HOMELAB_PROD_KUBECONFIG` if set, otherwise `~/.kube/config`. The
helper writes the token only to a temporary file and creates the bootstrap
Secret in the cluster; the token is not stored in Git. Keep separate Service
Accounts and token items for dev and prod.

Inspect and reconcile Flux resources with the dev kubeconfig selected:

```shell
export KUBECONFIG="$PWD/homelab/k8s/clusters/dev/.state/talos-kubeconfig"
flux get sources all
flux get kustomizations -A
flux reconcile kustomization <name> -n flux-system --with-source
```

Select Talos for dev work, or the retained kind cluster for its existing
Flux-managed resources during migration:

```shell
source homelab/k8s/scripts/set-context.sh dev
source homelab/k8s/scripts/set-context.sh kind
```

`dev` reads the current context from the local Talos kubeconfig. `kind` selects
the old kind kubeconfig. For prod, set `HOMELAB_PROD_CONTEXT` (and optionally
`HOMELAB_PROD_KUBECONFIG`) first, then source `set-context.sh prod`. Do not
execute the script directly: a child process cannot set `KUBECONFIG` in its
parent shell.

#### Traefik

Connect to admin panel

```shell
kubectl --context kind-homelab-dev -n traefik port-forward deployment/traefik 9001:9001
```

### Prod

OpenTofu manages three VMs on Biggie, each with 2 vCPUs, 4 GiB RAM, a 32 GiB
OS disk, and a 48 GiB Longhorn disk. All three are schedulable Talos control
planes. etcd and the three Longhorn replicas can tolerate one VM going
down, but all replicas share one physical host and NVMe. The Proxmox boot
mirror is degraded and its repair is deferred. Keep an off-host recovery
plan before migrating production data.

#### LAN addressing

The VMs use untagged `vmbr0`. UniFi serves DHCP from `192.168.4.6` through
`192.168.4.254`; the Talos VM MACs below match the UniFi reservations and
`terraform/proxmox/cluster.json`.

| Address | Assignment | Type |
| --- | --- | --- |
| `192.168.4.1` | UniFi gateway | Existing |
| `192.168.4.4` | Kubernetes API, TCP `6443` | Talos Layer 2 VIP, outside DHCP |
| `192.168.4.5` | Traefik app ingress, TCP `80`/`443` | Planned separate LAN service IP, outside DHCP |
| `192.168.4.63` | Tailscale LXC | Existing |
| `192.168.4.187` | `pods` VM | Existing; not managed by OpenTofu |
| `192.168.4.199` | Unraid VM | Existing |
| `192.168.4.200` | Biggie Proxmox host | Existing |
| `192.168.4.201` | Proxmox Backup Server VM | Existing |
| `192.168.4.210` | `talos-prod-01` (VM `210`) | DHCP reservation: `02:54:41:4c:04:d2` |
| `192.168.4.211` | `talos-prod-02` (VM `211`) | DHCP reservation: `02:54:41:4c:04:d3` |
| `192.168.4.212` | `talos-prod-03` (VM `212`) | DHCP reservation: `02:54:41:4c:04:d4` |
| `192.168.4.222` | PostgreSQL LXC | Existing; leave in place |
| `192.168.4.223` | MySQL LXC | Existing |

`kubectl` uses `.4`; `talosctl` uses the three node addresses directly for
bootstrap and recovery. No kube-vip or Tailscale Operator is needed for this
setup. For app cutover, add individual LAN DNS records for `<app>.brodsky.club`
pointing to `.5`, starting with a smoke-test name. Keep public app addresses
and WAN forwarding disabled. Use dev's cert-manager workflow (Cloudflare
DNS-01 with Let's Encrypt staging first, then trusted issuance) with a separate
prod `*.brodsky.club` certificate. ESO will read the prod Cloudflare token from
`homelab-prod`. The Traefik service load balancer, certificate, and smoke-test
route are not enabled by the initial platform bootstrap.

#### Prerequisites

- On the operator Mac, install OpenTofu `1.13.9`, `talosctl` compatible with
  Talos `1.14.x`, `kubectl`, `jq`, and the 1Password CLI. Sign in to `op`.
- Trust Biggie's Proxmox cluster CA on the Mac before running OpenTofu. Get
  `/etc/pve/pve-root-ca.pem` from Biggie over trusted SSH. The API endpoint is
  `https://192.168.4.200:8006/`; do not disable certificate verification.
- Biggie needs `local:iso/talos-metal-amd64.iso`, the Talos Image Factory
  `v1.14.6` standard amd64 ISO for the schematic in `cluster.json`. The
  uploaded ISO and a fresh Image Factory download both hashed to
  `c746f7f7035b9b603417beedecb3612fd5ee52938cd51c7f7a3b1639f4e05ba3`.
  The VMs use OVMF without Secure Boot. The matching installer retains
  `iscsi-tools`, `util-linux-tools`, and `qemu-guest-agent`.
- Give both `rofu@pve` and its privilege-separated token `rofu@pve!homelab`
  scoped grants: allocate, configure, audit and power-manage only `/vms/210`
  through `/vms/212`; audit and allocate space on `/storage/biggie-npool`;
  audit `/storage/local`; use `/sdn/zones/localnetwork/vmbr0`; and read
  `/nodes/biggie`. No root or provider SSH credentials are required.
- In the operator-only **Selfhosted** vault, use `rofu@pve` with fields
  `token-id` (the full token ID) and `token-secret`. Add
  `homelab-prod-opentofu` with a strong random `passphrase` (at least 16
  characters) and `homelab-prod-service-account` with a `credential` field.
  This service account must have read access to **homelab-prod** only, not
  Selfhosted.
- Generate the prod Talos secrets bundle **once**, as a 1Password Document.
  Do not regenerate it for retries or recovery. From a Bash shell:

  ```bash
  set -o pipefail
  talosctl gen secrets --talos-version v1.14.6 --output-file - |
    op document create - --vault Selfhosted \
      --title homelab-prod-talos-secrets --file-name secrets.yaml
  ```

#### Bring-up

From the monorepo root, run each step separately:

```shell
bazel run //homelab/k8s/clusters/prod:plan
bazel run //homelab/k8s/clusters/prod:up
bazel run //homelab/k8s/clusters/prod:flux
```

1. `plan` saves an encrypted plan. Review it: the initial plan should create
   only the three Talos VMs. `up` accepts only VM creation and no-op changes,
   and requires a typed confirmation. There is no prod `down` target.
2. `up` applies the saved plan, then uses `talosctl` to configure the VMs from
   `k8s/clusters/prod/talos/controlplane.patch.yaml`, the node inventory, and
   the 1Password secrets bundle. It bootstraps etcd, verifies the cluster, and
   seeds the ESO token using the generated prod kubeconfig. If VM creation
   succeeded but bootstrap or token seeding failed, use
   `bazel run //homelab/k8s/clusters/prod:up -- --resume`.
   If VM creation itself failed, review a fresh plan instead. If etcd bootstrap
   was attempted but no member now responds, inspect etcd before attempting
   recovery; the script intentionally refuses to bootstrap a second time.
3. Once the platform manifests are on `main`, `flux` installs the pinned Flux
   bundle and reconciles `k8s/clusters/prod/flux-platform/` (Gateway API,
   ESO, cert-manager, and Longhorn). It does **not** apply the existing app
   selection at `k8s/clusters/prod/flux/`. Bring over apps and DNS records
   explicitly, without running both environments against the same data.

OpenTofu state and plans, the bootstrap marker, and generated admin configs
are in the ignored `k8s/clusters/prod/.state/`. Back up the encrypted
`proxmox.tfstate` off-host and keep the passphrase recoverable in 1Password.
For the context helper, use `HOMELAB_PROD_CONTEXT=admin@homelab-prod-talos` and
set `HOMELAB_PROD_KUBECONFIG` to that directory's `talos-kubeconfig`.

## Authentication

Authelia is configured as the shared authentication provider for cluster apps.
Its dev manifests are not yet reconciled. Manage its Kubernetes resources with
Kustomize and Flux; do not use Helm.

- Start in dev with Authelia's file authentication backend and SQLite storage.
  SQLite is an embedded database, so this does not require a separate database
  server. Persist its database file on a Longhorn PVC. Dev Longhorn data is
  lost when the disposable dev cluster is destroyed.
- Linkding is the first planned client, using native OIDC with Authelia at
  `auth.dev.brodsky.club`. Do not add other app integrations until this test is
  validated.
- For production, use PostgreSQL for Authelia storage. This is the intended
  backend but is not deployed; production database provisioning and
  session-storage requirements must be addressed before promotion.
- Keep the file user database and Authelia secret values out of Git; store them
  in 1Password and synchronize them with External Secrets Operator.

The dev ExternalSecret expects these fields in the `authelia-dev` item in the
`homelab-dev` 1Password vault:

| Field | Contents |
| --- | --- |
| `users-database` | Authelia YAML user database, including the user email used by Linkding |
| `session-secret` | Random session signing secret |
| `storage-encryption-key` | Random SQLite encryption key |
| `reset-password-jwt-secret` | Random alphanumeric secret of at least 64 characters; required by Authelia even when password reset is disabled |
| `oidc-hmac-secret` | Random OIDC HMAC secret |
| `oidc-issuer-private-key.pem` | PEM-encoded RSA private key uploaded as a file attachment for signing OIDC tokens |
| `linkding-client-secret` | Raw OIDC client secret consumed by Linkding |
| `linkding-client-secret-hash` | PBKDF2-SHA512 hash of that same OIDC client secret, consumed by Authelia |

Populate every field before reconciling the dev Authelia Flux Kustomization;
the ExternalSecret health check keeps that Kustomization from becoming Ready
until the fields are available.

Generate the reset-password JWT secret and save its output in the
`reset-password-jwt-secret` field:

```shell
openssl rand -hex 32
```

Generate user password hashes with the pinned Authelia image, entering the
password at the interactive prompt rather than putting it in shell history:

```shell
docker run --rm -it authelia/authelia:4.39.28 authelia crypto hash generate argon2
```

Generate the Linkding client secret hash the same way, using the PBKDF2-SHA512
algorithm, and put the raw secret and its hash in their respective 1Password
fields:

```shell
docker run --rm -it authelia/authelia:4.39.28 authelia crypto hash generate pbkdf2 --variant sha512
```

Generate the OIDC signing key with OpenSSL and upload the PEM output as the
`oidc-issuer-private-key.pem` file attachment at the top level of the
`authelia-dev` item (not inside a named section):

```shell
openssl genpkey -algorithm RSA -pkeyopt rsa_keygen_bits:2048
```

## Workflow

Initial prod-cluster setup:

```text
Provision VMs → Bootstrap Kubernetes → Install Flux → Deploy from Git
```

Ongoing development:

```text
Edit manifests → Test in dev → Update prod configuration → Merge → Flux reconciles
```

Share application configuration between environments where practical. Keep differences such as image references, hostnames, resource sizing, and storage choices in environment overlays.

Promote configuration through Git rather than copying live cluster state. Keep credentials, kubeconfigs, Terraform state, and other generated local files out of version control.
