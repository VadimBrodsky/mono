# Replace Argo CD configuration with Flux

## Goal

Remove the placeholder Argo CD configuration under `homelab/k8s/argocd/` and
use Flux CD to reconcile this public GitHub monorepo. Keep the existing
Kustomize manifests as the source of truth, and make dev bootstrap ordering
reliable, including the manual 1Password token step.

## Design

- Bootstrap Flux against the public GitHub repository and the `main` branch;
  no Git credentials are needed for read-only access. Confirm the final
  repository URL during implementation. The repository URL is
  `https://github.com/VadimBrodsky/mono.git`.
- Pin the Flux controller installation to the latest stable release from the
  official release docs at implementation time. The current latest is
  `v2.10.0`; the dev kind nodes must run Kubernetes `v1.35.2` or newer to meet
  that release's compatibility requirements. The CLI is optional.
- Keep Flux installation/bootstrap distinct from the Kustomize paths Flux
  reconciles. Use a small cluster-specific Flux root for home and dev, with
  `GitRepository` and `Kustomization` resources.
- Install Flux from the official, pinned v2.10.0 controller/CRD manifest bundle
  through Kustomize and `kubectl`; the Flux CLI is optional and is not a
  bootstrap dependency.
- Keep all cluster-specific Flux declarations in a single
  `homelab/k8s/clusters/<cluster>/flux/` root. The root selects that cluster's
  apps and platform components; `platform/flux/` contains only the pinned Flux
  installation bundle.
- Keep shared application resources at `homelab/k8s/apps/<app>/base/`; use
  `overlays/<cluster>/` only for cluster-specific workload changes.
- Use Flux `Kustomization.spec.dependsOn`, readiness checks, and health checks
  to enforce dependencies. A dependency should become Ready only when the
  relevant CRDs/controllers or workloads are actually healthy.
- Keep all credentials and rendered Secret data out of Git.

## Proposed repository layout

```text
homelab/k8s/platform/flux/
  install/                       # pinned Flux controller/CRD installation only

homelab/k8s/clusters/dev/flux/
  kustomization.yaml             # one cluster-specific Flux root
  sync.yaml                      # GitRepository and root reconciliation object
  ...                            # dev platform and app Flux declarations

homelab/k8s/clusters/home/flux/
  kustomization.yaml             # home cluster Flux root and app selection
  ...                            # home app Flux declarations

homelab/k8s/apps/<app>/
  base/                          # shared app resources
  overlays/<cluster>/            # cluster-specific workload changes
```

Each cluster Flux root reconciles its own selected app overlays. The dev root
also declares platform dependencies and orders their reconciliation before
apps. Home platform configuration remains separate until its 1Password and
Traefik resources are managed in-repository.

## Dev dependency and bootstrap sequence

1. Run `up.sh` to create the kind cluster, wait for nodes, and run
   `bootstrap-1password-token.sh` for the dev service account item.
2. Install Flux and apply `clusters/dev/flux/`, configured for the public GitHub
   source. The 1Password token Secret already exists before Flux starts.
3. Flux reconciles Gateway API CRDs, ESO, and cert-manager. Keep CRD
   installations separate from their custom resources. Flux dependencies wait
   for the controllers/webhooks to be healthy before dependents proceed.
4. Flux reconciles the ESO 1Password store and Cloudflare `ExternalSecret`,
   waiting for the generated Cloudflare token Secret to become Ready.
5. Reconcile the staging issuer and certificate. Production issuer and
   certificate depend on the staging stage being Ready, preserving the current
   validation gate and avoiding an early production ACME request.
6. Reconcile Traefik after the production TLS Secret exists, then reconcile
   dev apps after the required platform services are ready.

For a fresh cluster rebuild, repeat the sequence from step 1. `up.sh` refreshes
the token Secret before Flux is installed or starts reconciliation.

## Home cluster

- Replace the Argo CD `home-apps` Application with per-app Flux Kustomizations
  in `clusters/home/flux/`.
- Ensure the home Flux bootstrap uses the public monorepo URL and the intended
  branch/path. Preserve existing home app overlays and their behavior.
- If home platform resources are brought under Flux as part of this work,
  define their CRD/controller dependencies explicitly and retain the separate
  home 1Password bootstrap step. Do not make home depend on the dev cluster's
  activation or credentials.

## Implementation checklist

1. [x] Add Flux bootstrap and source/reconciliation manifests for home and dev.
2. [x] Define separate Flux Kustomizations for CRD/controller installation and
   resources that consume those CRDs. Add health checks/readiness criteria for
   Gateway API, ESO, cert-manager, and Traefik as appropriate.
3. [x] Make dev `up` create the cluster and seed the 1Password token before Flux
   installation; remove separate `secret` and `activate` targets.
4. [x] Update dev Bazel targets and bootstrap instructions to reflect the
   combined cluster/token bootstrap followed by Flux installation.
5. [x] Remove `homelab/k8s/argocd/home-apps.yaml` and the obsolete Argo CD directory
   (including `.keep`). Remove Argo-specific references from relevant plans and
   documentation, replacing the Argo sync-wave description in
   `homelab/plans/external-secrets-1password.md` with the Flux staged dependency
   workflow.
6. [x] Document operational commands for checking Flux source, Kustomization
   readiness, retrying reconciliation, and rebuilding dev.
7. [x] Move cluster-specific Flux declarations into one root per cluster and
   retain only Flux install manifests under `platform/flux/`.

## Validation

- Render existing Kustomize roots and new Flux manifests; validate Flux CRD
  schemas using the selected Flux version.
- [x] Render the Flux Kustomize roots and build the dev Bazel targets.
- [ ] On a fresh kind cluster, verify Flux installs Gateway API, ESO, and
  cert-manager without applying dependent custom resources too early.
- [ ] Confirm `up` fails safely when token seeding fails and Flux does not start
  until the token Secret has been created.
- [ ] Verify ESO synchronizes the Cloudflare token, staging validation succeeds,
  the production certificate becomes Ready, Traefik starts with HTTPS, and dev
  apps reconcile afterward.
- [ ] Verify the home Flux Kustomizations reconcile the selected home app overlays.
- [x] Confirm no credentials or Secret values were added to Git and no active
  Argo CD configuration remains.
- [ ] Review runtime logs during cluster bootstrap to confirm no credentials or
  Secret values appear in command output or logs.

## Out of scope / decisions to confirm

- Migrating home platform components; the home Flux root currently selects apps
  only. Existing home platform services must already be available for app
  manifests that depend on them.
- Changing other application manifests, certificate policy, DNS, or the existing
  ESO/1Password design. Apps with both dev and home routes now share the base
  HTTPRoute and express dev-only route differences as inline Kustomize patches;
  the dev-only `whoami` route remains in its dev overlay.
- Replacing the manual 1Password token step with an automated secret system.

## References

- [Flux documentation](https://fluxcd.io/flux/)
- [Flux Kustomization dependencies](https://fluxcd.io/flux/components/kustomize/kustomizations/#dependencies)
- [Flux GitRepository](https://fluxcd.io/flux/components/source/gitrepositories/)
- [Flux releases](https://fluxcd.io/flux/releases/)
- [Flux v2.10.0 release](https://github.com/fluxcd/flux2/releases/tag/v2.10.0)
- [`external-secrets-1password.md`](external-secrets-1password.md)
- [`dev-cert-manager.md`](dev-cert-manager.md)
