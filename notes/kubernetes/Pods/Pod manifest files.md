## Top level resources:
- `kind` - the type of object being defined
- `apiVersion` - the schema version to use when creating a Pod
- `metadata` - attach things such as names, labels, annotations, Namespaces
- `spec` - define any containers in the Pod

## Example:
```yml
kind: Pod
apiVersion: v1
metadata:
  name: hello-pod
  labels:
    zone: prod
    version: v1
spec:
  containers:
  - name: hello-ctr
    image: nigelpoulton/k8sbook:1.0
	ports:
	- containerPort: 8080
```

## Deploying Pods from a manifest file

Run the following command from the `pods` folder:
```shell
kubectl apply -f pod.yml
```

can add the `--watch` flag tot he command to monitor it and  see when the status changes to `Running`

To check the status of the deployment:
```shell
kubectl get pods
```