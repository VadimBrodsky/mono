# FEM Kubernetes: Production-Grade Container Orchestration

## Manifests

Every manifest has the same four fields:

```yaml
apiVersion: apps/v1  # which API and version
kinds: Deployment    # what kind of resource
metadata:            # name, labels, namespace
  name: sample-app
spec:                # the desires state of this object
  replicas: 1
```

Can convert a kubectl cli command to a manifest:

```shell
kubectl --dry-run=client create deployment postgres --image=postgres:16 --output=yaml
```

## CLI

- Apply: `kubectl apply -f deployment.yaml` apply the manifest to the cluster
- Apply to a specific namespace: `kubectl apply -n <namespace> -f <file>`
- Diff: `kubectl diff -f deployment.yaml` changes between manifest and running state

Reapplying the same manifest is a noop.

Labels and selectors are the wiring, the selector must match the Pod's labels.

```yaml
# pod
template:
  metadata:
    labels:
      app: sample-app  # the label stamped on the Pod

# service
spec:
  selector:
      app: sample-app  # the selector that finds it
```

```shell
kubectl get deployments,services
kubectl get pods -l app=sample-app
```

## Health Checks & Resource Management

Tells the orchestrator as to when the app is ready to take traffic, if its running does not necessary means that it is working.

Health checks can be conditional on health checks of other services that you depend on.

### 3 Probes, 3 Different Questions

- Readiness: should this Pod get traffic right now?
- Liveness: is this Pod wedged and needed a restart?
- Startup: has the app finished booting yet?
- Requests are for scheduling: limits are for protection

## ConfigMaps, Secrets & Namespaces

Configuration values that multiple services can reuse.

- ConfigMap: non secret configuration - host, port, db, name
- Secret: sensitive values, handled with more care
- Namespace: the app/tooling boundary
- The split is about sensitivity, not mechanism

```shell
kubectl create namespace app # creates an app namespace
kubectl get namespaces
kubectl get ns
```

Secrets are base64 encoded, NOT encrypted

```shell
// create a secret
kubectl create secret generic db-secret -n app \
  --from-literal=DB_PASSWORD=demo-not-a-real-password

// or to create a manifest
kubectl --dry-run=client create secret generic db-secret -n app \
  --from-literal=DB_PASSWORD=demo-not-a-real-password --output=yaml

// get the and decode the secret
kubectl get secret db-secret -n app \
  -o jsonpath='{.data.DB_PASSWORD}' | base64 -d
```

## Gateway API

The route is the contract; the controller is local

- Gateway + HTTPRoute declare how traffic reaches the app
= A controller watches them and makes them real
- The route is portable; the controller is per-environment
- gatewayClassName is the one line that names it

Add Nginx Gateway Fabric -- <https://docs.nginx.com/nginx-gateway-fabric/>

```shell
kubectl kustomize "https://github.com/nginx/nginx-gateway-fabric/config/crd/gateway-api/standard?ref=v2.6.3" | kubectl apply -f -
kubectl apply --server-side -f https://raw.githubusercontent.com/nginx/nginx-gateway-fabric/v2.6.3/deploy/crds.yaml
kubectl apply -f https://raw.githubusercontent.com/nginx/nginx-gateway-fabric/v2.6.3/deploy/nodeport/deploy.yaml
```

Make sure its live by waiting

```shell
kubectl wait --namespace nginx-gateway \
  --for=condition=Available deployment/nginx-gateway \
  --timeout=120s

deployment.apps/nginx-gateway condition met
```

Patching the gateway to allow to work in Kind

```shell
kubectl patch nginxproxy nginx-gateway-proxy-config -n nginx-gateway --type=merge \
  -p '{"spec":{"kubernetes":{"deployment":{"pod":{"nodeSelector":{"node-role.kubernetes.io/control-plane":""},"tolerations":[{"key":"node-role.kubernetes.io/control-plane","operator":"Exists","effect":"NoSchedule"}]}},"service":{"nodePorts":[{"port":30080,"listenerPort":80}]}}}}'
```

After defining the gateway manifest and the httproute we can connect to the service

```shell
curl -H "Host: sample-app.local" http://localhost:30080/healthz
```

## Operators and CRD (custom resource definitions)

A CRD is a new kind; an operator is its loop

- A CRD teaches the API server a new kind
- kubectl get clusters becomes as real as get pods
- An operator is the control loop that reconciles them
- We consume an operator - we do not write one

A good example of a operator is CloudNativePG, to run a Postgres databasein k8s - <https://cloudnative-pg.io/>

```shell
kubectl apply --server-side -f https://github.com/cloudnative-pg/cloudnative-pg/releases/download/v1.29.1/cnpg-1.29.1.yaml
```

To see the crds:

```shell
kubectl get crds | grep cnpg
```

You declare a cluster; the operator does the rest

- CNPG manages Pods like PVCs like a StatefulSet would
- Plus failover, backups, and safe rolling upgrades
- It generates and owns the credentials - no human did
- The app talks to the -rw Service
