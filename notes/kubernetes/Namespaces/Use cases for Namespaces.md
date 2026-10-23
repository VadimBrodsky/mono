A way to apply quotas, policies to groups of objects. They are not designed for string workload isolation.

Most Kubernetes objects are deployed to a Namespace. These object are said to be namespaced and include common objects such as Pods, Services and Deployments.

Some object exist outside of a namespace and include nodes and PodSecurityPolicies.

To sell all cluster resources, namespaced or not:

```shell
kubectl api-resources
```

Namespaces are a good way to share a single cluster among different departments and environments, such as  dev, test, QA.

Namespaces are not good for isolating hostile workloads. A compromised container or Pod in one namespace can wreak havoc in other namespaces.