Tool for creating a multi-node Kubernetes cluster for development. It runs a stripped down K3s Kubernetes distribution inside of Docker.

## Dependencies
- Dokcer
- [[Kubectl]]

## Installation

```shell
brew install k3d

k3d --version
# k3d version v5.6.0
# k3s version v1.27.5-k3s1 (default)
```

## Create a Cluster

```shell
k3d cluster create tkb \ 
  --servers 1 \  # single control plane node
  --agents 3  \  # 3 worker nodes
  --image rancher/k3s:latest # uses most recent k8s image
```

Verify

```shell
kubectl get nodes
```