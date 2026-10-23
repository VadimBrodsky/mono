There are two major components of a [[Kubernetes Deployments]]

- [[The deployment spec]]
- [[The deployment controller]]

The deployment object wraps the Pod, which in turn wraps the container.

```yaml
apiVersion: v1
kind: Deployment
metadata:
  name: hello-deploy
spec:
  replicas: 10
  selector:
    matchLabels:
      app: hwllo-world
  minReadySeconds: 10
  strategy:
    type: RollingUpdate
    rollingUpdate:
      maxUnavailable: 1
      maxSurge: 1
  template:
    metadata:
      labels:
        app: hello-world
	spec:
	  containers:
	  - name: hello-pod
	    image: nigelpoulton/k8sbook:1.0
	    ports:
	    - containerPort: 8080
```

Post the Deployment object to the API server where Kubernetes implements it and the Deployment controller watches it.

## Deployments and ReplicaSets
Behind the scenes deployments rely heavily on `ReplicaSet`. It is recommended not to manage ReplicaSets directly and let the Deployment controller manage them.

ReplicaSets manage Pods and bring self-healing and scaling.