---
description: Kubernetes Cluster Setup for Akash Providers
---

# Kubernetes Cluster

## **Kubernetes Cluster Setup for Akash Providers**

### **Overview**

Akash leases are deployed via Kubernetes pods on provider clusters.  This guide details the build of the provider’s Kubernetes control plane and worker nodes.

The setup of a Kubernetes cluster is the responsibility of the provider. This guide provides best practices and recommendations for setting up a Kubernetes cluster. This document is not a comprehensive guide and assumes pre-existing Kubernetes knowledge.

### STEP1 - Clone the Kubespray Project

#### Cluster Creation Recommendations

We recommend using the Kubespray project to deploy a cluster. Kubespray uses Ansible to make the deployment of a Kubernetes cluster easy.

The recommended minimum number of hosts is four. This is meant to allow:

* One host to serve as Kubernetes master node & Akash provider&#x20;
* Two hosts to serve as a redundant master nodes&#x20;
* One host to serve as Kubernetes worker node to host provider leases

While you could use a single Kubernetes host in testing and dev this would not be recommended for production.

#### Kubespray Clone

Install Kubespray on a machine that has connectivity to the three hosts that will serve as the Kubernetes cluster.

Obtain Kubespray and navigate into the created local directory:

```
git clone https://github.com/kubernetes-sigs/kubespray.git

cd kubespray
```

### STEP2 - Install Ansible

When you launch Kubespray it will use an Ansible playbook to deploy a Kubernetes cluster.  In this step we will install Ansible.

Depending on your operating system it may be necessary to install OS patches, pip3, and virtualenv.  Example steps for a Ubuntu OS are detailed below.

```
sudo apt-get update

sudo apt-get install -y python3-pip

sudo apt install virtualenv
```

Within the kubespray directory use the following commands for the purpose of:

* Opening a Python virtual environment for the Ansible install&#x20;
* Installing Ansible and other necessary packages specified in the requirements.txt file

```
virtualenv --python=python3 venv

source venv/bin/activate

pip3 install -r requirements.txt
```

### STEP3 - Ansible Access to Kubernetes Cluster

Ansible will configure the Kubernetes hosts via SSH.  The user Ansible connects with must be root or have the capability of escalating privileges to root.

Commands in this step provide an example set up of SSH access to Kubernetes hosts and testing those connections.

#### Create SSH Keys on Ansible Host

```
ssh-keygen
```

* Accept the defaults to create a public-private key pair

#### Confirm SSH Keys

* The keys will be stored in the user’s home directory.
* Use these commands to verify keys.

```
cd ~/.ssh

ls
```

* Example files created:

```
authorized_keys  id_rsa  id_rsa.pub
```

#### Copy Public Key to the Kubernetes Hosts

* Template:

```
ssh-copy-id -i ~/.ssh/id_rsa <username>@<ip-address>
```

* Example:

```
ssh-copy-id -i ~/.ssh/id_rsa root@10.0.10.106
```

#### Confirm SSH to the Kubernetes Hosts

* Ansible should be able to access Kubernetes hosts with no password&#x20;
* Template:

```
ssh -i ~/.ssh/id_rsa <username>@<ip-address>
```

* Example:

```
ssh -i ~/.ssh/id_rsa root@10.0.10.106
```

### STEP4 - Ansible Inventory

Ansible will use an inventory file to determine the hosts Kubernetes should be installed on.

#### Inventory File

* Use the following commands on the Ansible host and in the “kubespray” directory&#x20;
* Replace the IP addresses in the declare command with the addresses of your Kubernetes hosts&#x20;
* Running these commands will create a hosts.yaml file within the kubespray/inventory/akash directory

```
cp -rfp inventory/sample inventory/akash

declare -a IPS=(10.0.10.106 10.0.10.88 10.0.10.22 10.0.10.42)

CONFIG_FILE=inventory/akash/hosts.yaml python3 contrib/inventory_builder/inventory.py ${IPS[@]}
```

* Expected result:

```
(venv) root@ip-10-0-10-146:~/kubespray# CONFIG_FILE=inventory/akash/hosts.yaml python3 contrib/inventory_builder/inventory.py ${IPS[@]}
DEBUG: Adding group all
DEBUG: Adding group kube_control_plane
DEBUG: Adding group kube_node
DEBUG: Adding group etcd
DEBUG: Adding group k8s_cluster
DEBUG: Adding group calico_rr
DEBUG: adding host node1 to group all
DEBUG: adding host node2 to group all
DEBUG: adding host node3 to group all
DEBUG: adding host node1 to group etcd
DEBUG: adding host node2 to group etcd
DEBUG: adding host node3 to group etcd
DEBUG: adding host node1 to group kube_control_plane
DEBUG: adding host node2 to group kube_control_plane
DEBUG: adding host node1 to group kube_node
DEBUG: adding host node2 to group kube_node
DEBUG: adding host node3 to group kube_node
```

* Example of the generated hosts.yaml file:

```
all:
  hosts:
    node1:
      ansible_host: 10.0.10.106
      ip: 10.0.10.106
      access_ip: 10.0.10.106
    node2:
      ansible_host: 10.0.10.88
      ip: 10.0.10.88
      access_ip: 10.0.10.88
    node3:
      ansible_host: 10.0.10.22
      ip: 10.0.10.22
      access_ip: 10.0.10.22
    node4:
      ansible_host: 10.0.10.42
      ip: 10.0.10.42
      access_ip: 10.0.10.42
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

### STEP5 - Enable gVisor

In this section we will enable gVisor which provides basic container security.

* From the “kubespray” directory:

```
cd inventory/akash/group_vars/k8s_cluster
```

* Using VI or nano edit the k8s-cluster.yml file:

```
vi k8s-cluster.yml
```

* Update the container\_manager key if necessary to containerd

```
container_manager: containerd
```

* From  the “kubespray” directory:

```
cd inventory/akash/group_vars
```

* Using VI or nano edit the etcd.yml file:

```
vi etcd.yml
```

* Update the etcd\_deployment\_type key if necessary to host

```
etcd_deployment_type: host
```

#### gVisor Issue - No system-cgroup v2 Support

If you are using a newer systemd version,  your container will get stuck in ContainerCreating state on your provider with gVisor enabled. Please reference[ this document](https://docs.akash.network/operations/provider/gvisor-issue-no-system-cgroup-v2-support) for details regarding this issue and the recommended workaround.

### **STEP6 - Create Kubernetes Cluster**

With inventory in place we are ready to build the Kubernetes cluster via Ansible.

* Note - the cluster creation may take several minutes to complete&#x20;
* From the “kubespray” directory:

```
ansible-playbook -i inventory/akash/hosts.yaml -b -v --private-key=~/.ssh/id_rsa cluster.yml
```

### **STEP7 - Confirm Kubernetes Cluster**

A couple of quick Kubernetes cluster checks are in order before moving into next steps.

* SSH into Kubernetes node01 (AKA Kubernetes master node)

#### Confirm Kubernetes Nodes

```
kubectl get nodes
```

* Example output from a healthy Kubernetes cluster:

```
NAME    STATUS   ROLES                  AGE     VERSION
node1   Ready    control-plane,master   8m47s   v1.22.4
node2   Ready    control-plane,master   8m17s   v1.22.4
node3   Ready    control-plane,master   8m17s   v1.22.4
node4   Ready    <none>                 7m11s   v1.22.4
```

#### Confirm Kubernetes Pods

```
kubectl get pods -n kube-system
```

* Example output of the pods that are the brains of the cluster

```
root@node1:~# kubectl get pods -n kube-system
NAME                                      READY   STATUS    RESTARTS        AGE
calico-kube-controllers-5788f6558-wd6jg   1/1     Running   1 (7m31s ago)   7m32s
calico-node-9t4gh                         1/1     Running   0               8m
calico-node-s848c                         1/1     Running   0               8m
calico-node-wzk8z                         1/1     Running   0               8m
coredns-8474476ff8-5rlzk                  1/1     Running   0               7m7s
coredns-8474476ff8-gfhd7                  1/1     Running   0               7m13s
dns-autoscaler-5ffdc7f89d-zfwbw           1/1     Running   0               7m9s
kube-apiserver-node1                      1/1     Running   0               9m53s
kube-apiserver-node2                      1/1     Running   0               9m31s
kube-controller-manager-node1             1/1     Running   1               9m59s
kube-controller-manager-node2             1/1     Running   1               9m32s
kube-proxy-jbngn                          1/1     Running   0               8m24s
kube-proxy-qlsqd                          1/1     Running   0               8m24s
kube-proxy-xp5sv                          1/1     Running   0               8m24s
kube-scheduler-node1                      1/1     Running   1               9m53s
kube-scheduler-node2                      1/1     Running   1               9m31s
nginx-proxy-node3                         1/1     Running   0               8m25s
nodelocaldns-g54ns                        1/1     Running   0               7m8s
nodelocaldns-pl96l                        1/1     Running   0               7m8s
nodelocaldns-q8bdw                        1/1     Running   0               7m8s
```

### STEP 8 - Custom Resource Definition

Akash uses two Kubernetes Custom Resource Definitions (CRD) to store each deployment.

* On the Kubernetes master node, download and install the Akash CRD files.

#### Download **and install** the first CRD File

```
wget https://raw.githubusercontent.com/ovrclk/akash/master/pkg/apis/akash.network/v1/crd.yaml

kubectl apply -f ./crd.yaml
```

#### Download and install the second CRD File

```
wget https://raw.githubusercontent.com/ovrclk/akash/mainnet/main/pkg/apis/akash.network/v1/provider_hosts_crd.yaml

kubectl apply -f ./provider_hosts_crd.yaml
```

#### Confirm the CRD installs:

```
kubectl get crd -n kube-system
```

Expected CRD Output:

* Note the lines of:
  * [ ] manifests.akash.network
  * [ ] providerhosts.akash.network

```
root@node1:~# kubectl get crd -n kube-system

NAME                                                  CREATED AT
bgpconfigurations.crd.projectcalico.org               2021-12-09T20:56:04Z
bgppeers.crd.projectcalico.org                        2021-12-09T20:56:04Z
blockaffinities.crd.projectcalico.org                 2021-12-09T20:56:04Z
clusterinformations.crd.projectcalico.org             2021-12-09T20:56:04Z
felixconfigurations.crd.projectcalico.org             2021-12-09T20:56:04Z
globalnetworkpolicies.crd.projectcalico.org           2021-12-09T20:56:05Z
globalnetworksets.crd.projectcalico.org               2021-12-09T20:56:05Z
hostendpoints.crd.projectcalico.org                   2021-12-09T20:56:05Z
ipamblocks.crd.projectcalico.org                      2021-12-09T20:56:05Z
ipamconfigs.crd.projectcalico.org                     2021-12-09T20:56:05Z
ipamhandles.crd.projectcalico.org                     2021-12-09T20:56:05Z
ippools.crd.projectcalico.org                         2021-12-09T20:56:05Z
kubecontrollersconfigurations.crd.projectcalico.org   2021-12-09T20:56:05Z
manifests.akash.network                               2021-12-09T21:06:54Z
networkpolicies.crd.projectcalico.org                 2021-12-09T20:56:05Z
networksets.crd.projectcalico.org                     2021-12-09T20:56:05Z
providerhosts.akash.network                           2021-12-09T21:07:21Z
```

### STEP9 - Network Policy

#### Network Configuration

A network configuration which must be applied to the Kubernetes cluster.

* On the Kubernetes master node, download the network YAML file

```
wget https://raw.githubusercontent.com/ovrclk/akash/master/_docs/kustomize/networking/network-policy-default-ns-deny.yaml
```

* Install the YAML File

```
kubectl apply -f ./network-policy-default-ns-deny.yaml
```

### **STEP10 - Ingress Controller**

The Akash provider requires an ingress controller in the Kubernetes cluster.

#### Ingress Controller Install

* On the Kubernetes master node, download the ingress controller YAML file

```
wget https://raw.githubusercontent.com/ovrclk/akash/master/_run/ingress-nginx.yaml
```

* Install the YAML File

```
kubectl apply -f ./ingress-nginx.yaml
```

* Expected result:

```
root@node1:~# kubectl apply -f ./ingress-nginx.yaml

namespace/ingress-nginx created
serviceaccount/ingress-nginx created
configmap/ingress-nginx-controller created
configmap/ingress-nginx-tcp created
clusterrole.rbac.authorization.k8s.io/ingress-nginx created
clusterrolebinding.rbac.authorization.k8s.io/ingress-nginx created
role.rbac.authorization.k8s.io/ingress-nginx created
rolebinding.rbac.authorization.k8s.io/ingress-nginx created
service/ingress-nginx-controller-admission created
service/ingress-nginx-controller created
deployment.apps/ingress-nginx-controller created
ingressclass.networking.k8s.io/nginx created
validatingwebhookconfiguration.admissionregistration.k8s.io/ingress-nginx-admission created
serviceaccount/ingress-nginx-admission created
clusterrole.rbac.authorization.k8s.io/ingress-nginx-admission created
clusterrolebinding.rbac.authorization.k8s.io/ingress-nginx-admission created
role.rbac.authorization.k8s.io/ingress-nginx-admission created
rolebinding.rbac.authorization.k8s.io/ingress-nginx-admission created
job.batch/ingress-nginx-admission-create created
job.batch/ingress-nginx-admission-patch created
```

#### Ingress Controller Configuration

A Kubernetes node needs to be labeled for ingress use.  This will cause the NGINX ingress controller to live only on the labeled node.

NOTE - if a wildcard domain is created, the pointers should point to the labeled node's IP address.  Additional nodes can be labeled to load balance any ingress communications.

```
kubectl label nodes node3 akash.network/role=ingress
```
