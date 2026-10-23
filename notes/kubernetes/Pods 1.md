A Pod is an execution environment shared by one or more containers:
- net namespace: IP address, port range, routing table etc.
- pid namespace: isolated process tree
- mnt namespace: filesystem and volumes
- UTS namespace: hostname
- IPC namespace: Unix domain sockets and shared memory

## Pods and shared networking
Every Pod has its own network namespace. This means every Pod has its own IP address, its own range of TCP and UDP ports and its own routing table. In a multi-container Pod, all containers share the IP, port range and routing table.

Container to container communication within the same Pod happens via the Pod's `localhost` adapter and a port number.

## Pod network
Every Pod gets its own unique IP address that is fully routable on an internal Kubernetes network called [[Pod Network]].

## Pod lifecycle
1. Define it in a YAML object
2. Posted to the API server
3. Pod enters the `pending` phase
4. Scheduled to a healthy worker node with enough resources
5. The local `kubeleet` process instructs the container runtime to pull all required images and start all containers
6. Once all containers are pulled and running the Pod enters the `running` phase
7. If its a [[Short-Lived Pod]] as soon as all containers terminate successfully the Pod enters the `succeeded` state.
8. If its a [[Long-Lived Pod]] it remains indefinitely in the `running` phase

## Multi-Container Pod Patters
- [[Sidecar pattern]]
- [[Adapter pattern]]
- [[Ambassador pattern]]
- [[Init pattern]]

## Running Pods
- [[Pod manifest files]]
- [[Introspecting running Pods]]

## Deleting Pods
Use `kubectl delete pods` and `kubectl delete svc` to delete any Pods and Services.

```shell
kubectl delete pod git-sync
```