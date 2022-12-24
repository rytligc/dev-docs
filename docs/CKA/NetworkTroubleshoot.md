# Network troubleshooting and network plugins

## Networking plugins

Kubernetes uses CNI plugins to setup network. The kubelet is responsible for executing plugins as we mention the following parameters in kubelet configuration.

- `cni-bin-dir`:  Kubelet probes this directory for plugins on startup

- `network-plugin`: The network plugin to use from `cni-bin-dir`. It must match the name reported by a plugin probed from the plugin directory.

### Weave Net

This is the only plugin mentioned in the kubernetes documentation.

[Docs on kubeadm HA using Weavenet](https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/high-availability/)

Installation

```bash
kubectl apply -f "https://cloud.weave.works/k8s/net?k8s-version=$(kubectl version | base64 | tr -d '\n')"
```

### Flannel

> Note: Flannel does not support kubernetes network policies.

Installation

```bash
kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/2140ac876ef134e0ed5af15c65e414cf26827915/Documentation/kube-flannel.yml
```

### Calico

Installation

```bash
curl https://docs.projectcalico.org/manifests/calico.yaml -O
kubectl apply -f calico.yaml
```

In CKA and CKAD exam, you won’t be asked to install the cni plugin.
But if asked you will be provided with the exact url to install it.
If not, you can install weave net from the documentation

`https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/high-availability/`

> Note: If there are multiple CNI configuration files in the directory, the kubelet uses the configuration file that comes first by name in lexicographic order.

## DNS in K8s

Kubernetes uses CoreDNS. CoreDNS is a flexible, extensible DNS server that can serve as the Kubernetes cluster DNS.

Memory and Pods

In large scale Kubernetes clusters, CoreDNS’s memory usage is predominantly affected by the number of Pods and Services in the cluster. Other factors include the size of the filled DNS answer cache, and the rate of queries received (QPS) per CoreDNS instance.

Kubernetes resources for coreDNS are:

1. A service account named coredns,
1. Cluster-roles named coredns and kube-dns
1. Clusterrolebindings named coredns and kube-dns,
1. A deployment named coredns,
1. A configmap named coredns and a
1. Service named kube-dns.

While analyzing the coreDNS deployment you can see that the the Corefile plugin consists of important configuration which is defined as a configmap.

Port 53 is used for for DNS resolution.

```bash
kubernetes cluster.local in-addr.arpa ip6.arpa {
    pods insecure
    fallthrough in-addr.arpa ip6.arpa
    ttl 30
}
```

This is the backend to k8s for cluster.local and reverse domains.

```bash
proxy . /etc/resolv.conf
```

## Troubleshooting DNS

Troubleshooting issues related to coreDNS

1. If you find CoreDNS pods in pending state first check network plugin is installed.
2. coredns pods have CrashLoopBackOff or Error state
3. If CoreDNS pods and the kube-dns service is working fine, check the kube-dns service has valid endpoints.

`kubectl -n kube-system get ep kube-dns`

If there are no endpoints for the service, inspect the service and make sure it uses the correct selectors and ports.

### Kube Proxy

kube-proxy is a network proxy that runs on each node in the cluster.
kube-proxy maintains network rules on nodes. These network rules allow network communication
to the Pods from network sessions inside or outside of the cluster.

In a cluster configured with kubeadm, you can find kube-proxy as a daemonset.

If you run a `kubectl describe ds kube-proxy -n kube-system`
you can see that the kube-proxy binary runs with following command inside the kube-proxy container.

```bash
Command: /usr/local/bin/kube-proxy --config=/var/lib/kube-proxy/config.conf --hostname-override=$(NODE_NAME)
```

#### Troubleshooting Kube Proxy

1. Check kube-proxy pod in the kube-system namespace is running.
2. Check kube-proxy logs.
3. Check configmap is correctly defined and the config file for running kube-proxy binary is correct.
4. kube-config is defined in the config map.
5. check kube-proxy is running inside the container

```bash
netstat -plan | grep kube-proxy
tcp        0      0 0.0.0.0:30081           0.0.0.0:*               LISTEN      1/kube-proxy
tcp        0      0 127.0.0.1:10249         0.0.0.0:*               LISTEN      1/kube-proxy
tcp        0      0 172.17.0.12:33706       172.17.0.12:6443        ESTABLISHED 1/kube-proxy
tcp6       0      0 :::10256                :::*                    LISTEN      1/kube-proxy
```

## Debugging references

[Services Issues](https://kubernetes.io/docs/tasks/debug-application-cluster/debug-service/)
[DNS troubleshooting](https://kubernetes.io/docs/tasks/administer-cluster/dns-debugging-resolution/)
