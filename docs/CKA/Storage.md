# Storage and storage types

## Exam / Imperative method

```bash
kubectl run <pod name> --image=<image> --dry-run=client -o yaml
```

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

## Persistent Volumes

A Persistent Volume is a cluster-wide pool of storage volumes configured
to be used by users deploying application on the cluster.
The users can now select storage from this pool using Persistent Volume Claims.

```yml
# pv-definition.yaml

kind: PersistentVolume
apiVersion: v1
metadata:
  name: pv-vol1
spec:
  accessModes: [ "ReadWriteOnce" ]
  capacity:
   storage: 1Gi
  hostPath:
   path: /tmp/data
```

### Create the persistent volume

```bash
kubectl create -f pv-definition.yaml
# persistentvolume/pv-vol1 created
```

## Persistent volume claims

### Persistent volume claim file

```yml
# pvc-definition.yaml

kind: PersistentVolumeClaim
apiVersion: v1
metadata:
  name: myclaim
spec:
  # Always check that access mode is matching PV
  accessModes: [ "ReadWriteOnce" ]
  resources:
   requests:
     storage: 1Gi
```

### Persistent volume file

```yaml
# pv-definition.yaml

kind: PersistentVolume
apiVersion: v1
metadata:
    name: pv-vol1
spec:
    accessModes: [ "ReadWriteOnce" ]
    capacity:
     storage: 1Gi
    hostPath:
     path: /tmp/data
```

### Create the persistent volume for PVC

```bash
kubectl create -f pv-definition.yaml
# persistentvolume/pv-vol1 created
```

### Create the persistent volume claim (PVC)

```bash
kubectl create -f pvc-definition.yaml
# persistentvolumeclaim/myclaim created
```

### Pod Definition file using PVC

```yml
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    run: webapp
  name: webapp
spec:
  containers:
  - image: nginx
    name: webapp
    volumeMounts:
      - mountPath: /log
        name: webapp
  volumes:
    - name: webapp
      persistentVolumeClaim:
        claimName: pv-vol1
```

## Storage classes

To use external storage - i.e. Azure or GCP, we can either make static provisioning
or we can use dynamic provisioning.

Static requires to have volumes/disks premade before attaching,
where as dynamic provisioning can create volumes/disks on-the-fly.

### Static provisioning

A static provisioning would require two steps.

- 1) Create disk

```bash
# GCP
gcloud beta compute disks create --size 1GB --region westeurope pd-disk
```

- 2) Create Persistent volume file

```yml
apiVersion: v1
kind: PersistentVolume
metadata:
  name: pv-vol
spec:
  accessModes:
    - ReadWriteOnce
  capacity:
    storage: 500Mi
  # type of disk GCP persistent disk in this case
  gciPersistentDisk:
    pdName: pd-disk # same name as was used with the CLI
    fsType: ext4
```

### Dynamic provisioning

When using dynamic provisioning, we use `StorageClass` as kind instead of PV. There is still
created a PV, we just don't have to manage it manually anymore.

```yml
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: google-storage
provisioner: kubernetes.io/gce-pd
```

To bind it all together, `StorageClass`, `PersistentVolumeClaim` and `Pod`, the above example
might look like the following:

```yml
# Pod definition
apiVersion: v1
kind: Pod
metadata:
  name: random
spec:
  containers:
  - image: alpine
    name: alpine
    command: ["/bin/sh", "-c"]
    args: ["shuf -i 0-100 -n 1"]
    volumeMounts:
    - mountPath: /opt
      name: data-volume
  volumes:
  - name: data-volume
    persistentVolumeClaim:
      # Same name as defined below
      claimName: gcpClaim
---
# PVC
kind: PersistentVolumeClaim
apiVersion: v1
metadata:
  # Same name as claimed above
  name: gcpClaim
spec:
  # Always check that access mode is matching PV
  accessModes: [ "ReadWriteOnce" ]
  # Same name as specified in the storage class
  storageClassName: google-storage
  resources:
   requests:
     storage: 1Gi
---
# Storage Class
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  # Same name as specified in the PVC
  name: google-storage
provisioner: kubernetes.io/gce-pd
```
