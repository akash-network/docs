# Create Kubernetes Cluster

## Create Cluster

> _**NOTE**_ - This step should be completed from the Kubespray host only

With inventory in place we are ready to build the Kubernetes cluster via Ansible.

> _**NOTE**_ - the cluster creation may take several minutes to complete

* If the Kubespray process fails or is interpreted, run the Ansible playbook again and it will complete any incomplete steps on the subsequent run

```
cd ~/kubespray

###Execute following command if not already in the Python virtual environment
###Creation and activation of virtual evironment described further here:
###https://docs.akash.network/providers/build-a-cloud-provider/kubernetes-cluster-for-akash-providers/step-2-install-ansible
source venv/bin/activate

ansible-playbook -i inventory/akash/hosts.yaml -b -v --private-key=~/.ssh/id_rsa cluster.yml
```

## GPU Node Label (Kubernetes)

Each node that provides GPUs must be labeled correctly.

> _**NOTE**_ - these configurations should be completed on a Kubernetes master/control plane node

### Labels Template

* Use this label template in the `kubectl label` command in the subsequent sub-section below

> _**NOTE**_ - please do not assign any value other than `true` to these labels.  Setting the value to `false` may have unexpected consequences on the Akash provider.  If GPU resources are removed from a node, simply remove the Kubernetes completely and do not set value to `false`.

```
akash.network/capabilities.gpu.vendor.<vendor name>.model.<model name>: true
```

### Label Application

#### Template

> _**NOTE**_ - if you are unsure of the `<node-name>` to be used in this command - issue `kubectl get nodes` from one of your Kubernetes control plane nodes to obtain via the `NAME` column of this command output

```
kubectl label node <node-name> <label>
```

#### Example

> _**NOTE**_ - issue this command/label application for all nodes hosting GPU resources

```
kubectl label node node1 akash.network/capabilities.gpu.vendor.nvidia.model.a4000=true
```

#### Expected Output using Example

```
###Apply labels
root@node1:~/provider# kubectl label node node1 akash.network/capabilities.gpu.vendor.nvidia.model.a4000=true
node/node1 labeled

###Verification of applied labels
root@node1:~/provider# kubectl describe node node1 | grep -A10 Labels
Labels:             akash.network/capabilities.gpu.vendor.nvidia.model.a4000=true
...
...
```

## Additional Kubernetes Configurations

> _**NOTE**_ - these configurations should be completed on a Kubernetes master/control plane node

```
kubectl create ns akash-services
kubectl label ns akash-services akash.network/name=akash-services akash.network=true

kubectl create ns lease
kubectl label ns lease akash.network=true
```
