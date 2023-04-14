# Create Kubernetes Cluster

## Create Cluster

> _**NOTE**_ - This step should be completed from the Kubespray host

With inventory in place we are ready to build the Kubernetes cluster via Ansible.

* Note - the cluster creation may take several minutes to complete
* If the Kubespray process fails or is interpreted, run the Ansible playbook again and it will complete any incomplete steps on the subsequent run

```
cd ~/kubespray

ansible-playbook -i inventory/akash/hosts.yaml -b -v --private-key=~/.ssh/id_rsa cluster.yml
```

## Kubernetes Configurations

```
kubectl create ns akash-services
kubectl label ns akash-services akash.network/name=akash-services akash.network=true

kubectl create ns ingress-nginx
kubectl label ns ingress-nginx app.kubernetes.io/name=ingress-nginx app.kubernetes.io/instance=ingress-nginx

kubectl create ns lease
kubectl label ns lease akash.network=true
```
