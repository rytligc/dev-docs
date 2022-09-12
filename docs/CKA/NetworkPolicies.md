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

Create a network policy to allow traffic from the `Internal` application only to the `payroll-service` and `db-service`.


- Policy Name: internal-policy
- Policy Type: Egress
- Egress Allow: payroll
- Payroll Port: 8080
- Egress Allow: mysql
- MySQL Port: 3306

```yml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: internal-policy
  namespace: default
spec:
  podSelector:
    matchLabels:
      name: internal
  policyTypes:
  - Egress
  - Ingress
  ingress:
    - {}
  egress:
  - to:
    - podSelector:
        matchLabels:
          name: mysql
    ports:
    - protocol: TCP
      port: 3306

  - to:
    - podSelector:
        matchLabels:
          name: payroll
    ports:
    - protocol: TCP
      port: 8080

  - ports:
    - port: 53
      protocol: UDP
    - port: 53
      protocol: TCP
```

Egress traffic has also been allowed to TCP and UDP. This has been added to ensure that the internal DNS resolution works from the internal pod.  

Remember: The kube-dns service is exposed on port 53.

```bash
root@controlplane ~ ➜  kubectl get svc -n kube-system 

NAME       TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)                  AGE
kube-dns   ClusterIP   10.96.0.10   <none>        53/UDP,53/TCP,9153/TCP   47m
```