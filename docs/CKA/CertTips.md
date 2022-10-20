# Certification tips and cheat sheet commands

Generally use `kubectl describe pod` to verify
that everything is working as expected.

## Setup by Linux Foundation

* At the start of each task you'll be provided with the command to ensure you are on the correct cluster to complete the task.
* SSH to any node: `ssh <nodename>`
* Sudo on any given node: `sudo -i`
* You can also use sudo to execute commands with elevated privileges at any time
* You must return to the base node (hostname node-1) after completing each task.
* Nested−ssh is not supported.
* You can use kubectl and the appropriate context to work on any cluster from the base node. When connected to a cluster member via ssh, you will only be able to work on that particular cluster via kubectl.
* The base system and the cluster nodes have pre-installed and pre-configured:
    * `kubectl` with `k` alias and Bash autocompletion
    * `jq` for YAML/JSON processing
    * `tmux` for terminal multiplexing
    * `curl` and wget for testing web services
    * `man` and man pages for further documentation
* Further instructions for connecting to cluster nodes will be provided in the appropriate tasks
* Where no explicit namespace is specified, the default namespace should be acted upon.
* If you need to destroy/recreate a resource to perform a certain task, it is your responsibility to back up the resource definition appropriately prior to destroying the resource.

## Imperative commands cheat sheet

To speed up commands, run commands imperatively
by using `kubectl run` instead of creating yaml files.

### Create pods

```bash
# Create nginx image
# kubectl run <pod name> --image=<image>
kubectl run nginx --image=nginx
```

```bash
# Generate POD manifest YAML file without creating the pod (dry-run)
# kubectl run <pod name> --image=<image> --dry-run=client -o yaml
kubectl run nginx --image=nginx --dry-run=client -o yaml
```

### Create deployments

```bash
# Create a deployment
# kubectl create deployment --image=<image> <name>
kubectl create deployment --image=nginx nginx
```

```bash
# Create a deployment YAML file without creating the deployment
# kubectl create deployment --image=<image> <name> --dry-run=client -o yaml
kubectl create deployment --image=nginx nginx --dry-run=client -o yaml
```

```bash
# Create deployment YAML file with replicas and output to file
# kubectl create deployment --image=<image> <name> --replicas=<int> --dry-run=client -o yaml > <name>.yaml
kubectl create deployment --image=nginx nginx --replicas=4 --dry-run=client -o yaml > nginx-deployment.yaml
```

### Replace

```bash
# Replace existing file
kubectl replace -f <file> --force
```

### List all types of resources

Listing resource types can be useful to find API versions
check if a resource type is bound to namespace or cluster
and figuring out the `kind` and `shortnames`

```bash
# List resource types
kubectl api-resources
```

### Create Ingress

```bash
kubectl create ingress <ingress-name> --rule="host/path=service:port"

kubectl create ingress ingress-test --rule="wear.my-online-store.com/wear*=wear-service:80"
```
