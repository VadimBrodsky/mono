Scaling can be done imperatively and declaratively.

## Imperative Scaling

Verify the current number of replicas

```shell
kubectl get deploy hello-deploy
# NAME           READY   UP-TO-DATE   AVAILABLE   AGE
# hello-deploy   10/10   10           10          104m
```

Run the imperative commands to scale down to 5 and verify

```shell
kubectl scale deploy hello-deploy --replicas 5
# deployment.apps/hello-deploy scaled

kubectl get deploy hello-deploy
# NAME           READY   UP-TO-DATE   AVAILABLE   AGE
# hello-deploy   5/5     5            5           105m
```

## Declarative Scaling

To avoid conflicts between the desired state of the cluster as defined in the manifests and the actual state as set by the Imperative commands, edit the original deployment manifest and re-post it.

```shell
kubectl apply -f deploy.yml
# deployment.apps/hello-deploy configured

kubectl get deploy hello-world
# NAME           READY   UP-TO-DATE   AVAILABLE   AGE
# hello-deploy   10/10   10           10          109m
```