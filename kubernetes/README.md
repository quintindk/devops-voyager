# kubernetes

This is where the orchestration happens...

## minikube

To start you'll require minikube. You can find setup instructions [here](https://kubernetes.io/docs/tasks/tools/install-minikube/). Once installed you can start minikube with a simple `minikube start` command. Minikube start will also set your kubectl context so that can be confusing at times.

Use this command to ensure that the kube-prometheus stack will work.

```shell
minikube delete && minikube start --kubernetes-version=v1.16.2 --cpus 4 --memory=4096 --bootstrapper=kubeadm --extra-config=kubelet.authentication-token-webhook=true --extra-config=kubelet.authorization-mode=Webhook --extra-config=scheduler.address=0.0.0.0 --extra-config=controller-manager.address=0.0.0.0
minikube addons disable metrics-server
```

## devops-voyager

The devops-voyager component of our architecture contains the deployment of the pod that contains our application and the service to access that pod.

### deployment

The yaml file `devops-voyager.yaml` contains the definition for the devops-voyager pod or pods. This is essentially the web service worker layer of our architecture.

```yaml
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: devops-voyager
  namespace: webservices
  labels:
    app: devops-voyager
spec:
  replicas: 1
  selector:
    matchLabels:
      app: devops-voyager
  template:
    metadata:
      labels:
        app: devops-voyager
    spec:
      containers:
      - name: devops-voyager
        image: quintindk/devops-voyager:1.0.1
        ports:
        - name: flask
          containerPort: 5000
      restartPolicy: Always
      imagePullPolicy: Always
---
```

### service

The service provides either the internal or external endpoints for access to a deployment or app. It uses the selector to find the associated pods. The `devops-voyager.yaml` file contains the portion for the service as follows.

```yaml
---
kind: Service
apiVersion: v1
metadata:
  name: devops-voyager
  namespace: webservices
spec:
  selector:
    app: devops-voyager
  ports:
  - name: flask
    protocol: TCP
    port: 5000
---
```

### deploy

To test this you can deploy the pod and service using kubectl.

```shell
kubectl create namespace webservices
kubectl apply -f devops-voyager.yaml
```

The should output the following:

```shell
deployment.apps/devops-voyager created
service/devops-voyager created
```

## nginx ingress

This is the ingress/loadbalancer/reverse proxy. Our initial requirements required "Only one pod needs to be accessible externally. This pod needs to act as a proxy that will perform a call to the second pod to retrieve information." As discussed in the main README.md this is a common pattern in Kubernetes architectures.

The `nginx.yaml` file contains the the NGINX deployment, nginx.conf config map (which contains the reverse proxy rules) and NodePort service.

### deployemnt

Again, we'll use kubectl to deploy.

```shell
kubectl create namespace ingress
kubectl apply -f nginx.yaml
```

### testing

To test the deployment of the NGINX reverse proxy and the devops-voyager app you can use Postman or curl to GET from the web service.

```shell
kubectl -n ingress describe svc nginx
```

This should output something like:

```text
Name:                     nginx
Namespace:                ingress
Labels:                   <none>
Annotations:              kubectl.kubernetes.io/last-applied-configuration:
                            {"apiVersion":"v1","kind":"Service","metadata":{"annotations":{},"name":"nginx","namespace":"ingress"},"spec":{"ports":[{"port":80,"target...
Selector:                 app=nginx
Type:                     NodePort
IP:                       10.103.176.196
Port:                     <unset>  80/TCP
TargetPort:               80/TCP
NodePort:                 <unset>  31264/TCP
Endpoints:                172.17.0.5:80
Session Affinity:         None
External Traffic Policy:  Cluster
Events:                   <none>
```

You can then curl to the minkube node and the NodePort value above.

```shell
curl -G http://192.168.99.100:31264
```

You should see:

```text
Server Works!
```
