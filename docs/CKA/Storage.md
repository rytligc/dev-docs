# Storage and storage types

## Volumes

On disk files in containers are ephemeral, which obviously presents problems
when running containers in general. Docker already has the concept of volumes
that can be bound to containers, e.g `docker run -d --name devtest -v "$(pwd)"/target:/app nginx:latest`.

Pods in K8's can have any number of volumes or volume types used simultaneously.
E.g. AzureDisk CSI or a volume dedicated on the node.

### Yaml example of volume

```yml
apiVersion: v1
kind: Pod
metadata:
  name: test-pd
spec:
  containers:
  - image: alpine
    name: alpine
    command: ["/bin/sh", "c"]
    volumeMounts:
    - mountPath: /opt
      name: test-volume
  volumes:
  - name: test-volume
    hostPath:
      # directory location on host
      path: /data
      # this field is optional
      type: Directory
```
