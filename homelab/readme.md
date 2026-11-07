# Homelab

Infrastructure and Kubernetes configuration for the **homelab**, managed alongside application code in this monorepo.

The setup separates VM provisioning, cluster bootstrap, and Kubernetes workloads. A local kind cluster provides an environment for experimentation before promoting configuration to the home cluster through Git and Argo CD.

## Folder structure

```text
homelab/
├── bootstrap/                  # Cluster installation and initial setup
├── terraform/
│   └── proxmox/                # Proxmox VM provisioning
└── k8s/
    ├── apps/                   # Application manifests and environment overlays
    │   └── whoami/
    │       └── overlays/
    │           └── dev/        # Local routing test application
    ├── argocd/                 # Argo CD Application definitions
    ├── clusters/
    │   ├── dev/
    │   │   ├── kind.yaml       # Local kind cluster configuration
    │   │   └── apps/           # Local application selection
    │   └── home/
    │       └── apps/           # Home cluster application selection
    └── platform/               # Shared cluster services and controllers
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

Intended responsibilities include installing Kubernetes, joining nodes, configuring cluster access, and initially installing Argo CD.

### Kubernetes configuration: `k8s/`

Describes the workloads and platform services that run inside each cluster.

- `apps/`: application resources, with shared configuration and environment-specific overlays.
- `platform/`: cluster services such as routing controllers, certificate management, and operators.
- `clusters/`: environment entry points that select which applications and configuration to deploy.
- `argocd/`: Application definitions that connect Git paths to deployment destinations.

## Environments

### Development

Runs locally on the MacBook using kind.

- Cluster configuration: `k8s/clusters/dev/kind.yaml`
- Application entry point: `k8s/clusters/dev/apps/`
- Application customizations: `k8s/apps/*/overlays/dev/`

This environment is disposable and intended for testing manifests, images, and Kubernetes behaviour.

```shell
# start the kind cluster
bazel run //homelab/k8s/clusters/dev:up

# stop the kind cluster
bazel run //homelab/k8s/clusters/dev:down
```

The startup command installs the Gateway API CRDs and External Secrets
Operator using pinned Kustomize manifests and server-side apply. It waits for
their CRDs and ESO deployments to become ready. The startup command requires
network access to download the pinned release bundles and reapplies them when
run against an existing cluster.

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

Install Traefik and then apply the dev app resources:

```shell
kubectl --kubeconfig homelab/k8s/clusters/dev/.state/kubeconfig \
  --context kind-homelab-dev apply --server-side \
  -k homelab/k8s/platform/traefik/overlays/dev

kubectl --kubeconfig homelab/k8s/clusters/dev/.state/kubeconfig \
  --context kind-homelab-dev apply -k homelab/k8s/clusters/dev/apps
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

### Home

Runs on Proxmox VMs.

- Infrastructure configuration: `terraform/proxmox/`
- Application entry point: `k8s/clusters/home/apps/`
- Application customizations: `k8s/apps/*/overlays/home/`
- Argo CD Application: `k8s/argocd/home-apps.yaml`

The intended deployment model is for Argo CD to reconcile the home configuration from Git.

## Workflow

Initial home-cluster setup:

```text
Provision VMs → Bootstrap Kubernetes → Install Argo CD → Deploy from Git
```

Ongoing development:

```text
Edit manifests → Test in kind → Update home configuration → Merge → Sync with Argo CD
```

Share application configuration between environments where practical. Keep differences such as image references, hostnames, resource sizing, and storage choices in environment overlays.

Promote configuration through Git rather than copying live cluster state. Keep credentials, kubeconfigs, Terraform state, and other generated local files out of version control.
