# Homelab

- This is GitOps infrastructure, not an application build: Kubernetes resources live in `k8s/`; `terraform/proxmox/` and `bootstrap/` are currently placeholders.
- App resources belong in `k8s/apps/<app>/base/` with cluster-specific changes in `overlays/dev/` and `overlays/prod/`. Cluster Flux roots under `k8s/clusters/<cluster>/flux/` decide what actually reconciles; dev and prod selections differ.
- Use the root Bazel workspace for dev lifecycle commands: `bazel run //homelab/k8s/clusters/dev:up`, then `bazel run //homelab/k8s/clusters/dev:flux`. `up` creates/selects kind and seeds the out-of-band 1Password token; it requires Docker, kind, `op` signed in, `jq`, and `kubectl`. `flux` installs the pinned controller bundle and applies Flux config. Stop/delete dev with `bazel run //homelab/k8s/clusters/dev:down`.
- Dev database-backed apps need the separate Docker PostgreSQL first: `docker compose -f homelab/k8s/clusters/dev/external/postgres/docker-compose.yaml up -d`. Its named volume persists; `down -v` deletes its data.
- For dev kubectl/Flux work, use `source homelab/k8s/scripts/set-context.sh dev` (source, don't execute) or set `KUBECONFIG` to `homelab/k8s/clusters/dev/.state/kubeconfig`. Generated `.state` data and credentials are local; never commit them.
- Prod Flux bootstrap applies `homelab/k8s/platform/flux/install` before `homelab/k8s/clusters/prod/flux`. Treat prod-context operations as live infrastructure changes; credentials and Terraform state must stay out of Git.
- Consult `readme.md` for the verified environment, secret-bootstrap, and operational details; it is the source for prerequisites and prod context/vault variables.
