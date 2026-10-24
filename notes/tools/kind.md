# Kind: Kubernetes in Docker

## Resources

- Official Site: <https://kind.sigs.k8s.io/>
- Alternative: <https://minikube.sigs.k8s.io/docs/>

## Installation

```shell
brew install kind
```

## Setup with OrbStack

```shell
# Start OrbStack
orb start

# Ensure Docker is targeting OrbStack
docker context use orbstack

# Verify the engine is reachable
docker info

```

## Create a Cluster

```shell
kind create cluster

# or name the cluster
kind create cluster --name mckluster
```

## Set Kubectl Context

```shell
kubectl config use-context kind-kind
```

Then Verify

```shell
# List available contexts (* marks the active one)
kubectl config get-contexts

# Confirm the selected context
kubectl config current-context

# Check the cluster is reachable
kubectl get nodes
```

## See Kind Namespace

```shell
kubectl get pods --all-namespaces
kubectl get pods -A # same as above
```

### Delete a Cluster

```shell
kind delete clusters kind  # or whatever name it has
```

## Cluster Configuration in a Manifest

One control-lane, two workers; host port 300080 is mapped for the Gateway layer

```yaml
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
nodes:
  - role: control-place
    extraPortMappings:
      - containerPort: 30080
        hostPort: 30080
        protocol: TCP
  - role: worker
  - role: worker
```

Use the manifest

``` shell
kind create cluster --config manifests/day-one/kind-cluster.yaml
```
