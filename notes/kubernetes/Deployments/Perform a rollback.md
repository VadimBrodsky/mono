Kubernetes maintains a documented version history of rollouts. 

```shell
kubectl rollout history deployment hello-deploy
# deployment.apps/hello-deploy
# REVISION  CHANGE-CAUSE
# 1         <none>
# 2         kubectl apply --filename-deploy.yml --record=true
```

Rolling updates create new ReplicaSets objects, and the old ones are not deleted. The fact that the old ones exist makes them ideal for executing rollbacks, which are the same as rollouts just in reverse.

To see the replica sets:

```shell
kubectl get rs
# NAME                    DESIRED CURRENT READY AGE 
# hello-deploy-7975c755b6 10      10      10    13m
# hello-deploy-67959776b5 0       0       0     136m
```

To get additional details of a specific replica set

```shell
kubectl describe rs hello-deploy-67959776b5
```

Rollbacks sometimes referred to as "updates", that is exactly what they are. A rollback follows the exactly the same logic and rules as an update / rollout - terminated Pods with the current image and replaces them with Pods running the new image. Just in the case of a rollback, the "new" image is actually an "older" one.

## Imperative Rollbacks

An imperative `kubectl rollout` to revert the application is not recommended. However it is convenient for quick rollbacks, just make sure to remember to update your source YAML files to reflect the changes you make.

```shell
kubectl rollout undo deployment hello-deploy --to-revision=1
# deployment.apps "hello-deploy" rolled back
```

Verify the status of the rollback

```shell
kubectl get deploy hello-deploy
```