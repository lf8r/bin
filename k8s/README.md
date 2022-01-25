# Kubernetes cheat sheet scripts

## Deployment

### Create Deployment YAML
Create a starting YAML file for a deployment, given an image and a deployment name. 
```
kubectl create deployment my_deployment --image=busybox --dry-run=client --output=yaml
```

### Create YAML for other resources (see above)
```
# kubectl create 
  clusterrole         Create a ClusterRole.
  clusterrolebinding  Create a ClusterRoleBinding for a particular ClusterRole
  configmap           Create a configmap from a local file, directory or literal value
  deployment          Create a deployment with the specified name.
  job                 Create a job with the specified name.
  namespace           Create a namespace with the specified name
  poddisruptionbudget Create a pod disruption budget with the specified name.
  priorityclass       Create a priorityclass with the specified name.
  quota               Create a quota with the specified name.
  role                Create a role with single rule.
  rolebinding         Create a RoleBinding for a particular Role or ClusterRole
  secret              Create a secret using specified subcommand
  service             Create a service using specified subcommand.
  serviceaccount      Create a service account with the specified name
```

### Get YAML for a deployed service, deployment or pod
```
kubectl get deploy (or service or pod) deploymentname -o yaml
```
