The init patters i not a forma of sidecar. It runs a special init container that is guaranteed to start and complete before the main app container. It is also guaranteed to only run once.

Its job is to run tasks that initialize the environment for the main application container. An init container can do the prep work and will only exit when the environment is ready for the main app container. The main app container will not start until the init container completes.

```yml
apiVersion: v1
kind: Pod
metadata:
  name: initpod
  labels:
    app: initializer
spec:
  initContainers:
  - name: init-ctl
    image: busybox
    command: ['sh', '-c', 'until nslookup k8sbook; do echo waiting for k8sbook service;\ sleep 1; done; echo Service found!']
  containers:
  - name: web-ctr
    image: nigelpulton/web-app:1.0
	ports:
	  - containerPort: 8080
```