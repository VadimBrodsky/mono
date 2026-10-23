Workloads such as server are intended to be long-lived and should remain in the running phase indefinitely. If any containers in a long-lived Pod fail, the local `kubelet` process may attempt to restart them.

The container's restart policy would dictate what happens to the Pod on failure:
- Always
- OnFailure
- Never

Always is the default restart policy and is appropriate for most long-lived Pods.

Kubernetes has controllers for long-lived workloads:
- `Deployments`
- `StatefulSets`
- `DaemonSets`