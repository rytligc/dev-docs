# Answers

## Q1

```bash
kubectl -n admin2406 get deployment -o custom-columns=DEPLOYMENT:.metadata.name,CONTAINER_IMAGE:.spec.template.spec.containers[].image,READY_REPLICAS:.status.readyReplicas,NAMESPACE:.metadata.namespace --sort-by=.metadata.name > /opt/admin2406_data
```

## Q2

```bash
kubectl create deployment  nginx-deploy --image=nginx:1.16
kubectl set image deployment/nginx-deploy nginx=nginx:1.17 --record
```

## Q3

```yml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: mysql-alpha-pvc
  namespace: alpha
spec:
  accessModes:
  - ReadWriteOnce
  resources:
    requests:
      storage: 1Gi
  storageClassName: slow
```

## Q4

```bash
kubectl run secret-1401 -n admin1401 --image=busybox --dry-run=client -o yaml --command -- sleep 4800 > admin.yaml
```

```yml
apiVersion: v1
kind: Pod
metadata:
creationTimestamp: null
labels:
  run: secret-1401
name: secret-1401
namespace: admin1401
spec:
volumes:
- name: secret-volume
  # secret volume
  secret:
    secretName: dotfile-secret
containers:
- command:
  - sleep
  - "4800"
  image: busybox
  name: secret-admin
  # volumes' mount path
  volumeMounts:
  - name: secret-volume
    readOnly: true
    mountPath: "/etc/secret-volume"
```
