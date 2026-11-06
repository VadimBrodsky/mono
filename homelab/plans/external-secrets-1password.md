# Kubernetes secrets with ESO and 1Password

## Goal

Use External Secrets Operator (ESO) with 1Password's SDK provider to populate
Kubernetes Secrets from 1Password items. Manage ESO and its configuration with
Kustomize, not Helm. Use the same design for kind dev and the home cluster, with
separate cluster credentials and vault configuration.

Initial use case: supply cert-manager with a Cloudflare API token for DNS-01
certificate validation. The API token and ESO bootstrap token must not be
committed to Git.

## Design

- Install one pinned ESO release in each cluster from its static Kubernetes
  release manifest, composed through Kustomize. Apply CRDs server-side and
  wait for CRDs, controller, and webhook readiness before applying ESO custom
  resources.
- Use ESO's 1Password SDK provider, not the Connect provider. This avoids
  deploying a Connect server; ESO accesses 1Password using a 1Password Service
  Account token.
- Use a separate least-privilege 1Password Service Account and dedicated vault
  for each cluster (dev and home). Put the bootstrap token in a separate
  privileged 1Password location that the Service Account cannot read.
- Create the bootstrap token Secret out of band with a local helper script and
  the 1Password CLI. Never define its value in a Git manifest.
- Use a cluster-scoped store (or a namespaced store if preferred) configured
  for that cluster's vault. Reference the bootstrap Secret from the store.
- Commit `ExternalSecret` resources that name the 1Password item/field and the
  destination Kubernetes Secret. The secret value remains in 1Password and is
  fetched by ESO; the generated Kubernetes Secret is consumed by workloads or
  controllers.

## Proposed repository layout

Adapt names to existing cluster conventions during implementation:

```text
homelab/k8s/platform/external-secrets/
  base/                         # pinned ESO release manifest / Kustomization
  overlays/dev/                 # dev-specific install settings if required
  overlays/home/                # home-specific install settings if required

homelab/k8s/platform/onepassword/
  base/                         # common store/ExternalSecret patterns if useful
  overlays/dev/                 # dev vault and item references
  overlays/home/                # home vault and item references

homelab/k8s/clusters/dev/
  bootstrap-secrets.sh          # or a shared script invoked with "dev"
homelab/k8s/clusters/home/
  bootstrap-secrets.sh          # or the same shared script invoked with "home"
```

The bootstrap scripts and public configuration may be committed. No token,
Cloudflare credential, or rendered Kubernetes Secret data may be committed.

## Bootstrap workflow

1. Create the cluster and install ESO's pinned Kustomize target. For kind, add
   this to the platform bootstrap sequence; home gets the same component from
   its cluster setup/GitOps entry point.
2. Wait for ESO CRDs and workloads to be ready.
3. On a trusted Mac, sign in to 1Password CLI and run the bootstrap helper with
   an explicit environment/context (`dev` or `home`).
4. The helper reads the matching Service Account token from 1Password into a
   short-lived, permission-restricted temporary file, then creates or updates
   the bootstrap Kubernetes Secret using `kubectl --dry-run=client` piped to
   `kubectl apply`. It must not print or log the token, use shell tracing, or
   leave files in the repository.
5. Argo CD applies the cluster's SecretStore/ClusterSecretStore and
   ExternalSecret resources only after ESO is ready and the bootstrap token
   Secret exists. Use sync waves or separate applications/stages to enforce
   this dependency.
6. ESO fetches the referenced 1Password item and creates the target Secret.
   cert-manager issuer/certificate resources are applied after the Cloudflare
   token Secret is synchronized.

For a rebuild, repeat steps 1-5. Store the one-time-created Service Account
token securely in 1Password so the bootstrap helper can retrieve it. If the
token is revoked or replaced, update the bootstrap Secret and restart/reconcile
ESO as needed.

## Dev and home configuration

- **Dev:** its own Service Account, vault, bootstrap Secret, and store; Cloudflare
  item/permissions scoped to dev needs. Used with `kind.brodsky.club` and
  `*.kind.brodsky.club` certificate requests.
- **Home:** separate Service Account, vault, bootstrap Secret, and store. Used
  with production `brodsky.club` names and certificates.
- Keep the manifest structure and secret field mapping consistent; only
  environment-specific vault/item names, store references, and certificate
  hostnames should differ.

## Validation and operational notes

- Pin ESO and provider-compatible versions; verify the selected release asset,
  namespace assumptions, SDK provider support, and API schema before rollout.
- Use server-side apply for ESO CRDs (the ESO docs warn that CRDs exceed the
  client-side apply annotation limit).
- Verify the `ExternalSecret` becomes Ready and the resulting Kubernetes
  Secret has the expected key, without printing its value.
- Test Cloudflare DNS-01 against Let's Encrypt staging before production.
- Existing Kubernetes Secrets remain available if 1Password or ESO is
  temporarily unavailable; new values and rotations won't sync until service
  recovers.
- ESO-created values are ordinary Kubernetes Secrets. Restrict Kubernetes
  RBAC and protect etcd and cluster backups separately.
- Keep 1Password Service Account credentials outside the vault the same
  Service Account can access. Use a dedicated, least-privilege vault and
  document token revocation/replacement.

## References

- [ESO installation](https://external-secrets.io/latest/introduction/getting-started/)
- [ESO 1Password SDK provider](https://external-secrets.io/latest/provider/1password-sdk/)
- [1Password Service Accounts](https://www.1password.dev/service-accounts/get-started)
- [1Password Kubernetes integrations](https://www.1password.dev/k8s/integrations)
