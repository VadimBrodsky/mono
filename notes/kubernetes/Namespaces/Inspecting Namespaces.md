Every Kubernetes cluster has a set of pre-created Namespaces.

```shell
kubectl get namespaces
# NAME              STATUS   AGE
# default           Active   19h
# kube-node-lease   Active   19h
# kube-public       Active   19h
# kube-system       Active   19h
```

- `default` namespace is where newly created object go if you don't specify a namespace.
- `kube-sytem` is where DNS, the metrics server and other control place components run.
- `kube-public` is for the objects that need to readable by anyone
- `kube-node-lease` is used for node heartbeat and managing node leases

```shell
kubectl describe namespace default
# kubectl describe ns default
```

Can use the `-n` or `--namespace` flags on regular kubectl command to filter the results based on specific Namespace. Or `--all-namespaces` to return object from all Namespaces.

```shell
kubectl get svc --namespace kube-system
```