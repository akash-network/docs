# Kubernetes Cluster

## **Kubernetes Cluster Setup for Akash Providers**

### **Overview**

Akash leases are deployed via Kubernetes pods on provider clusters.  This guide details the build of the provider’s Kubernetes control plane and worker nodes.

The setup of a Kubernetes cluster is the responsibility of the provider. This guide provides best practices and recommendations for setting up a Kubernetes cluster. This document is not a comprehensive guide and assumes pre-existing Kubernetes knowledge.

## Quickstart Guides

<details>

<summary>Create a Kubernetes cluster and start your first provider</summary>

```
#!/bin/bash
#This bootstrap makes some assumptions:
#1 : 3 new bare-metal servers using Debian 11 with root user and ssh password login enabled.
#2 : A control machine to run this bootstrap from and control your new cluster.  The control machine needs all the dependencies in the depends function.
#3 : Update USER, SSHPASS, NODE1, NODE2, NODE3 with your servers info.  You can add as many nodes as you like, just use the same format. "export NODEX=x.x.x.x"

###Server settings
USER=root #user on nodes to use
export SSHPASS=yourpassword #password to use to sync ssh keys
export NODE1=192.168.1.128 #node IP
export NODE2=192.168.1.223 #node IP
export NODE3=192.168.1.216 #node IP
###Akash Provider Wallet Settings
DOMAIN= #provider domain name
ACCOUNT_ADDRESS= #your akash wallet address
KEY_SECRET= #password to the exported private key of your wallet
CHAIN_ID=akashnet-2
MONIKER= #Unique name for your rpc node
NODE1=node1 #This will be your provider node
NODE2=node2 #This will be used for rpc node
REGION=us-west #Region of your servers
CPU=AMD #AMD or Intel
RPC_MODE=shared # "shared" or "solo"
####


function depends(){
apt-get update ; apt-get install -y python3-pip git sshpass software-properties-common
add-apt-repository --yes --update ppa:ansible/ansible
apt-get install -y ansible
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
git clone https://github.com/kubernetes-sigs/kubespray.git ; cd kubespray
pip3 install -r requirements.txt
}
depends

#Assign static IP to your Kubernetes Hosts and update the user and IP address below

declare -a IPS
readarray -t IPS <<< $(
  env | \
    grep '^NODE[[:digit:]]\+=' | sort | cut -d= -f2
)
echo "using nodes ${IPS[*]}..."

function ssh(){
#Create ssh keys
ssh-keygen -t rsa -C $(hostname) -f "$HOME/.ssh/id_rsa" -P "" ; cat ~/.ssh/id_rsa.pub
#Copy ssh public key to kubernetes hosts
for HOST in "${IPS[@]}"; do
echo $HOST
echo $USER
ssh-keyscan $HOST >> ~/.ssh/known_hosts
sshpass -e ssh-copy-id -i ~/.ssh/id_rsa.pub $USER@$HOST
done
unset SSHPASS
}
ssh

function ansible(){
#Setup ansible
cp -rfp inventory/sample inventory/akash
#Create config.yaml
CONFIG_FILE=inventory/akash/hosts.yaml python3 contrib/inventory_builder/inventory.py ${IPS[@]}
cat inventory/akash/hosts.yaml
#Enable gvisor for security
ex inventory/akash/hosts.yaml <<eof
2 insert
  vars:
    cluster_id: "1.0.0.1"
    ansible_user: root
    gvisor_enabled: true
.
xit
eof
echo "File Modified"
cat inventory/akash/hosts.yaml
}
ansible

#Run Kubespray
ansible-playbook -i inventory/akash/hosts.yaml -b -v --private-key=~/.ssh/id_rsa cluster.yml

#Run Helm
export KUBECONFIG=$KUBECONFIG

function add_helm(){
helm repo add akash https://ovrclk.github.io/helm-charts
helm repo update
}
add_helm

function namespaces(){
#Required for cluster creation, do not edit.
kubectl create ns akash-services
kubectl create ns ingress-nginx
}
namespaces

kubectl label nodes --overwrite $NODE1 akash.network/role=ingress #ingress node, need at least one
kubectl label nodes --overwrite $NODE2 akash.network/role=ingress #ingress node, need at least one

kubectl label nodes --overwrite $NODE1 akash=provider #Sets first node as main node
kubectl label nodes --overwrite $NODE2 akashrpc=rpc #Sets node as rpc node

if [[ $RPC_MODE == "shared" ]]; then
helm upgrade --install akash-provider akash/provider --namespace akash-services --set nodeSelector.akash=provider --set node=http://akash.c29r3.xyz:80/rpc --set attributes[0].key=region --set attributes[0].value=$REGION --set attributes[1].key=chia-plotting --set attributes[1].value=false --set attributes[2].key=host --set attributes[2].value=$DOMAIN --set attributes[3].key=cpu --set attributes[3].value=$CPU --set from=$ACCOUNT_ADDRESS --set key="$(cat ./key.pem | base64)" --set keysecret="$(echo $KEY_SECRET | base64)" --set chainid=$CHAIN_ID --set domain=$DOMAIN
else
helm upgrade --install akash-node akash/akash-node/ --namespace akash-services --set nodeSelector.akashrpc=rpc --set akash_node.from="$ACCOUNT_ADDRESS" --set akash_node.key="$(cat ./key.pem | base64)" --set akash_node.keysecret="$(echo $KEY_SECRET | base64)" --set akash_node.moniker="$MONIKER"
echo "Waiting 15 seconds for node and provider to start" ; sleep 15
RPC_NODE=$(kubectl get pods -o wide -n akash-services | grep $NODE2 | awk '{print $6}')
helm upgrade --install akash-provider akash/provider --namespace akash-services --set nodeSelector.akash=provider --set node=http://$RPC_NODE:26657 --set attributes[0].key=region --set attributes[0].value=$REGION --set attributes[1].key=chia-plotting --set attributes[1].value=false --set attributes[2].key=host --set attributes[2].value=$DOMAIN --set attributes[3].key=cpu --set attributes[3].value=$CPU --set from=$ACCOUNT_ADDRESS --set key="$(cat ./key.pem | base64)" --set keysecret="$(echo $KEY_SECRET | base64)" --set chainid=$CHAIN_ID --set domain=$DOMAIN
fi
#Setup ingress and hostname operator
helm upgrade --install akash-ingress akash/akash-ingress -n ingress-nginx --set domain=$DOMAIN
helm upgrade --install hostname-operator akash/hostname-operator -n akash-services --set nodeSelector.akash=provider
echo "INGRESS"
kubectl get pods -o wide -n ingress-nginx
echo "NODES"
kubectl get nodes -n akash-services -o wide
echo "PODS"
kubectl get pods -n akash-services -o wide
echo "Akash is ready!"
```

</details>

<details>

<summary>Already have a Kubernetes cluster? Start here!</summary>

```
#!/bin/bash
#This bootstrap makes some assumptions:
#1 : You have a working Kubernetes cluster and kubeconfig file.
#2 : A control machine to run this bootstrap from and control your new cluster.  The control machine needs all the dependencies in the depends function.
#3 : Update the Akash provider wallet settings before running.  You need to name NODE1 and NODE2 with the unique names your cluster uses. `kubectl get nodes`

###Akash Provider Wallet Settings
DOMAIN= #provider domain name
ACCOUNT_ADDRESS= #your akash wallet address
KEY_SECRET= #password to the exported private key of your wallet
CHAIN_ID=akashnet-2
MONIKER= #Unique name for your rpc node
NODE1=node1 #This will be your provider node
NODE2=node2 #This will be used for rpc node
REGION= #Region of your servers (us-west, us-east, eu-west, etc)
CPU= #AMD or Intel
RPC_MODE=shared # "shared" or "solo"
####

#Run Helm
export KUBECONFIG=$KUBECONFIG

function add_helm(){
helm repo add akash https://ovrclk.github.io/helm-charts
helm repo update
}
add_helm

function namespaces(){
#Required for cluster creation, do not edit.
kubectl create ns akash-services
kubectl create ns ingress-nginx
}
namespaces

kubectl label nodes --overwrite $NODE1 akash.network/role=ingress #ingress node, need at least one
kubectl label nodes --overwrite $NODE2 akash.network/role=ingress #ingress node, need at least one

kubectl label nodes --overwrite $NODE1 akash=provider #Sets first node as main node
kubectl label nodes --overwrite $NODE2 akashrpc=rpc #Sets node as rpc node

if [[ $RPC_MODE == "shared" ]]; then
helm upgrade --install akash-provider akash/provider --namespace akash-services --set nodeSelector.akash=provider --set node=http://akash.c29r3.xyz:80/rpc --set attributes[0].key=region --set attributes[0].value=$REGION --set attributes[1].key=chia-plotting --set attributes[1].value=false --set attributes[2].key=host --set attributes[2].value=$DOMAIN --set attributes[3].key=cpu --set attributes[3].value=$CPU --set from=$ACCOUNT_ADDRESS --set key="$(cat ./key.pem | base64)" --set keysecret="$(echo $KEY_SECRET | base64)" --set chainid=$CHAIN_ID --set domain=$DOMAIN
else
helm upgrade --install akash-node akash/akash-node/ --namespace akash-services --set nodeSelector.akashrpc=rpc --set akash_node.from="$ACCOUNT_ADDRESS" --set akash_node.key="$(cat ./key.pem | base64)" --set akash_node.keysecret="$(echo $KEY_SECRET | base64)" --set akash_node.moniker="$MONIKER"
echo "Waiting 15 seconds for node and provider to start" ; sleep 15
RPC_NODE=$(kubectl get pods -o wide -n akash-services | grep $NODE2 | awk '{print $6}')
helm upgrade --install akash-provider akash/provider --namespace akash-services --set nodeSelector.akash=provider --set node=http://$RPC_NODE:26657 --set attributes[0].key=region --set attributes[0].value=$REGION --set attributes[1].key=chia-plotting --set attributes[1].value=false --set attributes[2].key=host --set attributes[2].value=$DOMAIN --set attributes[3].key=cpu --set attributes[3].value=$CPU --set from=$ACCOUNT_ADDRESS --set key="$(cat ./key.pem | base64)" --set keysecret="$(echo $KEY_SECRET | base64)" --set chainid=$CHAIN_ID --set domain=$DOMAIN
fi
#Setup ingress and hostname operator
helm upgrade --install akash-ingress akash/akash-ingress -n ingress-nginx --set domain=$DOMAIN
helm upgrade --install hostname-operator akash/hostname-operator -n akash-services --set nodeSelector.akash=provider
echo "INGRESS"
kubectl get pods -o wide -n ingress-nginx
echo "NODES"
kubectl get nodes -n akash-services -o wide
echo "PODS"
kubectl get pods -n akash-services -o wide
echo "Akash is ready!"
```

</details>

### STEP 1 - Clone the Kubespray Project

#### Cluster Creation Recommendations

We recommend using the Kubespray project to deploy a cluster. Kubespray uses Ansible to make the deployment of a Kubernetes cluster easy.

The recommended minimum number of hosts is four for a production Provider Kubernetes cluster. This is meant to allow:

* Three hosts serving as a redundant control plane/master instances
* One host to serve as Kubernetes worker node to host provider leases
* NOTE - the number of control plane nodes in the cluster should always be an odd number to allow the cluster to reach consensus.&#x20;

While you could use a single Kubernetes host in testing and dev this would not be recommended for production.

#### Kubernetes Cluster Hardware Requirements and Recommendations

_Kubernetes Master Node Requirements_

* Minimum Specs
  * 2 CPU
  * 4 GB RAM
  * 30 GB disk
* Recommended Specs
  * 4 CPU
  * 8 GB RAM
  * 40 GB disk

_Kubernetes Work Node Requirements_

* Minimum Specs
  * 4 CPU
  * 8 GB
  * 100 GB disk
* Recommendations
  * The more resources the better depending on your goal of maximum number of concurrent deployments.&#x20;
  * Especially important to note that worker node needs to have as much CPU as possible, because if it's got, say 8 CPU and, 100 GB RAM, and 2 TB disk -> the cpu would likely be a bottleneck. Since people tend to deploy at least 1 CPU per deployment, the server could only host 8 deployments maximum and likely about 6 deployments as other \~2 CPU will be reserved by the Kubernetes system components.

#### Kubespray Clone

Install Kubespray on a machine that has connectivity to the three hosts that will serve as the Kubernetes cluster.

Obtain Kubespray and navigate into the created local directory:

```
git clone https://github.com/kubernetes-sigs/kubespray.git ; cd kubespray
```

### STEP 2 - Install Ansible

When you launch Kubespray it will use an Ansible playbook to deploy a Kubernetes cluster.  In this step we will install Ansible.

Depending on your operating system it may be necessary to install OS patches, pip3, and virtualenv.  Example steps for a Ubuntu OS are detailed below.

```
apt-get update ; apt-get install -y python3-pip virtualenv
```

Within the kubespray directory use the following commands for the purpose of:

* Opening a Python virtual environment for the Ansible install&#x20;
* Installing Ansible and other necessary packages specified in the requirements.txt file

```
virtualenv --python=python3 venv

source venv/bin/activate

rm requirements.txt

cat > requirements.txt << 'EOF'
ansible==4.8.0
ansible-core==2.11.6
cryptography==2.8
jinja2==2.11.3
netaddr==0.7.19
pbr==5.4.4
jmespath==0.9.5
ruamel.yaml==0.16.10
ruamel.yaml.clib==0.2.6
MarkupSafe==1.1.1
EOF

pip3 install -r requirements.txt
```

### STEP 3 - Ansible Access to Kubernetes Cluster

Ansible will configure the Kubernetes hosts via SSH.  The user Ansible connects with must be root or have the capability of escalating privileges to root.

Commands in this step provide an example set up of SSH access to Kubernetes hosts and testing those connections.

#### Create SSH Keys on Ansible Host

```
ssh-keygen -t rsa -C $(hostname) -f "$HOME/.ssh/id_rsa" -P "" ; cat ~/.ssh/id_rsa.pub
```

#### Confirm SSH Keys

* The keys will be stored in the user’s home directory.
* Use these commands to verify keys.

```
cd ~/.ssh ; ls
```

* Files created:

```
authorized_keys  id_rsa  id_rsa.pub
```

#### Copy Public Key to all of the Kubernetes Hosts

* Template:

```
ssh-copy-id -i ~/.ssh/id_rsa.pub <username>@<ip-address>
```

* Example:&#x20;

```
ssh-copy-id -i ~/.ssh/id_rsa.pub root@10.0.10.136
ssh-copy-id -i ~/.ssh/id_rsa.pub root@10.0.10.239
ssh-copy-id -i ~/.ssh/id_rsa.pub root@10.0.10.253
ssh-copy-id -i ~/.ssh/id_rsa.pub root@10.0.10.9
```

#### Confirm SSH to the Kubernetes Hosts

* Ansible should be able to access Kubernetes hosts with no password&#x20;
* Template:

```
ssh -i ~/.ssh/id_rsa <username>@<ip-address>
```

* Example:&#x20;

```
ssh -i ~/.ssh/id_rsa root@10.0.10.136
ssh -i ~/.ssh/id_rsa root@10.0.10.239
ssh -i ~/.ssh/id_rsa root@10.0.10.253
ssh -i ~/.ssh/id_rsa root@10.0.10.9
```

### STEP 4 - Ansible Inventory

Ansible will use an inventory file to determine the hosts Kubernetes should be installed on.

#### Inventory File

* Use the following commands on the Ansible host and in the “kubespray” directory&#x20;
* Replace the IP addresses in the declare command with the addresses of your Kubernetes hosts&#x20;
* Running these commands will create a hosts.yaml file within the kubespray/inventory/akash directory

```
cp -rfp inventory/sample inventory/akash

declare -a IPS=(10.0.10.136 10.0.10.239 10.0.10.253 10.0.10.9)

CONFIG_FILE=inventory/akash/hosts.yaml python3 contrib/inventory_builder/inventory.py ${IPS[@]}
```

* Expected result:

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

* Example of the generated hosts.yaml file
* Update the kube\_control\_plane category if needed with full list of hosts that should be master nodes

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

#### Manual Edits/Insertions of the hosts.yaml Inventory File

* Open the hosts.yaml file in VI (Visual Editor) or nano to make the following file updates to the hosts.yaml file&#x20;
* Within the YAML file’s “all” stanza and prior to the “hosts” sub-stanza level - insert the following vars stanza&#x20;

```
vars:
  cluster_id: "1.0.0.1"
  ansible_user: root
  gvisor_enabled: true
```

* The hosts.yaml file should look like this once finished

```
all:
  vars:
    cluster_id: "1.0.0.1"
    ansible_user: root
    gvisor_enabled: true
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

### STEP 5 - Enable gVisor

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

If you are using a newer systemd version,  your container will get stuck in ContainerCreating state on your provider with gVisor enabled. Please reference [this document](gvisor-issue-no-system-cgroup-v2-support.md) for details regarding this issue and the recommended workaround.

### **STEP 6 - Create Kubernetes Cluster**

With inventory in place we are ready to build the Kubernetes cluster via Ansible.

* Note - the cluster creation may take several minutes to complete&#x20;
* From the “kubespray” directory:

```
ansible-playbook -i inventory/akash/hosts.yaml -b -v --private-key=~/.ssh/id_rsa cluster.yml
```

### **STEP 7 - Confirm Kubernetes Cluster**

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
root@node1:/home/ubuntu# kubectl get pods -n kube-system

NAME                                      READY   STATUS    RESTARTS        AGE
calico-kube-controllers-5788f6558-mzm64   1/1     Running   1 (4m53s ago)   4m54s
calico-node-2g4pr                         1/1     Running   0               5m29s
calico-node-6hrj4                         1/1     Running   0               5m29s
calico-node-9dqc4                         1/1     Running   0               5m29s
calico-node-zt8ls                         1/1     Running   0               5m29s
coredns-8474476ff8-9sgm5                  1/1     Running   0               4m32s
coredns-8474476ff8-x67xd                  1/1     Running   0               4m27s
dns-autoscaler-5ffdc7f89d-lnpmm           1/1     Running   0               4m28s
kube-apiserver-node1                      1/1     Running   1               7m30s
kube-apiserver-node2                      1/1     Running   1               7m13s
kube-apiserver-node3                      1/1     Running   1               7m3s
kube-controller-manager-node1             1/1     Running   1               7m30s
kube-controller-manager-node2             1/1     Running   1               7m13s
kube-controller-manager-node3             1/1     Running   1               7m3s
kube-proxy-75s7d                          1/1     Running   0               5m56s
kube-proxy-kpxtm                          1/1     Running   0               5m56s
kube-proxy-stgwd                          1/1     Running   0               5m56s
kube-proxy-vndvs                          1/1     Running   0               5m56s
kube-scheduler-node1                      1/1     Running   1               7m37s
kube-scheduler-node2                      1/1     Running   1               7m13s
kube-scheduler-node3                      1/1     Running   1               7m3s
nginx-proxy-node4                         1/1     Running   0               5m58s
nodelocaldns-7znkj                        1/1     Running   0               4m28s
nodelocaldns-g8dqm                        1/1     Running   0               4m27s
nodelocaldns-gf58m                        1/1     Running   0               4m28s
nodelocaldns-n88fj                        1/1     Running   0               4m28s
```

### STEP 8 - Custom Resource Definition

Akash uses two Kubernetes Custom Resource Definitions (CRD) to store each deployment.

* On the Kubernetes master node, download and install the Akash CRD files.

#### Download install  CRD File

```
wget https://raw.githubusercontent.com/ovrclk/akash/master/pkg/apis/akash.network/crd.yaml

kubectl apply -f ./crd.yaml
```

#### Confirm the CRD installs

```
kubectl get crd | grep akash
```

#### _Expected CRD Output_

```
# kubectl get crd | grep akash

manifests.akash.network           2022-04-27T14:39:32Z
providerhosts.akash.network       2022-04-27T14:39:47Z
```

### **STEP 9 - Network Policy And Akash Namespace**

#### Network **Policy** Configuration

On the Kubernetes master node, download the network YAML file

```
wget https://raw.githubusercontent.com/ovrclk/akash/mainnet/main/_docs/kustomize/networking/network-policy-default-ns-deny.yaml
```

* Install the YAML File

```
kubectl apply -f ./network-policy-default-ns-deny.yaml
```

#### Namespace Addition

* Apply the Akash namespace YAML file and other networking customizations

```
git clone --depth 1 -b mainnet/main https://github.com/ovrclk/akash.git
cd akash
kubectl apply -f _docs/kustomize/networking/namespace.yaml
kubectl kustomize _docs/kustomize/akash-services/ | kubectl apply -f -

cat >> _docs/kustomize/akash-hostname-operator/kustomization.yaml <<'EOF'
images:
  - name: ghcr.io/ovrclk/akash:stable
    newName: ghcr.io/ovrclk/provider-services
    newTag: 0.1.0
EOF

kubectl kustomize _docs/kustomize/akash-hostname-operator | kubectl apply -f -
```

### **STEP 10 - Ingress Controller**

The Akash provider requires an ingress controller in the Kubernetes cluster.

#### Ingress Controller Install

* On the Kubernetes master node, download and install the ingress controller YAML files

```
wget https://raw.githubusercontent.com/ovrclk/provider-services/v0.1.0/_run/ingress-nginx-class.yaml
kubectl apply -f ./ingress-nginx-class.yaml

wget https://raw.githubusercontent.com/ovrclk/provider-services/v0.1.0/_run/ingress-nginx.yaml
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
kubectl label nodes node4 akash.network/role=ingress
```

### STEP 11 - Disable Swap on Kubernetes Hosts

The Kubelet process on Kubernetes worker nodes does not support swap.  Issue the following command on each worker node to disable swap.

```
swapoff -a
```

We should in addition ensure that swap is permanently disabled on the Linux hosts via:

* Open the /etc/fstab file
* Search for a swap line and add a # (hashtag) sign in front of the line to comment out the entire line

```
vi /etc/fstab
```

### STEP 12 - Review Firewall Policies

#### External/Internet Firewall Rules

The following firewall rules are applicable to internet facing Kubernetes components.

_Akash Provider_

```
8443/tcp - for manifest uploads
```

_Akash Ingress Controller_

```
80/tcp - for web app deployments
443/tcp - for web app deployments
30000-32767/tcp - for Kubernetes node port range for deployments
30000-32767/udp - for Kubernetes node port range for deployments
```

#### Internal (LAN) Firewall Rules

If local firewall instances are running on Kubernetes control-plane and worker nodes, add the following policies.

_Etcd Key Value Store Policies_

Ensure the following ports are open inbound on all Kubernetes etcd instances:

```
- 2379/tcp for client requests; (Kubernetes control plane to etcd)
- 2380/tcp for peer communication; (etcd to etcd communication)
```

_API Server Policies_

Ensure the following ports are open inbound on all Kubernetes API server instances:

```
- 6443/tcp - Kubernetes API server
```

_**Worker Node Policies**_

Ensure the following ports are open inbound on all Kubernetes worker nodes:

```
- 10250/tcp - Kubelet API server; (Kubernetes control plane to kubelet)
```
