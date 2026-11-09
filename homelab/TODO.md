# Homelab TODO

## Production readiness

- [ ] Provision Proxmox VMs, bootstrap Kubernetes, and install Flux.
- [ ] Add kube-vip for a stable control-plane VIP; test API failover.
- [ ] Install cert-manager and configure a production issuer; keep credentials and private keys out of Git.
- [ ] Enable HTTPS on the home Gateway with managed certificates; redirect HTTP to HTTPS.
- [ ] Configure HSTS; enable `includeSubDomains` only when all subdomains support HTTPS.
- [ ] Verify HTTP/2 and validated TLS to Proxmox and Unraid; plan certificate rotation.
- [ ] Test DNS, renewals, redirects, HSTS, WebSockets, and external access.
- [ ] Migrate KitchenSpeaker, PBS, Portainer, and `sync.brodsky.club` routes to Kubernetes.
- [ ] Document backups, monitoring, upgrades, and rollback procedures.
