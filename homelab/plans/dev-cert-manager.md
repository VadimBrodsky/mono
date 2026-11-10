# Dev HTTPS with cert-manager

## Goal

Serve kind dev applications over HTTPS on the machine running kind, using
`kind.brodsky.club` as the dev domain. App hostnames mirror prod with `kind`
inserted before the zone, for example `grimm.kind.brodsky.club` alongside
`grimm.brodsky.club`.

Use cert-manager's built-in Cloudflare DNS-01 solver. Do not use Helm or a
DuckDNS webhook. Keep the Cloudflare API token and all private key material out
of Git.

## Planned changes

1. **Install cert-manager with Kustomize**
   - Add a platform Kustomization under `homelab/k8s/platform/cert-manager/`.
   - Reference the official cert-manager static release manifest, pinning a
     specific current release (the installation docs currently show `v1.21.3`;
     verify the selected release when implementing).
   - Apply it from the kind bootstrap script after the cluster is ready.
   - Wait for cert-manager CRDs to become Established, then wait for the
     controller, cainjector, and webhook to become ready before applying
     cert-manager custom resources.

2. **Configure Cloudflare DNS-01**
   - Create the Cloudflare API token with only the DNS edit permissions needed
     for the `brodsky.club` zone and store it in the environment's 1Password
     vault.
   - Use ESO and an `ExternalSecret` to create the Cloudflare token Secret in
     the `cert-manager` namespace. Bootstrap ESO's 1Password Service Account
     token out of band as described in
     [`external-secrets-1password.md`](external-secrets-1password.md); do not
     commit either token or Secret data to Git.
   - Add a Kustomize-managed `ClusterIssuer` for Let's Encrypt. Start with the
     staging ACME endpoint to avoid production rate limits, then add/use the
     production issuer after successful validation.

3. **Issue a dev certificate**
   - Add a `Certificate` resource in the `traefik` namespace, using the
     `ClusterIssuer` and writing to a TLS Secret there.
   - Request `*.kind.brodsky.club`; also include `kind.brodsky.club` if the base
     hostname itself needs HTTPS. Wildcard issuance requires DNS-01.
   - The certificate should be available before enabling the HTTPS listener.

4. **Expose HTTPS through kind and Traefik**
   - Add a secure Traefik entrypoint and Service port in the dev overlay.
   - Add an HTTPS listener to the dev Gateway and reference the TLS Secret.
   - Add a kind host-port mapping for local port `443` to the Traefik HTTPS
     NodePort. Keep the existing HTTP mapping on `8080` unless there is a
     separate decision to redirect HTTP to HTTPS.
   - Configure `kind.brodsky.club` and `*.kind.brodsky.club` DNS records to
     resolve to `127.0.0.1` for access from the kind host only. DNS-01 issuance
     does not require the application to be publicly reachable.

5. **Update and validate dev routes**
   - Change dev HTTPRoute hostnames from `<app>.localhost` to
     `<app>.kind.brodsky.club`, preserving prod hostnames and routes.
   - Render the dev Kustomization and check the Gateway/Certificate resources.
   - Apply to kind; verify the certificate becomes Ready, HTTPS presents the
     expected certificate, and representative app routes work.
   - Once staging succeeds, issue and validate the production certificate.

## Out of scope

- Prod cluster issuer and HTTPS migration; prod will use Cloudflare DNS-01
  separately with `brodsky.club` hostnames.
- HTTP-to-HTTPS redirects and HSTS; consider them after HTTPS works. Avoid
  HSTS `includeSubDomains` or preload for dev.
- DuckDNS webhook or DuckDNS certificates.

## References

- [cert-manager kubectl installation](https://cert-manager.io/docs/installation/kubectl/)
- [cert-manager Cloudflare DNS-01](https://cert-manager.io/docs/configuration/acme/dns01/cloudflare/)
- [cert-manager Gateway usage](https://cert-manager.io/docs/usage/gateway/)
