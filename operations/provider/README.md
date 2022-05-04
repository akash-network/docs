# Build a Cloud Provider

## Prerequisites of an Akash Provider

### Wallet Funding - Minimum of 5 AKT

Placing a bid on an order requires a 5 AKT deposit. This deposit is fully refunded after the bid is won/lost.&#x20;

The steps to create an Akash account are covered in the Provider setup section of this [document](https://docs.akash.network/token/keplr).

### Kubernetes Cluster

* A full Kubernetes cluster is required.
* The cluster must have outbound internet access and be reachable from the internet.
* Please use [this guide](https://docs.akash.network/operations/provider/kubernetes-cluster) for ALL Kubernetes related configurations.  This guide covers a _**full cluster build**_, should it be needed, AND important details for new/pre-existing cluster configurations of _**custom resource definitions and ingress controllers**_ for the Akash provider.

### Custom Kubernetes Cluster Settings

Akash Providers are deployed in many environments and we will make additions to these sections as when nuances are discovered.

* [VMware Tanzu](broken-reference)

## Quickstart Guides

<details>

<summary>Create a Kubernetes cluster and start your first provider</summary>

```
#!/bin/bash
#This bootstrap makes some assumptions:
#1 : 3 new bare-metal servers/vps/vm's using Debian 11 / must have root user and ssh password login enabled.
#2 : A control machine with Debian 10/11 that will be seperate from the cluster. You will run this file from the control machine and use it to install Akash onto the cluster.
#3 : Update USER, SSHPASS, NODE1, NODE2, NODE3 with your servers info.  You can add as many nodes as you like, just use the same format. "export NODEX=x.x.x.x@password"
#set -e
###Server settings
USER=root #user on nodes to use/should be root.
export NODE1=192.168.1.36@test #node IP
export NODE2=192.168.1.26@test #node IP
export NODE3=192.168.1.27@test #node IP
###

declare -a IPS
readarray -t IPS <<< $(
  env | \
    grep '^NODE[[:digit:]]\+=' | sort | cut -d= -f2
)
echo "using pools ${IPS[*]}"


if [ "$EUID" -ne 0 ]
  then echo "Please run as root!"
  exit
fi


COUNTER=0

function depends(){
apt-get update ; apt-get install -y python3-pip git sshpass software-properties-common snapd curl rsync libffi-dev
python3 -m pip install ansible
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
git clone https://github.com/kubernetes-sigs/kubespray.git ; cd kubespray
git checkout v2.18.0
pip3 install -r requirements.txt
}
depends

#Assign static IP to your Kubernetes Hosts and update the user and IP address below

if [[ -f nodes.log ]]; then rm nodes.log; fi
if [[ -f $HOME/.ssh/id_rsa ]]; then
echo "Found SSH key on local machine"
cat ~/.ssh/id_rsa.pub
else
echo "Making an SSH key on control machine"
ssh-keygen -t rsa -C $(hostname) -f "$HOME/.ssh/id_rsa" -P "" ; cat ~/.ssh/id_rsa.pub
fi

for HOST in "${IPS[@]}"
do
COUNTER=$(( COUNTER + 1 ))
IP=$(echo $HOST | cut -d'@' -f1)
PASS=$(echo $HOST | cut -d'@' -f2)

if ping -c 1 $IP &> /dev/null
then
echo "Found ping to $IP"
else
echo "All hosts not ready"
exit
fi

echo $HOST
echo $USER
echo $IP
echo $PASS
echo $COUNTER
export SSHPASS=$PASS
echo $IP >> nodes.log

if ssh -o BatchMode=yes -o ConnectTimeout=2 root@$IP exit
then
echo "Found good connection with correct SSH to $IP"
else
ssh-keyscan $IP >> ~/.ssh/known_hosts
sshpass -e ssh-copy-id -i ~/.ssh/id_rsa.pub $USER@$IP
ssh -n $USER@$IP "sed -i '/swap/ s/^/#/' /etc/fstab"
ssh -n $USER@$IP echo "br_netfilter" >> /etc/modules
ssh -n $USER@$IP hostnamectl set-hostname node${COUNTER} ; hostname -f
ssh -n $USER@$IP "echo 127.0.1.1     node${COUNTER} > /etc/hosts ; cat /etc/hosts"
ssh -n $USER@$IP reboot
fi

done
unset SSHPASS
echo "All hosts rebooted, waiting for them to all come online"
sleep 3

printf "Waiting for $(cat nodes.log | tail -n1):22"
until nc -z $(cat nodes.log | tail -n1) 22 2>/dev/null; do
    printf 'Found port 22 alive!  Waiting 15 more seconds for things to settle down...'
    sleep 15
done
echo "up! Ready for Kubespraying!"

function ansible(){
#Setup ansible
cp -rfp inventory/sample inventory/akash
#Create config.yaml
CONFIG_FILE=inventory/akash/hosts.yaml python3 contrib/inventory_builder/inventory.py $(cat nodes.log | sed -e :a -e '$!N; s/\n/ /; ta')
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

function start_cluster(){
#Run
ansible-playbook -i inventory/akash/hosts.yaml -b -v --private-key=~/.ssh/id_rsa cluster.yml
#Get the kubeconfig from master node
rsync -av root@$(cat nodes.log | head -n1):/root/.kube/config kubeconfig
#Use the new kubeconfig file for kubectl
export KUBECONFIG=./kubeconfig
#Get snap path right
export PATH=$PATH:/snap/bin
#Install kubectl and helm using snap
snap install kubectl --classic
snap install helm --classic
#Change the name of the server address in kubeconfig to master
sed -i "s/127.0.0.1/$(cat nodes.log | head -n1)/g" kubeconfig
cp kubeconfig ../kubeconfig
#Show the pods!
}
start_cluster

sleep 5
cd ..
export KUBECONFIG=./kubeconfig
kubectl get nodes -o wide

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

## Akash Provider Setup

### Provider Setup Overview

The following sections will explore each step of the Akash provider setup in detail.

### STEP1 - Select a Host to Run the Akash Provider

The Akash provider can be installed on any Kubernetes master or worker node.  Or if preferred the provider may be installed on a separate host outside of the Kubernetes cluster.

* NOTE - if the Provider is installed on a Kubernetes host - ensure that it does not reside on the same host as the Ingress Controller as this could cause TCP port 8443 conflicts.

### STEP2 - Install Akash Software

The Akash software install process on a Linux server is shown in this step.

_**Specify the Akash Version**_

* These commands will retrieve the latest, stable version of the Akash software_**,**_ store the version in a local variable, and install that version.

```
AKASH_VERSION="$(curl -s "https://raw.githubusercontent.com/ovrclk/net/master/mainnet/version.txt")"

curl https://raw.githubusercontent.com/ovrclk/akash/master/godownloader.sh | sh -s -- "v$AKASH_VERSION"
```

_**Add Akash Install Location to User’s Path**_

Add the software’s install location to the user’s path for easy use of Akash commands.

**NOTE** - below we provide the steps to add the Akash install directory to a user’s path on a Linux Ubuntu server.  Please take a look at a guide for your operating system and how to add a directory to a user’s path.

_Open the user’s path file in an editor:_

```
vi /etc/environment
```

_View within text editor prior to the update:_

```
PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin"                                                                   
```

_Add the following directory, which is the Akash install location, to PATH:_

```
/root/bin
```

_View within the text editor following the update:_

```
PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/root/bin"
```

_Make the new path active in the current session:_

```
​​source /etc/environment
```

_Display the version of Akash software installed. This confirms the software installed and that the new user path addition worked._

```
akash version
```

_Expected result_:

```
root@node2:~# akash version
v0.14.1
```

### STEP3 - Create/Import Akash Account

For a Provider to bid on leases an account is needed with minimum funding of 5 AKT.  An account can be created by using the commands of this section.  Alternatively an existing account could be imported for provider use.

_**Specify a key with your choice of name:**_

```
AKASH_KEY_NAME=<name>
```

_**Specify the location of the keyring on the provider:**_

```
AKASH_KEYRING_BACKEND=file
```

_**Create the new account and store the encrypted private key in the keyring**_

* Enter a passphrase of your choice when prompted

```
akash --keyring-backend "$AKASH_KEYRING_BACKEND"  keys add "$AKASH_KEY_NAME"
```

_**Expected results:**_

```
root@node2:~# AKASH_KEY_NAME=providerkey
root@node2:~# ​​AKASH_KEYRING_BACKEND=file
root@node2:~# akash --keyring-backend "$AKASH_KEYRING_BACKEND"  keys add "$AKASH_KEY_NAME"
Enter keyring passphrase:
Re-enter keyring passphrase:

- name: providerkey
  type: local
  address: akash16hxyzpwgp9elpl52yvll9gczr3vyanfgmdvh4x
  pubkey: akashpub1addwnpepqwz556cp568gk6tj9yxmqshmqad6pj0nnfnqzfufez2fd2jh94fr6y763nc
  mnemonic: ""
  threshold: 0
  pubkeys: []


**Important** write this mnemonic phrase in a safe place.
It is the only way to recover your account if you ever forget your password.

escape dry gate <redacted>  prosper human
```

### STEP4 - Verify Account Balance

We should verify the minimum account balance for the provider now that the account has been set up. As mentioned, the account needs slightly more than 5 AKT at a minimum.

_**Specify the Akash network to query (in this case the mainnet):**_

```
AKASH_NET="https://raw.githubusercontent.com/ovrclk/net/master/mainnet"
```

_**Query the network for an available node to communicate with:**_

```
export AKASH_NODE="$(curl -s "$AKASH_NET/rpc-nodes.txt" | shuf -n 1)"
```

_**Store the account created in the previous step. Replace the variable portion with your account address (I.e. account such as akash1wpfyf47tzu70q3vu893mghz657gk2kgkuaj5zq):**_

```
AKASH_ACCOUNT_ADDRESS=<account-address>
```

_**Get your account balance:**_

```
akash --node "$AKASH_NODE" query bank balances "$AKASH_ACCOUNT_ADDRESS"
```

_**Example output:**_

```
root@node2:~# akash --node "$AKASH_NODE" query bank balances "$AKASH_ACCOUNT_ADDRESS"
balances:
- amount: "15000000"
  denom: uakt
pagination:
  next_key: null
  total: "0"
```

### STEP5 - Create the Provider

Use the host that the Akash software was installed on for this section.

_**Deployment Domain**_

* Create the environment variable of PROVIDER\_AKASH\_DOMAIN&#x20;
* This domain is used whenever a lease owner needs to speak directly with the provider to send a manifest or get a lease status&#x20;

```
export PROVIDER_AKASH_DOMAIN=<provider-host-domain-name>
```

_**Create provider.yaml File**_

* Create a file with the name of provider.yaml and add the contents below
* **NOTE** - Please replace <`PROVIDER_AKASH_DOMAIN>` variable with your akash domain (i.e. `provider.<yourdomain>.com`)
* _**Attributes**_** -** a thorough discussion of provider attributes can be found [here](https://docs.akash.network/operations/akash-audited-attributes).

```
host: https://<PROVIDER_AKASH_DOMAIN>:8443
attributes:
  - key: host
    value: <nameOfYourOrganization>
```

_**Create the Akash Provider**_

* Register the provider on the Akash Network&#x20;
* Three new environment variables are added that the provider create command will use&#x20;
* Replace the AKASH\_PROVIDER\_KEY with the name of the key created earlier (I.e. providerkey in the example)&#x20;
* Replace the AKASH\_HOME with the location of the keychain (I.e. /root/.akash in the example)

```
export AKASH_CHAIN_ID="$(curl -s "$AKASH_NET/chain-id.txt")"
AKASH_PROVIDER_KEY=<key-name>
AKASH_HOME=<keyring-location>

export AKASH_GAS_PRICES=0.025uakt
export AKASH_GAS=auto
export AKASH_GAS_ADJUSTMENT=1.3
```

```
akash tx provider create provider.yaml --from $AKASH_PROVIDER_KEY --home=$AKASH_HOME --keyring-backend=$AKASH_KEYRING_BACKEND --node=$AKASH_NODE --chain-id=$AKASH_CHAIN_ID
```

_**Example of Creating the Provider**_

```
export AKASH_CHAIN_ID="$(curl -s "$AKASH_NET/chain-id.txt")"
AKASH_PROVIDER_KEY=providerkey
AKASH_HOME=/root/.akash
```

```
root@node1:~# akash tx provider create provider.yaml --from $AKASH_PROVIDER_KEY --home=$AKASH_HOME --keyring-backend=$AKASH_KEYRING_BACKEND --node=$AKASH_NODE --chain-id=$AKASH_CHAIN_ID

Enter keyring passphrase:

{"body":{"messages":[{"@type":"/akash.provider.v1beta1.MsgCreateProvider","owner":"akash1xmz9es9ay9ln9x2m3q8dlu0alxf0ltce7ykjfx","host_uri":"https://$DEPLOYMENT_HOSTNAME:8443","attributes":[{"key":"host","value":"chainzero"}],"info":{"email":"","website":""}}],"memo":"","timeout_height":"0","extension_options":[],"non_critical_extension_options":[]},"auth_info":{"signer_infos":[],"fee":{"amount":[{"denom":"uakt","amount":"5000"}],"gas_limit":"200000","payer":"","granter":""}},"signatures":[]}

confirm transaction before signing and broadcasting [y/N]: y

{"height":"3413672","txhash":"E9CA2D1ED5FF449E132531C9F6CCBD41F95F01D71C745005E00432852204C564","codespace":"","code":0,"data":"0A110A0F6372656174652D70726F7669646572","raw_log":"[{\"events\":[{\"type\":\"akash.v1\",\"attributes\":[{\"key\":\"module\",\"value\":\"provider\"},{\"key\":\"action\",\"value\":\"provider-created\"},{\"key\":\"owner\",\"value\":\"akash1xmz9es9ay9ln9x2m3q8dlu0alxf0ltce7ykjfx\"}]},{\"type\":\"message\",\"attributes\":[{\"key\":\"action\",\"value\":\"create-provider\"},{\"key\":\"sender\",\"value\":\"akash1xmz9es9ay9ln9x2m3q8dlu0alxf0ltce7ykjfx\"}]},{\"type\":\"transfer\",\"attributes\":[{\"key\":\"recipient\",\"value\":\"akash17xpfvakm2amg962yls6f84z3kell8c5lazw8j8\"},{\"key\":\"sender\",\"value\":\"akash1xmz9es9ay9ln9x2m3q8dlu0alxf0ltce7ykjfx\"},{\"key\":\"amount\",\"value\":\"5000uakt\"}]}]}]","logs":[{"msg_index":0,"log":"","events":[{"type":"akash.v1","attributes":[{"key":"module","value":"provider"},{"key":"action","value":"provider-created"},{"key":"owner","value":"akash1xmz9es9ay9ln9x2m3q8dlu0alxf0ltce7ykjfx"}]},{"type":"message","attributes":[{"key":"action","value":"create-provider"},{"key":"sender","value":"akash1xmz9es9ay9ln9x2m3q8dlu0alxf0ltce7ykjfx"}]},{"type":"transfer","attributes":[{"key":"recipient","value":"akash17xpfvakm2amg962yls6f84z3kell8c5lazw8j8"},{"key":"sender","value":"akash1xmz9es9ay9ln9x2m3q8dlu0alxf0ltce7ykjfx"},{"key":"amount","value":"5000uakt"}]}]}],"info":"","gas_wanted":"200000","gas_used":"64055","tx":null,"timestamp":""}

root@node1:~#
```



### STEP6 - Create a TLS Certificate

#### Generate Server Certificate

* Note: If it errors with `Error: certificate error: cannot overwrite certificate`, then add `--overwrite` should you want to overwrite the cert. Normally you can ignore that error and proceed with publishing the cert (next step).

```
akash tx cert generate server $PROVIDER_AKASH_DOMAIN --chain-id $AKASH_CHAIN_ID --keyring-backend $AKASH_KEYRING_BACKEND --from $AKASH_PROVIDER_KEY --home=$AKASH_HOME --node=$AKASH_NODE --gas-prices="0.025uakt" --gas="auto" --gas-adjustment=1.15
```

#### Publish Certificate

```
akash tx cert publish server --chain-id $AKASH_CHAIN_ID --keyring-backend $AKASH_KEYRING_BACKEND --from $AKASH_PROVIDER_KEY --home=$AKASH_HOME --node=$AKASH_NODE --gas-prices="0.025uakt" --gas="auto" --gas-adjustment=1.15
```

### STEP7 - Configure Kubectl

If the provider is on a non-Kubernetes master node, kubectl and the kubeconfig file might not be present.  In this step we will create the kubeconfig file on the provider host which is necessary when we try to start the provider.

_**Verify Kubeconfig File**_

* On the provider host, verify if the kubeconfig file is present&#x20;
* We are looking for the presence of the .kube directory within the user’s home directory

```
cd ~
ls -al
```

_**Example output of directory contents**_

* In this example the .kube directory does not exist and we will need to create it&#x20;
* If the directory does exist and you are able to conduct kubectl commands (I.e. “kubectl get nodes”), feel free to skip forward to STEP8

```
root@node2:~# ls -al
total 56
drwx------  8 root root 4096 Nov  8 21:23 .
drwxr-xr-x 19 root root 4096 Nov  1 14:53 ..
drwx------  5 root root 4096 Nov  8 21:06 .akash
drwx------  3 root root 4096 Nov  2 18:49 .ansible
-rw-------  1 root root   74 Nov  2 16:38 .bash_history
-rw-r--r--  1 root root 3106 Dec  5  2019 .bashrc
drwx------  2 root root 4096 Nov  2 16:38 .cache
-rw-r--r--  1 root root  161 Dec  5  2019 .profile
drwx------  2 root root 4096 Nov  1 14:53 .ssh
-rw-------  1 root root 7349 Nov  8 21:03 .viminfo
drwxr-xr-x  2 root root 4096 Nov  8 20:38 bin
-rw-r--r--  1 root root  118 Nov  8 21:03 provider.yaml
drwxr-xr-x  4 root root 4096 Nov  1 14:53 snap
root@node2:~#
```

_**Create a .kube Directory**_

```
mkdir .kube
```

_**Copy Kubeconfig to the Provider**_

* We will use the following command to copy the config file from the Kubernetes master to the provider host&#x20;
* Replace the username and IP address parts of the command

```
scp <username>@<ipaddress>:/root/.kube/config /root/.kube/config
```

_**Install Kubectl on the Provider**_

```
stable=$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)

curl -LO https://storage.googleapis.com/kubernetes-release/release/${stable}/bin/linux/amd64/kubectl

chmod +x ./kubectl

sudo mv ./kubectl /usr/local/bin/kubectl
```

_**Verify Kubectl**_

* Following the copy of the kubeconfig file and the kubectl install, you should be able to execute commands like “kubectl get nodes” as shown in example below

```
root@node2:~# kubectl get nodes
NAME    STATUS   ROLES                  AGE    VERSION
node1   Ready    control-plane,master   6d2h   v1.22.3
node2   Ready    control-plane,master   6d2h   v1.22.3
node3   Ready    <none>                 6d2h   v1.22.3
```

### STEP8 - Start the Provider

In our final step the provider is started.  We will run the provider process as a service to ensure it remains active across server reboots.

_**Domain Name Notes**_

* The variable used as the value for --cluster-public-hostname during provider start up and is the publicly accessible hostname of the Kubernetes cluster.
* If multiple master nodes exist in the Kubernetes cluster, either the DNS record should point to the IP addresses of all master nodes or an alternative load balancing strategy should be used.

_**Store Keyring Passphrase**_

```
echo "mypassword" | tee /root/akash/key-pass.txt
```

_**Create Script**_

```
cat > /root/akash/start-provider.sh << 'EOF'
#!/usr/bin/env bash

export AKASH_NET="https://raw.githubusercontent.com/ovrclk/net/master/mainnet"
export AKASH_NODE="$(curl -s "$AKASH_NET/rpc-nodes.txt" | shuf -n 1)"
export AKASH_HOME=/root/.akash
export AKASH_CHAIN_ID="$(curl -s "$AKASH_NET/chain-id.txt")"
export AKASH_PROVIDER_KEY=<REPLACE-WITH-PROVIDER-KEY>
export PROVIDER_INGRESS_DOMAIN=<REPLACE-WITH-PUBLIC-DOMAIN>
export PROVIDER_AKASH_DOMAIN=<REPLACE-WITH-PUBLIC-DOMAIN>

cd /root/akash
( sleep 2s; cat key-pass.txt; cat key-pass.txt ) | \
  /root/bin/akash provider run \
  --home $AKASH_HOME \
  --chain-id $AKASH_CHAIN_ID \
  --node $AKASH_NODE \
  --keyring-backend=file \
  --from $AKASH_PROVIDER_KEY \
  --fees 1000uakt \
  --kubeconfig $KUBECONFIG \
  --cluster-k8s true \
  --deployment-ingress-domain $PROVIDER_INGRESS_DOMAIN \
  --deployment-ingress-static-hosts true \
  --bid-price-strategy scale \
  --bid-price-cpu-scale 0.001 \
  --bid-price-memory-scale 0.001 \
  --bid-price-storage-scale 0.00001 \
  --bid-price-endpoint-scale 0 \
  --bid-deposit 5000000uakt \
  --cluster-node-port-quantity 1000 \
  --cluster-public-hostname $PROVIDER_AKASH_DOMAIN

EOF
```

_**Make Script Executable**_

```
chmod +x /root/akash/start-provider.sh
```

_**Create Service**_

```
cat > /etc/systemd/system/akash-provider.service << 'EOF'
[Unit]
Description=Akash Provider
After=network.target

[Service]
User=root
Group=root
ExecStart=/root/akash/start-provider.sh
KillSignal=SIGINT
Restart=on-failure
RestartSec=15
StartLimitInterval=200
StartLimitBurst=10
#LimitNOFILE=65535

[Install]
WantedBy=multi-user.target
EOF
```

_**Start and Persist the Provider Service**_

```
systemctl daemon-reload
systemctl start akash-provider
systemctl enable akash-provider
```

_**Confirm the Provide Status**_

```
journalctl -u akash-provider --since '5 min ago' -f
```



### STEP9 - Create the Hostname Operator Service

```
cat /etc/systemd/system/akash-hostname-operator.service
[Unit]
Description=Akash Hostname Operator
After=network.target

[Service]
User=root
Group=root
ExecStart=akash provider hostname-operator
KillSignal=SIGINT
Restart=on-failure
RestartSec=15
StartLimitInterval=200
StartLimitBurst=10
#LimitNOFILE=65535

[Install]
WantedBy=multi-user.target
```



### STEP10- Start the Hostname Operator Service

```
systemctl start akash-hostname-operator
systemctl enable akash-hostname-operato
```
