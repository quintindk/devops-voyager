# kubernetes

This is where the orchestration happens...

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
        image: quintindk/devops-voyager:1.0.0
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
    targetPort: 5000
    port: 5000
---
```

## nginx ingress

This is the ingress/loadbalancer/reverse proxy. Our initial requirements required "Only one pod needs to be accessible externally. This pod needs to act as a proxy that will perform a call to the second pod to retrieve information." As discussed in the main README.md this is a common pattern in Kubernetes architectures.

For this we'll be using Helm to deploy the controller. Helm is a package manager for Kubernetes and provides standardized deployments for off-the-shelf packages and patterns. You can read more about it [here](https://helm.sh/docs/).

The `nginx.yaml` file contains the values for the Helm chart for NGINX.

## minikube

To start you'll require minikube. You can find setup instructions [here](https://kubernetes.io/docs/tasks/tools/install-minikube/). Once installed you can start minikube with a simple `minikube start` command. Minikube start will also set your kubectl context so that can be confusing at times.

### pods and service

To test this you can deploy the pod and service with a single command using kubectl.

```shell
kubectl create namespace webservices
kubectl apply -f devops-voyager.yaml
```

The should output the following:

```shell
deployment.apps/devops-voyager created
service/devops-voyager created
```

If you'd like to query the status:

```shell
kubectl -n webservices get pods
kubectl -n webservices get svc
```

Once the container is created you can see that the service and the pod are hooked up:

```shell
kubectl -n webservices describe svc devops-voyager
```

### nginx

>Actually, after you've been through all that; you could just use the dashboard:

```shell
minikube dashboard
```
