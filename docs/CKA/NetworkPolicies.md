# Network Policies


Standard image of network traffic highlighting `ingress` and `egress`.

![img](https://github.com/kodekloudhub/certified-kubernetes-administrator-course/raw/master/images/ing1.PNG)

By default ALL pods can communicate with each other in a cluster.
However, if we by any chance do not want our services to directly communicate
with each other- for example, 'the web server MUST not communicate directly with the database'-
we can implement a network policy.

![img](https://github.com/kodekloudhub/certified-kubernetes-administrator-course/raw/master/images/npol1.PNG)

## Network Policy selectors

To link a pod with a network policy, specify `labels` on the pod
and `matchLabels` on the `podSelector` on the network policy.

```yml
# NetworkPolicy that allows INGRESS from API POD on PORT 3306
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
 name: db-policy
spec:
  podSelector:
    matchLabels:
      # This is the DB
      role: db
  policyTypes:
  - Ingress
  ingress:
  - from:
    - podSelector:
        matchLabels:
          # Allow ingress FROM api pod
          role: api-pod
    ports:
    - protocol: TCP
      port: 3306
```

```yml
# Pod definition
apiVersion: v1
kind: Pod
metadata:
  labels:
    role: api-pod
spec:
  containers:
  - name: api
    image: customApiImage:latest
```
