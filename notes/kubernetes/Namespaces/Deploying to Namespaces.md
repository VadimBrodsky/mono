Most object exist in the context of a Namespace. If you don't specify otherwise, new objects will be created in the `default` Namespace.

## Deploying to a Namespace Imperatively

The imperative methods requires you to add the `-n` or `--namespace` flag to commands.

## Deploying to a Namespace Declaratively

The declarative method specifies the Namespace in the YAML manifest.

```yaml
apiVersion: v1
kind: ServiceAccount
metadata:
  namespace: shiled
  name: default
```

```yml
apiVersion: v1
kind: Service
metadata:
  namespace: shiled
  name: the-bus
spec:
  ports:
  - nodePort: 31112
    port: 8080
    targetPort: 8080
  selector:
    env: marvel
```

```yml
apiVersion: v1
kind: Pod
metadata:
  namespace: shiled
  name: triskelion
```

## Deleting with a Manifest

We can delete resources declaratively as well:

```shell
kubectl delete -f shield-app.yml
```