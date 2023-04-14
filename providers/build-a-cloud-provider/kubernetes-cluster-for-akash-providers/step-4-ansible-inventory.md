# STEP 4 - Ansible Inventory

Ansible will use an inventory file to determine the hosts Kubernetes should be installed on.

## **Inventory File**

* Use the following commands on the Ansible host and in the “kubespray” directory
* Replace the IP addresses in the declare command with the addresses of your Kubernetes hosts (master and worker nodes)
* Running these commands will create a hosts.yaml file within the kubespray/inventory/akash directory
* NOTE - ensure that you are still within the Python virtual environment when running these commands.  Your cursor should have a “(venv)” prefix.  If needed - re-enter the virtual environment by issuing:
  * `source venv/bin/activate`

```
cd ~/kubespray

cp -rfp inventory/sample inventory/akash

#REPLACE IP ADDRESSES BELOW WITH YOUR KUBERNETES CLUSTER IP ADDRESSES
declare -a IPS=(10.0.10.136 10.0.10.239 10.0.10.253 10.0.10.9)

CONFIG_FILE=inventory/akash/hosts.yaml python3 contrib/inventory_builder/inventory.py ${IPS[@]}
```

### **Expected Result (Example)**

```
(venv) root@ip-10-0-10-145:/home/ubuntu/kubespray# CONFIG_FILE=inventory/akash/hosts.yaml python3 contrib/inventory_builder/inventory.py ${IPS[@]}

DEBUG: Adding group all
DEBUG: Adding group kube_control_plane
DEBUG: Adding group kube_node
DEBUG: Adding group etcd
DEBUG: Adding group k8s_cluster
DEBUG: Adding group calico_rr
DEBUG: adding host node1 to group all
DEBUG: adding host node2 to group all
DEBUG: adding host node3 to group all
DEBUG: adding host node4 to group all
DEBUG: adding host node1 to group etcd
DEBUG: adding host node2 to group etcd
DEBUG: adding host node3 to group etcd
DEBUG: adding host node1 to group kube_control_plane
DEBUG: adding host node2 to group kube_control_plane
DEBUG: adding host node3 to group kube_control_plane

DEBUG: adding host node1 to group kube_node
DEBUG: adding host node2 to group kube_node
DEBUG: adding host node3 to group kube_node
DEBUG: adding host node4 to group kube_node
```

### **Verification of Generated File**

* Open the hosts.yaml file in VI (Visual Editor) or nano
* Update the kube\_control\_plane category if needed with full list of hosts that should be master nodes
* Ensure you have either 1 or 3 Kubernetes control plane nodes under `kube_control_plane`. If 2 are listed, change that to 1 or 3, depending on whether you want Kubernetes be Highly Available.
* Ensure you have only control plane nodes listed under `etcd`.  If you would like to review additional best practices for etcd, please review this [guide](https://rafay.co/the-kubernetes-current/etcd-kubernetes-what-you-should-know/).
* For additional details regarding `hosts.yaml` best practices and example configurations, review this [guide](additional-k8s-resources/kubespray-hosts.yaml-examples.md).

```
vi ~/kubespray/inventory/akash/hosts.yaml
```

#### **Example hosts.yaml File**

* Additional hosts.yaml examples, based on different Kubernetes cluster topologies, may be found [here](additional-k8s-resources/kubespray-hosts.yaml-examples.md)

```
all:
  hosts:
    node1:
      ansible_host: 10.0.10.136
      ip: 10.0.10.136
      access_ip: 10.0.10.136
    node2:
      ansible_host: 10.0.10.239
      ip: 10.0.10.239
      access_ip: 10.0.10.239
    node3:
      ansible_host: 10.0.10.253
      ip: 10.0.10.253
      access_ip: 10.0.10.253
    node4:
      ansible_host: 10.0.10.9
      ip: 10.0.10.9
      access_ip: 10.0.10.9
  children:
    kube_control_plane:
      hosts:
        node1:
        node2:
        node3:
    kube_node:
      hosts:
        node1:
        node2:
        node3:
        node4:
    etcd:
      hosts:
        node1:
        node2:
        node3:
    k8s_cluster:
      children:
        kube_control_plane:
        kube_node:
    calico_rr:
      hosts: {}
```

## Manual Edits/Insertions of the hosts.yaml Inventory File

* Open the hosts.yaml file in VI (Visual Editor) or nano

```
vi ~/kubespray/inventory/akash/hosts.yaml
```

* Within the YAML file’s “all” stanza and prior to the “hosts” sub-stanza level  - insert the following vars stanza
* We currently recommend disabling TCP offloading on vxlan.calico interface until calico fixes a related bug. This only applies when Calico is configured to use VXLAN encapsulation.  Read more about this bug [here](https://github.com/kubernetes-sigs/kubespray/pull/9261#issuecomment-1248844913).

```
vars:
  ansible_user: root
```

* The hosts.yaml file should look like this once finished

```
all:
  vars:
    ansible_user: root
  hosts:
    node1:
      ansible_host: 10.0.10.136
      ip: 10.0.10.136
      access_ip: 10.0.10.136
    node2:
      ansible_host: 10.0.10.239
      ip: 10.0.10.239
      access_ip: 10.0.10.239
    node3:
      ansible_host: 10.0.10.253
      ip: 10.0.10.253
      access_ip: 10.0.10.253
    node4:
      ansible_host: 10.0.10.9
      ip: 10.0.10.9
      access_ip: 10.0.10.9
  children:
    kube_control_plane:
      hosts:
        node1:
        node2:
        node3:
    kube_node:
      hosts:
        node1:
        node2:
        node3:
        node4:
    etcd:
      hosts:
        node1:
        node2:
        node3:
    k8s_cluster:
      children:
        kube_control_plane:
        kube_node:
    calico_rr:
      hosts: {}
```

## Additional Kubespray Documentation

Use these resources for a more through understanding of Kubespray and for troubleshooting purposes

* [Adding/replacing a node](https://github.com/kubernetes-sigs/kubespray/blob/9dfade5641a43c/docs/nodes.md)
* [Upgrading Kubernetes in Kubespray](https://github.com/kubernetes-sigs/kubespray/blob/e9c89132485989/docs/upgrades.md)
