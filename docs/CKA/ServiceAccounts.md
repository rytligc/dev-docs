# Service Accounts

Two types of users exists in K8s.
Service accounts and USERS

alias for serviceaccount == sa

```bash
# Create service account named dashboard-sa
kubectl create sa dashboard-sa
```

```bash
# Get service account (sa)
kubectl get sa
```

```bash
# Describe service account dashboard-sa
kubectl describe sa dashboard-sa 

# The token is created as a secret, so we have to retrieve
# the token by getting secrets.
kubectl describe secret dashboard-sa-token-kbbdm
```

When a secret is mounted to a pod, we can see the secret mount path
by describing the pod  

```yaml
# Describe pod
kubectl describe pod dashboard-pod

Name: dashboard-pod
..
..
..
Mounts:
  /var/run/secrets/kubernetes.io/serviceaccount from dashboard-sa-token-kbbdm
..
```

Executing commands inside the pod, we can see the secrets listed inside directories

```bash
# exec into pod and 'ls' /var/run/secrets/kubernetes.io/serviceaccount
kubectl exec -it dashboard-pod ls /var/run/secrets/kubernetes.io/serviceaccount

>> ca.crt namespace token

# We can also cat to get the token value
kubectl exec -it dashboard-pod ca /var/run/secrets/kubernetes.io/serviceaccount/token

>> eyJhbGci....  
```

```bash
# Checking a pod which serviceaccount is linked to it
kubectl get po dashboard-pod -o yaml | grep serviceaccount
```