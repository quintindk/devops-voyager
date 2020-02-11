# azure kubernetes (AKS)

This is where the cloud happens...

## create cluster

To spin up a cluster in Azure is extremely simple. You will need az cli though and you can instal it using the instructions [here](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli)

There is one caveat for this to work. You need to enable the preview extensions to the Azure-CLI.

```shell
az extension add --name aks-preview
```

Once you've installed az you can login and begin to create the cluster...

```shell
az login
az account list
az account set --subscription "subsid"
```

```shell
az group create -l southafricanorth -n rg-devopsdemo-prod-001
PASSWORD_WIN="P@ssw0rd1234"
az aks create --resource-group=rg-devopsdemo-prod-001 \
  --name=aks-devopsdemo-prod-001 \
  --node-vm-size=Standard_B2s \
  --kubernetes-version=1.14.8 \
  --node-count=2 \
  --enable-addons monitoring \
  --generate-ssh-keys \
  --windows-admin-password=$PASSWORD_WIN \
  --windows-admin-username="azureuser" \
  --nodepool-name=linux \
  --network-plugin=azure
```

You should then install the Kubectl command and get the credentials.s

```shell
az aks install-cli
az aks get-credentials --resource-group=rg-devopsdemo-prod-001 --name=aks-devopsdemo-prod-001
```

You can then enable the dashboard although this is strongly discouraged in production.

```shell
kubectl get nodes
kubectl create clusterrolebinding kubernetes-dashboard --clusterrole=cluster-admin --serviceaccount=kube-system:kubernetes-dashboard
az aks browse --resource-group=rg-devopsdemo-prod-001 --name=aks-devopsdemo-prod-001
```

Windows node pools are still in preview and as such you'll need to enable the preview featuremon the subscription.

```shell
az feature register --name WindowsPreview --namespace Microsoft.ContainerService
az feature list --output table --query "[?contains(name,'Microsoft.ContainerService/WindowsPreview')].{Name:name,State:properties.state}"
```

You might need to wait a while for the feature to be registered, it may take a few minutes. When the status has changed to "Registered" you'll need to reload the provider.

```shell
az provider register --namespace Microsoft.ContainerService
```

Once this is complete you can create the windows node pool.

```shell
az aks nodepool add --cluster-name=aks-devopsdemo-prod-001 \
  --name=win \
  --resource-group=rg-devopsdemo-prod-001 \
  --os-type=Windows \
  --node-count=2 \
  --node-vm-size=Standard_B2s \
  --kubernetes-version=1.14.7
```

## deploy the application

The `devops-voyager.yaml` file used in minikube can be deployed as is on the aks-cluster that you've just created.

```shell
kubectl create namespace webservices
kubectl apply -f devops-voyager.yaml
```

```shell
kubectl -n webservices get pods -o wide
```

```shell
NAME                              READY   STATUS              RESTARTS   AGE   IP       NODE                            NOMINATED NODE   READINESS GATES
devops-voyager-6859bb4645-tnjfq   0/1     ContainerCreating   0          21s   <none>   aks-linux-37020821-vmss000000   <none>           <none>
```

```shell
kubectl apply -f legacy-voyager.yaml
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
---
apiVersion: v1
kind: Service
metadata:
  name: legacy-voyager-lb
  namespace: webservices
spec:
  type: LoadBalancer
  ports:
    - name: http
      port: 8080
      targetPort: 80
  selector:
    app: legacy-voyager
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

We enabled the addon for monitoring during the cluster creation. This will allow us to use the Insights and Monitoring within Azure.