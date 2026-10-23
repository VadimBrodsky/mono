The most popular and most generic multi-container pattern. It has the main application container and a sidecar container. It's the job of the sidecar to perform a secondary task for the main application container.

An important user of the sidecar model is the [[service mesh]].

```yml
apiVersion: v1
kind: Pod
metadata:
  name: git-sync
  labels:
    app: sidecar
spec:
  containers:
  - name: ctr-web
    image: nginx
    volumeMounts:
    - name: html
      mountPath: /usr/share/nginx
  - name: ctr-sync
    image: k8s.gcr.io/git-sync:v3.1.6
	volumeMounts:
	- name: html
	  mountPath: /tmp/git
    env::
    - name: GIT_SYNC_REPO
      value: https://github.com/nigelpoulton/ps-sidecar.git
    - name: GIT_SYNC_BRANCH
      value: master
    - name: GIT_SYNC_DEPTH
      value: "1"
    - name: GIT_SYNC_DEST
      value: "html"
  volumes:
  - name: html
    emptyDir: {}
```