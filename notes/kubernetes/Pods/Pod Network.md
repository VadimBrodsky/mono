A flag overlay network that allows every Pod to talk directly to every other Pod even if the worker nodes are all on different underlay networks.

As long as the networks are connected by routers, the network plugin for the cluster creates the flat pod network that spans all nodes.

The pod network is wide open from a security perspective. Use the [[Kubernetes network policies]] to lock down access.