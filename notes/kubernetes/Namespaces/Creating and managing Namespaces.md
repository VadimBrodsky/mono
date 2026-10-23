Namespaces are first-class resources and in the core `v1` API group. You can create and manage them imperatively with `kubectl`, and declaratively with YAML manifests.

## Create Imperatively:

```shell
kubectl create ns hydra
# namespace/hydra created
```

## Create Declaratively:

Manifest:

```yml
kind: Namespace
apiVersion: v1
metadata:
  name: shiled
  labels:
    env: marvel
```

Command:

```shell
kubectl apply -f shield-ns.yml
```

## Delete

```shell
kubectl delete ns hydra
# namespace "hydra" deleted
```

## Use specific Namespace
You can set `kubeconfig` to automatically work with a specific Namespace.

```shell
kubectl config set-context --currenct --namespace shield
```