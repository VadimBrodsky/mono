The [[Kubernetes]] command utility allows to manager the cluster using the k8s API and the set context. 

It is important that the `kubectl` version is no more than one minor version higher or lower that the cluster.  For example if the cluster is on 1.26.x the `kubectl` should be no lower than 1.25.x and no higher than 1.27x. 

The `kubectl` configuration file is called config and it lives in the `.kube` directory in the home folder. It contains definitions for:
- clusters
- Users and credentials
- Contexts 

View the configuration using the `kubectl config view` command. Sensitive data will be redacted. 

## Context
A collection of settings that tell `kubectl` which cluster to issue commands to and which credentials to authenticate with. 

To view the current context use the `kubectl config current-context` command. 

To change the currency context the the `kubectl config use-context docker-desktop` command. 

## Get
To inspect different components of the cluster:
* `kubectl get nodes` - inspects the nodes in a cluster
* `kubectl get pods` - inspects the running pods

