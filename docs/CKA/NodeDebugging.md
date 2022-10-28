# Node debugging

When facing issues with nodes not being ready,
the first thing one should do is SSH into the node and check statuses

```bash
# Journalctl
journalctl -u kubelet

# Journalctl -f (follow similar to tail to get to end)

```

```bash
systemctl status kubelet
systemctl restart kubelet
```

In practice exams most of the questions were related to minor issues.

If the kubelet is down it's important to check:

* Is the right certificate being used? (/etc/kubernetes/pki)
* Is the right port being used (6443) (/etc/kubernetes/kubelet.conf)
* Does the config file look right? (var/lib/kubelet/config.yaml)
