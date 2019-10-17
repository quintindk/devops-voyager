# devops-voyager

This repo demonstrates the power of Docker, Kubernetes and Azure Kubernetes Service along with Azure DevOps. The name voyager comes from the [Voyager](https://en.wikipedia.org/wiki/Voyager_program) space craft which had on it a [golden record](https://en.wikipedia.org/wiki/Voyager_Golden_Record) which contained audio of a bunch of greetings from our planet. It's a fun spin on the ["Hello World!"](https://en.wikipedia.org/wiki/%22Hello,_World!%22_program) programing concept.

## requirements

A brief look at the requirements; essentially a reverse proxy pattern with a web service that will return a random greeting or a greeting for a specific language. The initial requirement was to only provide Kubernetes yamls and scripts but I'm going to see how far we can take this.

## application

I've decided to provide a Python RESTful web service to retrieve the list of languages and a service to provide either a random greeting or a greeting for a specific language. This is a very simple web service and I chose Python because I haven't done too much in it and would like to play with the different application architectures for web services in Python.

I was looking at [Flask](http://flask.palletsprojects.com/en/1.1.x/) and decided the programming style, specifically using attribution for routing etc., worked for me. It would also be easy to install in a docker container to get it running.

## reverse-proxy

The reverse proxy pattern is a common architectural pattern in Kubernetes and is specifically implemented in [Ingress](https://kubernetes.io/docs/concepts/services-networking/ingress-controllers/) controllers. There is an entire list of possible controllers including cloud specific controllers (which we'll get to later) but for now we'll use [NGINX](https://www.nginx.com/) for an on prem or dev cluster.

## monitoring

This is where I can learn a ton, not my strongest point, well not really true; I created a PerformanceCounter implementation in .NET core that feeds into InfluxDb. I'm great at InfluxDb and Grafana but the requirement is to bring in Promethius and Grafana. We'll figure it out.

## testing

I will provide the Kubernetes YAML and shell scripts to provision the solution to a Minikube environment for testing. Please ensure that you have a working version of Minikube, at least version 1.16. You can find setup instructions [here](https://kubernetes.io/docs/tasks/tools/install-minikube/).

## cloud

There will also be a set of shell scripts that will deploy this to a Azure Kubernetes Service or [AKS](https://docs.microsoft.com/en-us/azure/aks/) cluster with a Azure Load Balancer as the ingress controller if time permits. This will demonstrate the power of the az cli.

## azure-devops

Finally, I'd like to see if I can use a personal Azure DevOps account with a CI/CD pipeline from GitHub to deploy the solution automatically to the cloud on commit to the master branch.

## conclusion

I hope that this project demonstrates the power of Kubernetes, the CI/CD capabilities and the flexibility of the tooling I've used in this demonstration.
