# Tailscale dev ingress

The dev cluster installs the Tailscale Kubernetes Operator from the upstream
static manifest pinned to Tailscale `v1.104.4`. The operator OAuth credentials
are synced from the `homelab-dev` 1Password vault by External Secrets.

Create a 1Password item named `tailscale-operator` in the `homelab-dev` vault
with fields named `client_id` and `client_secret`. The OAuth client needs
`General/Services`, `Devices/Core`, and `Keys/Auth Keys` write scopes, tagged
with `tag:k8s-operator`. The tailnet policy must permit `tag:k8s-operator` to
own `tag:k8s-operator` and `tag:k8s`; allow the intended tailnet users/devices
to reach `tag:k8s` on TCP port 443.

Only the dev Traefik HTTPS service is exposed to the tailnet. It is assigned
the Tailscale hostname `radar-dev`; its HTTPS listener continues to route by
the existing `radar.dev.brodsky.club` host and use the existing dev certificate.
After Flux reconciles, use the service's `EXTERNAL-IP` (its Tailscale IPv4
address) for the `radar.dev.brodsky.club` DNS A record. That address is
reachable only by tailnet devices. No Funnel exposure is configured.

The Longhorn UI uses the same Tailscale-only Traefik HTTPS entry point at
`longhorn.dev.brodsky.club`. Point that hostname's DNS A record at the same
Tailscale IPv4 address; do not point it at a public address. The route is not
attached to the plain-HTTP listener.
