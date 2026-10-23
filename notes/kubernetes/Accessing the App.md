In order to access the app from a stable name or IP address, or from outside of the cluster you need a [[Kubernetes Service]] object.

This how a reliable networking is provided for a set of Pods.

```yaml
apiVersion: v1
kind: Service
metadata:
  name: hello-svc
  lables:
    app: hello-world
spec:
  type: NodePort
  ports:
  - port: 8080
    nodePort: 30001
    protocol: TCP
  selector:
    app: hello-world
```

Deploy it with `kubectl`

```shell
kubectl apply -f svc.yml
```