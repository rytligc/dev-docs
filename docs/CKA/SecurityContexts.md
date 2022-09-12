# Security Contexts

## Container Security

We can enable some container security on Docker.

```bash
docker run --user=1001 ubuntu sleep 3600
docker run -cap-add MAC_ADMIN ubuntu
```

The same can be done on K8s. Container security can be configured
on POD or CONTAINER level or both. If both are specified, the CONTAINER
level will override the settings on the POD.

## Security Context on POD

To add security context on the POD and container,
add a field called **`securityContext`** under the spec section.

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: web-pod
spec:
  ####VVVV#######
  securityContext:
    runAsUser: 1000
  containers:
  - name: ubuntu
    image: ubuntu
    command: ["sleep", "3600"]
```

To set the same context at the container level,
move the whole section under container section.

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: web-pod
spec:
  containers:
  - name: ubuntu
    image: ubuntu
    command: ["sleep", "3600"]
    ####VVVV#######
    securityContext:
      runAsUser: 1000
```

We can also add some capabilities (**ONLY on CONTAINERS. Not PODS**)

"*With Linux capabilities, you can grant certain privileges to a process without granting all the privileges of the root user. To add or remove Linux capabilities for a Container, include the capabilities field in the securityContext section of the Container manifest.*"

```yaml
  apiVersion: v1
  kind: Pod
  metadata:
    name: web-pod
  spec:
    containers:
    - name: ubuntu
      image: ubuntu
      command: ["sleep", "3600"]
      securityContext:
        runAsUser: 1000
        ####VVVV#####        
        capabilities: 
          add: ["MAC_ADMIN"]
```

### K8s Reference Docs

[https://kubernetes.io/docs/tasks/configure-pod-container/security-context/](https://kubernetes.io/docs/tasks/configure-pod-container/security-context/)
