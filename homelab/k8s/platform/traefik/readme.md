# Traefik

Apply the manifests

```shell
kubectl --context kind-homelab-dev apply --server-side -k homelab/k8s/platform/traefik/overlays/dev
```

Connect to admin panel

```shell
kubectl --context kind-homelab-dev -n traefik port-forward deployment/traefik 9001:9001
```
