## Get
Usually a single line output summary of the status of a Pod

```shell
kubectl get pods hello-pod -o yaml
```

- `-o wide` gives a few more columns but is still a single line of output
- `-o yaml` takes things to the next level and returning a full copy of the Pod from the cluster store

## Describe
Nicely formatted multi-line overview of an object. Including the object lifecycle events

```shell
kubectl describe pods hello-pod
```

## Logs
Get the logs of the Pod. 

Each container in a multi-container pod gets a name. The first Pod in the YAML object is the first container. All commands will run against this unless you specify otherwise. To specify otherwise, pass the `--container` flag and specify the name.

```yml
spec:
  containers:
  - name: app
    image: nginx
      ports:
        - containerPort: 8080
  - name: syncer
    image: k8s.gct.io/git-sync:v3.1.6
	volumeMounts:
	- name: html
```

```shell
kubectl logs mutipod --container syncer
```

## Exec
Running a command in Pods: `kubectl exec <pod-name> -- <command>`

```shell
kubectl exec hello-pod -- ps
```

or attach a shell access

```shell
kubectl exec -it hello-pod -- sh
```

if running a multi-container Pod, need to pass the `--container` flag and give it a  name of the container you want to exec session with.