# Jenkins

In order to deploy Jenkins to Kubernetes it needs to deploy the yaml files in the following order:
## 1. serviceAccount.yaml
### Description
- Create 'jenkins-admin' clusterRole
- Create 'jenkins-admin' ServiceAccount
- Bind clusterRole to ServiceAccount

P.S. 'jenkins-admin' ClusterRole has all the permissions to manage the cluster components. The access can be restricted by specying individual resource actions.

### Commands
```bash
# Apply config
kubectl apply -f serviceAccount.yaml
```

## 2. volume.yaml
### Description
Create a persistant volume for jenkins

### Commands
```bash
# Get k8s nodes
kubectl get nodes
```

```bash
# Apply config
kubectl create -f volume.yaml
```


## 3. deployment.yaml
### Description
Create a jenkins deployment.

#### P.S.
1. 'securityContent' for Jenkins pod to be able to write to the local persistent volume.
2. Liveness and readiness probe to monitor the health of the Jenkins pod.
3. Local persistent volume based on local storage class that holds the Jenkins data path '/var/jenkins_home'

#### To disable local storage
```yaml
volumes:
- name: jenkins-data
emptyDir: \{}
```

### Commands
```bash
# Apply config
kubectl apply -f deployment.yaml
```
```bash
# Check the deployment status
kubectl get deploy -n productivity-infra
kubectl describe deploy --namespace=productivity-infra
```


## 4. service.yaml
### Description
Using NodePort creating access to external network. The default port to access jenkins is **32000**

### Commands
```bash
# Apply config
kubectl apply -f service.yaml
```
```bash
# Access jenkins
curl http://127.0.0.1:32000
```
```bash
# Get pods
kubectl get po --namespace=productivity-infra
```
```bash
# Get jenkins admin password
kubectl exec -it {pod} cat /var/jenkins_home/secrets/initialAdminPassword -n productivity-infra
```

