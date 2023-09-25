# STEP 9 - Create Kubernetes Cluster

## Create Cluster

With inventory in place we are ready to build the Kubernetes cluster via Ansible.

* Note - the cluster creation may take several minutes to complete
* If the Kubespray process fails or is interpreted, run the Ansible playbook again and it will complete any incomplete steps on the subsequent run

```
cd ~/kubespray

ansible-playbook -i inventory/akash/hosts.yaml -b -v --private-key=~/.ssh/id_rsa cluster.yml
```

## GPU Node Label



> _**NOTE**_ - this section is only applicable to Akash Providers hosting GPU resources.  If your provider does not host GPU resources, please skip this section and proceed to [STEP 10 - Confirm Kubernetes Cluster](step-7-confirm-kubernetes-cluster.md)

Each node that provides GPUs must be labeled correctly.

> _**NOTE**_ - these configurations should be completed on a Kubernetes master/control plane node

### Label Template

* Use this label template in the `kubectl label` command in the subsequent Label Appliction sub-section below

```
akash.network/capabilities.gpu.vendor.<vendor name>.model.<model name>=true
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
