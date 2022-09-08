# ClusterRoles and Rolebindings

Cluster roles and ClusterRoleBindings are NAMESPACE WIDE!

```bash
# Check
kubectl api-resources
# Print the supported namespaced resources
kubectl api-resources --namespaced=true
# Print the supported non-namespaced resources
kubectl api-resources --namespaced=false
```

As ClusterRoles and RoleBindings are API resources, we can use common verbs on them.

```bash
# Describe a clusterrole
kubectl describe clusterrole cluster-admin

# Create a cluster role named "foo" with SubResource specified
kubectl create clusterrole foo --verb=get,list,watch --resource=pods,pods/status

# Describe a clusterrolebinding
kubectl describe clusterrolebindings

# Create a cluster role named "foo" with SubResource specified
kubectl create clusterrole foo --verb=get,list,watch --resource=pods,pods/status


#######################################################################################################################################
# Create a cluster role named storage-admin with access to storage AND PVs --vv- USE 'kubectl get api-resources' to find resource names
kubectl create clusterrole storage-admin --verb=get,list,watch --resource=persistentvolumes,storageclasses 

# Create a cluster role binding that attaches to the new clusterrole with a user, Michelle.
kubectl create clusterrolebinding michelle-storage-admin --user=michelle --clusterrole=storage-admin
```
