Update operations are replacement operations. When the Pod is updated, it is actually terminated and replaced with a brand new one.

Update the image version in the Deployment resource manifest.

The `.spec` section contains all the settings governing how updates will be performed. 

```yml
revisionHistoryLimit: 5       # how many configs to keep
progressDeadlineSeconds: 300  # how long each new Pod replica has to start before k8s considers the rollout to have stalled
minreadySeconds: 10           # throttles the rate at which replicas are replaced, replicas must be running without issues for 10 seconds before its allowed to start replacing the next one
strategy:
  type: RollingUpdate        # type of strategy
  rollingUpdate:
    maxUnavailable: 1        # never more than one pod below the desired state
    maxSurge: 1              # never more than one pod above desired state
```

As the desired state of the app requires 10 replicas, `maxSurge: 1` means you'll never have more than 11 replicas during the update process. And `maxUnavailable: 1` means you'll never have less than 9. The net result is a rollout that updates two pods at a time: delta between 9 and 11 is 2.

## Monitoring the Rollout

To monitor the progress of the rollout use:

```shell
kubectl rollout status deploymnet hello-deploy
```

## Pausing and Resuming Rollouts

It is possible to pause and resume a rollout using `kubectl`.

If the rollout is in progress, you can pause it:

```shell
kubectl rollout pause deploy hello-deploy
```

If a scale-up operation occurs during a rollout, the additional replicas will be balanced across both ReplicaSets.

You can resume the rollout:

```shell
kubectl rollout resume deploy hello-deploy
```