The atomic unit of scheduling in Kubernetes is the Pod. Workloads deployed to Kubernetes always run inside pods. 

- To deploy an app we deploy a Pod. 
- If you terminate an app you terminate a Pod. 
- If you scale an app up or down you remove or add Pods. 

Kubernetes does not allow containers to run directly on a cluster. They always have to be wrapped in a Pod.

1. Pods augment 
	- Labels and annotations
	- Restart policies 
	- Probes
	- Affinity and anti-affinity rules
	- Termination control
	- Security policies
	- Resource requests and limits
1. Pods assist in scheduling
	- Every container in a Pod is guaranteed to be scheduled in the same worker zone. This guarantees that they will be in the same region and zone in the datacenter.  
2. Pods enable resource sharing 
	- They provide a shared execution eminent for one or more containers
	- Shared file system, shared network stack, shared memory, shared volumes 

The `kubectl explain pods` command lists all possible Pod attributes. 

To get deeper documentation on a Pod attribute run `kubectl explain pod.spec.restartPolicy`

## Deploying Pods
There are  2 ways to deploy a pod:
1. [[Directly via a Pod manifest]] 
2. [[Indirectly via a controller]]

## Anatomy of a Pod
A Pod execution environment shared by one or more containers:
- net namespace: 
- pid namespace: isolated process tree
- mnt namespace: file system and volumes
- UTS namespace: hostname
- IPC namespace: UNIX domain sockets and shared memory 