Deploying using a YAML manifest:

```yaml
apiVersion: v1
kind: Deployment
metadata:
  name: hello-deploy    # Deployment name, must be valid DNS name
spec:
  replicas: 10          # Number of Pod replicas to deploy and manage
  selector:             # list of labels that Pods must have in order for the Deployment to manage them
    matchLabels:
      app: hello-world
  revisionHistoryLimit: 5
  progressDeadlineSeconds: 300 # how long to wait during rollout for each new replica to come online
  minreadySeconds: 10
  strategy:             # this block controls how updates happen
    type: RollingUpdate
	rollingUpdate:
	  maxUnavailable: 1
	  maxSurge: 1
  template:             # below here is the PodTemplate
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

Use `kubectl apply` to deploy it on the cluster:

```shell
kubectl apply -f deploy.yml
```


## Inspecting Deployments
The `kubectl get` and `kubectl desribe` commands allow to see details of Deployment and ReplicaSets

```shell
kubectl get deploy hello-world
```

```shell
kubectl describe deploy hello-deploy
```

Can also inspect the underlying ReplicaSets

```shell
kubectl get rs
kubectl describe rs hello-deploy-67959776b5
```