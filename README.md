# cn-environment
Vagrant config for local Cloud Native Environment

## Kind

Emulate k8s on docker with [kind](https://github.com/kubernetes-sigs/kind)  

To create a cluster:  

kind create cluster --name k8s-local --config /vagrant/kind-dev-config.yaml

In case you already have more clusters at kubectl config  

kubectl cluster-info --context k8s-local  
