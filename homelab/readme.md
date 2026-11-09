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
    ├── kustomization.yaml       # Dev post-secret Flux declaration aggregator
    ├── apps/                   # Application manifests and environment overlays
    │   ├── kustomization.yaml  # Home Flux declaration aggregator
    │   └── whoami/
    │       └── overlays/
    │           └── dev/        # Local routing test application
    ├── clusters/
    │   ├── dev/
    │   │   ├── kind.yaml       # Local kind cluster configuration
    │   │   └── apps/           # Local application selection
    │   └── home/
    │       └── apps/           # Home cluster application selection
    └── platform/               # Shared cluster services and controllers
        ├── kustomization.yaml   # Initial dev platform Flux declaration aggregator
        ├── flux/               # Flux install and cluster bootstrap sources
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

- `apps/`: application resources and per-app Flux declarations under each overlay's `flux/` directory; the `apps/kustomization.yaml` root aggregates the home app declarations.
- `platform/`: cluster services such as routing controllers, certificate management, and operators.
- `clusters/`: environment entry points that select which applications and configuration to deploy.
- `platform/flux/`: Flux installation, sources, and cluster bootstrap configuration.
- Each app and platform component has a `flux/` subdirectory containing its Flux
  `Kustomization` declaration; the existing workload `kustomization.yaml` files
  remain unchanged. The two aggregation roots select pre- and post-secret dev
  declarations without making either stage consume the other.

## Environments

### Development

Runs locally on the MacBook using kind.

- Cluster configuration: `k8s/clusters/dev/kind.yaml`
- Application entry point: `k8s/clusters/dev/apps/`
- Application customizations: `k8s/apps/*/overlays/dev/`

This environment is disposable and intended for testing manifests, images, and Kubernetes behaviour.

Create the kind cluster and bootstrap Flux. Flux installs the CRDs and platform
controllers first. After ESO is ready, seed its 1Password token and explicitly
activate the dependent stage:

```shell
bazel run //homelab/k8s/clusters/dev:up
bazel run //homelab/k8s/clusters/dev:flux
bazel run //homelab/k8s/clusters/dev:secret
bazel run //homelab/k8s/clusters/dev:activate
```

`up` creates the cluster and kubeconfig. `flux` applies the official Flux
v2.10.0 controller and CRD bundle using `kubectl`, then waits for Gateway API
CRDs, ESO, and cert-manager. `secret` seeds the out-of-band 1Password Service
Account token. `activate` verifies that Secret exists, then activates
the GitOps stage that syncs the Cloudflare token, validates staging, requests
the production certificate, and deploys Traefik and apps. Flux reads the public
GitHub repository over HTTPS; no GitHub write token is required. Flux only sees
committed changes on `main`, so push the Flux manifests to `main` before
bootstrapping. Use `bazel run //homelab/k8s/clusters/dev:down` to stop/delete
the cluster. The pinned Flux release requires Kubernetes 1.35.2 or newer; kind
nodes are pinned accordingly. kind does not upgrade an existing cluster when
`kind.yaml` changes, so recreate an older dev cluster deliberately before
installing Flux v2.10.0.

Bootstrap the 1Password Service Account token after starting kind. Create a
Service Account for the intended vault and store its token in a privileged
1Password item that the Service Account cannot read. This step only seeds the
token Secret; no SecretStore, ExternalSecret, or certificate resources are
installed yet.

```shell
homelab/k8s/scripts/bootstrap-1password-token.sh dev homelab-dev-service-account
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

After activation, Flux applies dev apps after Traefik is Ready. Inspect and
reconcile stages with the dev kubeconfig selected:

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

To bootstrap the dev cluster's 1Password token using the configured dev
context, vault, and item, run:

```shell
bazel run //homelab/k8s/clusters/dev:secret
```

You can optionally pass a different field label after `--`; the default is
`credential`:

```shell
bazel run //homelab/k8s/clusters/dev:secret -- credential
```

### Home

Runs on Proxmox VMs.

- Infrastructure configuration: `terraform/proxmox/`
- Existing home app-selection Kustomize entry point: `k8s/clusters/home/apps/`
- Flux reconciles each home app overlay from `k8s/apps/` independently.
- Application customizations: `k8s/apps/*/overlays/home/`
- Flux bootstrap configuration: `k8s/platform/flux/home/bootstrap/`

Apply the pinned Flux controller and CRD bundle, then apply the bootstrap
Kustomize root. These steps use `kubectl` and do not require the Flux CLI. They
point Flux at the public monorepo and reconcile the home apps path:

```shell
kubectl apply -k homelab/k8s/platform/flux/install
kubectl apply -k homelab/k8s/platform/flux/home/bootstrap
```

The home bootstrap currently reconciles the existing apps path; it does not
move home platform services under Flux or configure home 1Password resources.
The Flux CLI remains optional for status and reconciliation commands.

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
