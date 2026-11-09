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
- Keep each Flux `Kustomization` declaration in a dedicated `flux/` subdirectory
  beside the platform component or app overlay it manages. Leave its existing
  workload `kustomization.yaml` untouched.
- Use the `homelab/k8s/platform/kustomization.yaml` and
  `homelab/k8s/kustomization.yaml` roots only to aggregate the initial platform
  and explicitly activated post-secret declarations, respectively. This keeps
  the manual token gate while respecting Kustomize's build-root boundaries.
- Use Flux `Kustomization.spec.dependsOn`, readiness checks, and health checks
  to enforce dependencies. A dependency should become Ready only when the
  relevant CRDs/controllers or workloads are actually healthy.
- Keep all credentials and rendered Secret data out of Git.

## Proposed repository layout

```text
homelab/k8s/platform/flux/
  home/bootstrap/                # Flux source and home reconciliation root
  dev/bootstrap/                 # Flux source and initial dev root
  dev/post-secret/               # activation object applied after token bootstrap

homelab/k8s/platform/<component>/.../flux/
  ...                            # Flux declaration colocated with that component

homelab/k8s/apps/<app>/overlays/dev/flux/
  ...                            # per-app dev Flux declaration

homelab/k8s/apps/kustomization.yaml
  ...                            # Aggregates home app Flux declarations

homelab/k8s/clusters/dev/
  up.sh                          # create kind cluster
  secret.sh                      # bootstrap the 1Password token Secret
  ...                            # Flux bootstrap / post-secret activation targets
```

The home graph reconciles individual home app overlays; the dev graph
reconciles individual dev overlays after platform dependencies are ready. The
existing cluster app-selection Kustomize files remain available and unchanged.
The `homelab/k8s/apps/kustomization.yaml` root selects only the colocated home
declarations; the top-level `homelab/k8s/kustomization.yaml` root selects only
the dev declarations that are activated after token bootstrap.

## Dev dependency and bootstrap sequence

1. Run `up.sh` to create the kind cluster and verify its nodes are Ready.
2. Install Flux and apply the initial dev Flux root, configured for the public
   GitHub source. The root reconciles only prerequisites that do not need the
   1Password token.
3. Reconcile Gateway API CRDs, ESO, and cert-manager. Keep CRD installations
   separate from their custom resources. Wait for CRDs to be Established and
   controllers/webhooks to be healthy before allowing dependents to proceed.
4. Run `secret.sh` (which invokes
   `bootstrap-1password-token.sh`) after ESO is ready. The helper creates or
   updates `external-secrets/onepassword-service-account-token` out of band.
5. Run an explicit post-secret activation command. It verifies that the token
   Secret exists, then applies the committed Flux Kustomization for the
   1Password-dependent stage. This Kustomization is deliberately not included
   in the initial Flux root, so Flux cannot start that stage before the manual
   credential handoff.
6. Flux reconciles the ESO 1Password store and Cloudflare `ExternalSecret`,
   waiting for the generated Cloudflare token Secret to become Ready.
7. Reconcile the staging issuer and certificate. Production issuer and
   certificate depend on the staging stage being Ready, preserving the current
   validation gate and avoiding an early production ACME request.
8. Reconcile Traefik after the production TLS Secret exists, then reconcile
   dev apps after the required platform services are ready.

For a fresh cluster rebuild, repeat the sequence from step 1. Flux may remain
healthy and reconciling the initial stage while the token step is pending; the
post-secret stage does not exist in the cluster until explicitly activated.

## Home cluster

- Replace the Argo CD `home-apps` Application with per-app Flux Kustomizations
  colocated with the home app overlays.
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
3. [x] Add the explicit dev post-secret activation target. It must check the
   expected Secret without printing its contents and apply only the committed
   Flux Kustomization object after the check succeeds.
4. [x] Update dev Bazel targets and bootstrap instructions to reflect cluster
   creation, Flux bootstrap, manual token setup, and post-secret activation.
   Retired the numbered platform bootstrap script after Flux took ownership of
   those tasks; retained readiness checks in the Flux bootstrap and activation
   targets.
5. [x] Remove `homelab/k8s/argocd/home-apps.yaml` and the obsolete Argo CD directory
   (including `.keep`). Remove Argo-specific references from relevant plans and
   documentation, replacing the Argo sync-wave description in
   `homelab/plans/external-secrets-1password.md` with the Flux staged dependency
   workflow.
6. [x] Document operational commands for checking Flux source, Kustomization
   readiness, retrying reconciliation, and rebuilding dev.
7. [x] Colocate Flux declarations with each app/platform overlay and use
   stage-specific aggregate Kustomize roots without changing the component's
   existing Kustomize root.

## Validation

- Render existing Kustomize roots and new Flux manifests; validate Flux CRD
  schemas using the selected Flux version.
- [x] Render the Flux Kustomize roots and build the dev Bazel targets.
- [ ] On a fresh kind cluster, verify Flux installs Gateway API, ESO, and
  cert-manager without applying dependent custom resources too early.
- [ ] Confirm the post-secret activation command fails safely when the token
  Secret is absent and succeeds after `secret.sh` runs.
- [ ] Verify ESO synchronizes the Cloudflare token, staging validation succeeds,
  the production certificate becomes Ready, Traefik starts with HTTPS, and dev
  apps reconcile afterward.
- [ ] Verify the home Flux Kustomizations reconcile the existing home app overlays.
- [x] Confirm no credentials or Secret values were added to Git and no active
  Argo CD configuration remains.
- [ ] Review runtime logs during cluster bootstrap to confirm no credentials or
  Secret values appear in command output or logs.

## Out of scope / decisions to confirm

- Migrating home platform components; the initial home Flux root only replaces
  the existing home apps Application. Existing home platform services must
  already be available for app manifests that depend on them.
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
