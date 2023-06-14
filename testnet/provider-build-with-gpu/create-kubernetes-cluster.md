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

## GPU Node Label (Kubernetes)

Each node that provides GPUs must be labeled correctly.

### Labels Template

```
akash.network/capabilities.gpu.vendor.<vendor name>.model.<model name>: true
```

### Example/Expected Output

```
root@node1:~/provider# kubectl label node node1 akash.network/capabilities.gpu.vendor.nvidia.model.a4000=true
node/node1 labeled
root@node1:~/provider# kubectl describe node node1 | grep -A10 Labels
Labels:             akash.network/capabilities.gpu.vendor.nvidia.model.a4000=true
...
...
```

## Additional Kubernetes Configurations

> _**NOTE**_ - these configurations should be entered on a Kubernetes master/control plane node

```
kubectl create ns akash-services
kubectl label ns akash-services akash.network/name=akash-services akash.network=true

kubectl create ns lease
kubectl label ns lease akash.network=true
```
