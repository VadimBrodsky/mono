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
    │   └── demo/
    │       ├── base/           # Shared application resources
    │       └── overlays/
    │           ├── dev/        # Local development customizations
    │           └── home/       # Home cluster customizations
    ├── argocd/                 # Argo CD Application definitions
    ├── clusters/
    │   ├── dev/
    │   │   ├── kind.yaml       # Local kind cluster configuration
    │   │   └── apps/           # Local application selection
    │   └── home/
    │       └── apps/           # Home cluster application selection
    └── platform/               # Shared cluster services and controllers
```

This tree summarizes the directory layout rather than listing every manifest. The `bootstrap/`, `terraform/proxmox/`, and `k8s/platform/` directories are currently placeholders.

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
