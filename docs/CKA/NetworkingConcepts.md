# Networking concepts in K8s

## Switching, Routing and Gateways Container Network Interface (CNI)

Most of kubernetes basic networking is the same as linux networking.

See [networking in linux](../linux-and-bash/networking.md)

## Networking in Docker

See [networking in docker](../docker/docker_networking.md)

## Cluster Networking

When setting up K8s in a non-managed cluster we need to ensure that the right ports are open.
Below are the required ports for control plane and worker nodes.
See [the docs for additional info](https://kubernetes.io/docs/reference/ports-and-protocols/)

### Control plane

| Protocol | Direction | Port Range | Purpose                 | Used By                   |
|----------|-----------|------------|-------------------------|---------------------------|
| TCP      | Inbound   | 6443       | Kubernetes API server   | All                       |
| TCP      | Inbound   | 2379-2380  | etcd server client API  | kube-apiserver, etcd      |
| TCP      | Inbound   | 10250      | Kubelet API             | Self, Control plane       |
| TCP      | Inbound   | 10259      | kube-scheduler          | Self                      |
| TCP      | Inbound   | 10257      | kube-controller-manager | Self                      |

Although etcd ports are included in control plane section, you can also host your own
etcd cluster externally or on custom ports.

### Worker node(s) {#node}

| Protocol | Direction | Port Range  | Purpose               | Used By                 |
|----------|-----------|-------------|-----------------------|-------------------------|
| TCP      | Inbound   | 10250       | Kubelet API           | Self, Control plane     |
| TCP      | Inbound   | 30000-32767 | NodePort Services†    | All                     |

† Default port range for [NodePort Services](/docs/concepts/services-networking/service/).

All default port numbers can be overridden. When custom ports are used those
ports need to be open instead of defaults mentioned here.  

One common example is API server port that is sometimes switched
to 443. Alternatively, the default port is kept as is and API server is put
behind a load balancer that listens on 443 and routes the requests to API server
on the default port.

### Handy debugging commands for exam

- `ip link`
- `ip addr`
- `ip addr add 192.168.1.10/24 dev eth0`
- `ip route`
- `ip route 192.168.1.0/24 via 192.168.2.1`
- `cat /proc/sys/net/ipv4/ip_forward`
- `arp`
- `netstat -plnt`
- `route`

### CNI installation in the exam

In the CKA exam, for a question that requires deployment
of a network addon, unless specifically directed, any of the solutions
described in the links below may be used.

However, the documentation currently does not contain a direct reference to the
exact command to be used to deploy a third party network addon.

The links below redirect to third party/ vendor sites or GitHub repositories which cannot be used in the exam.
This has been intentionally done to keep the content in the Kubernetes documentation vendor-neutral.

[https://kubernetes.io/docs/concepts/cluster-administration/addons/](https://kubernetes.io/docs/concepts/cluster-administration/addons/)

[https://kubernetes.io/docs/concepts/cluster-administration/networking/#how-to-implement-the-kubernetes-networking-model](https://kubernetes.io/docs/concepts/cluster-administration/networking/#how-to-implement-the-kubernetes-networking-model)
