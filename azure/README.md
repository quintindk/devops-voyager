# azure kubernetes (AKS)

This is where the cloud happens...

## create cluster

To spin up a cluster in Azure is extremely simple. You will need az cli though and you can instal it using the instructions [here](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli)

Once you've installed az you can login and begin to create the cluster...

```shell
az login
az account list
az account set --subscription "subsid"
```

```shell
az group create -l southafricanorth -n devops-voyager-rg
az aks create --resource-group=devops-voyager-rg \
  --name=aks-cluster \
  --node-vm-size=Standard_B2s \
  --node-count=2 \
  --generate-ssh-keys
az aks get-credentials --resource-group devops-voyager-rg --name aks-cluster
```

You can then enable the dashboard although this is strongly discouraged in production.

```shell
kubectl get nodes
kubectl create clusterrolebinding kubernetes-dashboard --clusterrole=cluster-admin --serviceaccount=kube-system:kubernetes-dashboard
az aks browse --resource-group devops-voyager-rg --name aks-cluster
```

## deploy the application

The `devops-voyager.yaml` file used in minikube can be deployed as is on the aks-cluster that you've just created.

```shell
kubectl create namespace webservices
kubectl apply -f ../kubernetes/devops-voyager.yaml
```

The difference is the service. We no longer need to enable ingress or create an ingress controller, we can create a load balancer service which will deploy an Azure Load Balancer with a public IP address for clients to consume. Of course, this is not really recommended in production; in production you'd create either a NodePort service or a private azure load balancer and front it with an Azure Application Gateway (WAF) or a Firewall.

```yaml
---
apiVersion: v1
kind: Service
metadata:
  name: devops-voyager-lb
  namespace: webservices
spec:
  type: LoadBalancer
  ports:
    - name: http
      port: 8080
      targetPort: 5000
  selector:
    app: devops-voyager
```

```shell
kubectl apply -f devops-voyager-lb.yaml
kubectl -n webservices get svc devops-voyager-lb
```

You can then test your service using curl or Postman.

```shell
curl -G http://{pip}:8080/
```

## monitoring

We can deploy Prometheus and Grafano in the cluster but there are cool monitoring tools available for you AKS cluster in Azure. You can read more about these [here](https://azure.microsoft.com/es-es/blog/monitoring-azure-kubernetes-service-aks-with-azure-monitor-container-health-preview/).

```shell
kubectl create -f ../kubernetes/manifests/
sleep 10
kubectl create -f ../kubernetes/manifests/
until kubectl get customresourcedefinitions servicemonitors.monitoring.coreos.com ; do date; sleep 1; echo ""; done
until kubectl get servicemonitors --all-namespaces ; do date; sleep 1; echo ""; done
sleep 120
kubectl apply -f ../kubernetes/manifests/
sleep 10
kubectl apply -f ../kubernetes/manifests/
```
