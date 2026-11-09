# Homelab

Infrastructure and Kubernetes configuration for the **homelab**, managed alongside application code in this monorepo.

The setup separates VM provisioning, cluster bootstrap, and Kubernetes workloads. A local kind cluster provides an environment for experimentation before promoting configuration to the home cluster through Git and Flux.

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
    │           └── home/
    ├── clusters/
    │   ├── dev/
    │   │   ├── kind.yaml       # Local kind cluster configuration
    │   │   └── flux/           # Dev Flux root and selected declarations
    │   └── home/
    │       └── flux/           # Home Flux root and selected declarations
    └── platform/               # Shared cluster services and controllers
        ├── flux/install/       # Pinned Flux controller and CRD bundle
        ├── gateway-api/        # Cluster-wide Gateway API CRDs
        ├── external-secrets/   # External Secrets Operator
        └── traefik/            # Traefik controller and Gateway
```

This tree summarizes the directory layout rather than listing every manifest. The `bootstrap/` and `terraform/proxmox/` directories are currently placeholders.

## Responsibilities

### Infrastructure: `terraform/proxmox/`

Provisions the VMs that will host the home Kubernetes cluster.

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

Runs locally on the MacBook using kind.

- Cluster configuration: `k8s/clusters/dev/kind.yaml`
- Flux entry point: `k8s/clusters/dev/flux/`
- Application customizations: `k8s/apps/*/overlays/dev/`

This environment is disposable and intended for testing manifests, images, and Kubernetes behaviour.

Create the kind cluster, seed the 1Password token, then bootstrap Flux:

```shell
bazel run //homelab/k8s/clusters/dev:up
bazel run //homelab/k8s/clusters/dev:flux
```

`up` creates the cluster and kubeconfig, waits for its nodes, and seeds the
out-of-band 1Password Service Account token. `flux` applies the official Flux
v2.10.0 controller and CRD bundle using `kubectl`, then applies the dev Flux
root. Flux dependencies order Gateway API CRDs, ESO, cert-manager, the
1Password configuration, certificates, Traefik, and apps. Flux reads the public
GitHub repository over HTTPS; no GitHub write token is required. Flux only sees
committed changes on `main`, so push the Flux manifests to `main` before
bootstrapping. Use `bazel run //homelab/k8s/clusters/dev:down` to stop/delete
the cluster. The pinned Flux release requires Kubernetes 1.35.2 or newer; kind
nodes are pinned accordingly. kind does not upgrade an existing cluster when
`kind.yaml` changes, so recreate an older dev cluster deliberately before
installing Flux v2.10.0.

`up` bootstraps the 1Password Service Account token after starting kind. Create a
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
with `op whoami`, and requires `op`, `jq`, and `kubectl`. For home, set its
context and vault before running the same helper with the home item name:

```shell
HOMELAB_HOME_CONTEXT='<home-kubectl-context>' \
HOMELAB_HOME_VAULT='<home-1password-vault>' \
  homelab/k8s/scripts/bootstrap-1password-token.sh home '<home-service-account-item>'
```

Home uses `HOMELAB_HOME_KUBECONFIG` if set, otherwise `~/.kube/config`. The
helper writes the token only to a temporary file and creates the bootstrap
Secret in the cluster; the token is not stored in Git. Keep separate Service
Accounts and token items for dev and home.

Inspect and reconcile Flux resources with the dev kubeconfig selected:

```shell
export KUBECONFIG="$PWD/homelab/k8s/clusters/dev/.state/kubeconfig"
flux get sources all
flux get kustomizations -A
flux reconcile kustomization <name> -n flux-system --with-source
```

After starting the cluster, select its context in your current shell:

```shell
source homelab/k8s/scripts/set-context.sh dev
```

`up.sh` also selects `kind-homelab-dev` in the generated kubeconfig. Source
`set-context.sh dev` in each new terminal where you want kubectl to use this
cluster. For home, set `HOMELAB_HOME_CONTEXT` (and optionally
`HOMELAB_HOME_KUBECONFIG`) first, then source `set-context.sh home`. Do not
execute the script directly: a child process cannot set `KUBECONFIG` in its
parent shell.

#### Traefik

Connect to admin panel

```shell
kubectl --context kind-homelab-dev -n traefik port-forward deployment/traefik 9001:9001
```

### Home

Runs on Proxmox VMs.

- Infrastructure configuration: `terraform/proxmox/`
- Flux entry point: `k8s/clusters/home/flux/`
- Flux reconciles each selected home app overlay from `k8s/apps/` independently.
- Application customizations: `k8s/apps/*/overlays/home/`
- Flux bootstrap configuration: `k8s/clusters/home/flux/`

Apply the pinned Flux controller and CRD bundle, then apply the cluster Flux
root. These steps use `kubectl` and do not require the Flux CLI:

```shell
kubectl apply -k homelab/k8s/platform/flux/install
kubectl apply -k homelab/k8s/clusters/home/flux
```

The home Flux root selects only its declared apps. Home platform and 1Password
reconciliation remain separate from this app selection. The Flux CLI remains
optional for status and reconciliation commands.

## Workflow

Initial home-cluster setup:

```text
Provision VMs → Bootstrap Kubernetes → Install Flux → Deploy from Git
```

Ongoing development:

```text
Edit manifests → Test in kind → Update home configuration → Merge → Flux reconciles
```

Share application configuration between environments where practical. Keep differences such as image references, hostnames, resource sizing, and storage choices in environment overlays.

Promote configuration through Git rather than copying live cluster state. Keep credentials, kubeconfigs, Terraform state, and other generated local files out of version control.
