# Observability

This platform service currently deploys to dev only: Prometheus, Alertmanager,
Loki, Tempo, Grafana, Grafana Alloy, node-exporter, and kube-state-metrics from
pinned container images (no Helm). Grafana is private; the dev overlay creates an
HTTPRoute at `grafana.dev.brodsky.club` through the existing private
Traefik/Tailscale path. There is no prod deployment or route.
Point its DNS A record to the same Tailscale IPv4 address as the Radar dev
route; do not use a public address or Funnel.

Prometheus scrapes API server, kubelet/cAdvisor, node-exporter, kube-state-
metrics, and pods only when the pod has
`prometheus.io/scrape: "true"` (optionally `prometheus.io/path` and
`prometheus.io/port`). Alloy tails container logs through the Kubernetes API
in every namespace and sends them to Loki. Loki uses a single binary, TSDB
schema v13, filesystem storage, and 7-day compactor retention. Prometheus also
retains 7 days. The dev Prometheus and Loki PVC requests are 1536 Mi and 2 Gi,
respectively; retention is time-based, so monitor actual disk use. This is a
single-replica, non-HA stack; Longhorn provides storage and its environment
defaults determine replica count.

Tempo accepts OTLP/gRPC on its in-cluster Service and stores traces on a 2 Gi
Longhorn PVC with 24-hour retention. Grafana provisions Tempo and the Infinity
data source for Cupdate, along with a Cupdate dashboard and Loki-to-Tempo trace
links. The Cupdate pod opts in to Prometheus scraping and pushes traces to
`tempo.observability.svc.cluster.local:4317`. These additions are dev-only;
Tempo's local storage is not intended for prod.

## 1Password secrets

The dev overlay uses External Secrets Operator and the existing
`onepassword-homelab-dev` ClusterSecretStore. Add these items to the
`homelab-dev` 1Password vault before Flux reconciles observability:

| 1Password item | Field label | Secret key produced |
| --- | --- | --- |
| `observability-grafana` | `credential` | `grafana-admin` / `password` |
| `observability-pushover` | `user-key` | `alertmanager-pushover` / `user-key` |
| `observability-pushover` | `app-token` | `alertmanager-pushover` / `app-token` |

Flux waits for the dev 1Password configuration before reconciling observability,
and checks that both ExternalSecrets become Ready. Grafana needs its generated
Secret to start. Alertmanager can start without its optional Pushover Secret
mount, but cannot send notifications until both Pushover fields have synced.
No Kubernetes Secret values are committed to Git. Prod observability and its
secret configuration are intentionally out of scope for now.

Monitor storage consumption: filesystem-backed Loki does not self-limit to
available disk; retention deletes data older than 7 days, not in response to
disk pressure.
