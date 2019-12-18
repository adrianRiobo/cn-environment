# cn-environment
Vagrant config for local Cloud Native Environment

## Kind

Emulate k8s on docker with [kind](https://github.com/kubernetes-sigs/kind)  

To create a cluster:  

kind create cluster --name k8s-local --config /vagrant/kind-dev-config.yaml

In case you already have more clusters at kubectl config  

kubectl cluster-info --context k8s-local  

## NSM

Testing [NSM](https://networkservicemesh.io/)

In case helm install throws an error like: [no available release name found](https://github.com/helm/helm/issues/3055)

Add tiller service account:
´´´
kubectl create serviceaccount --namespace kube-system tiller
kubectl create clusterrolebinding tiller-cluster-rule --clusterrole=cluster-admin --serviceaccount=kube-system:tiller
kubectl patch deploy --namespace kube-system tiller-deploy -p '{"spec":{"template":{"spec":{"serviceAccount":"tiller"}}}}'
```
