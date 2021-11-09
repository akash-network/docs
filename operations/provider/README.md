# Build a Cloud Provider

## Prerequisites of an Akash Provider

### Wallet Funding - Minimum of 5 AKT

Placing a bid on an order requires a 5 AKT deposit. This deposit is fully refunded after the bid is won/lost.&#x20;

The steps to create an Akash account are covered in the Provider setup section of this document.

### Kubernetes Cluster

* A full Kubernetes cluster is required.
* This guide offers one possible path for cluster creation via Kubespray:
  * [ ] [https://docs.akash.network/operations/provider/kubernetes-cluster ](https://docs.akash.network/operations/provider/kubernetes-cluster)
* The cluster must have outbound internet access and be reachable from the internet.

## Akash Provider Setup

### Provider Setup Overview

The following sections will explore each step of the Akash provider setup in detail.

### STEP1 - Select a Host to Run the Akash Provider

The Akash provider can be installed on any Kubernetes master or worker node. Or if preferred the provider may be installed on a separate host outside of the Kubernetes cluster.

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
~                                                                                                                                                                                                          
~                                                                                                                                                                                                          
~  
```

_Add the following directory, which is the Akash install location, to PATH:_

```
/root/bin
```

_View within the text editor following the update:_

```
PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/root/bin"
~                                                                                                                                                                                                          
~                                                                                                                                                                                                          
~ 
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
v0.14.0
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

* Create the environment variable of DEPLOYMENT\_HOSTNAME&#x20;
* This domain is used whenever a lease owner needs to speak directly with the provider to send a manifest or get a lease status&#x20;
* The public DNS record for the domain should point to the Kubernetes ingress controller
* ```
  export DEPLOYMENT_HOSTNAME=<provider-host-domain-name>
  ```

_**Create provider.yaml File**_

* Create a file with the name of provider.yaml and add the contents below

```
host: https://$DEPLOYMENT_HOSTNAME:8443
attributes:
  - key: region
    value: us-west
  - key: host
    value: <nameOfYourOrganization>
```

_**Example of Creating Provider File**_

* These screenshots shows the previous steps for further clarity

```
root@node1:~# export DEPLOYMENT_HOSTNAME=chainzeroakash.net
root@node1:~# vi provider.yaml
```

* File details within an editor

```
host: https://$DEPLOYMENT_HOSTNAME:8443
attributes:
  - key: region
    value: us-west
  - key: host
    value: chainzero
~                                                                                                                                                                                                          
~   
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
```

```
akash tx provider create provider.yaml --from $AKASH_PROVIDER_KEY --home=$AKASH_HOME --keyring-backend=$AKASH_KEYRING_BACKEND --node=$AKASH_NODE --chain-id=$AKASH_CHAIN_ID --fees 5000uakt
```

_**Example of Creating the Provider**_

```
export AKASH_CHAIN_ID="$(curl -s "$AKASH_NET/chain-id.txt")"
AKASH_PROVIDER_KEY=providerkey
AKASH_HOME=/root/.akash
```

```
root@node1:~# akash tx provider create provider.yaml --from $AKASH_PROVIDER_KEY --home=$AKASH_HOME --keyring-backend=$AKASH_KEYRING_BACKEND --node=$AKASH_NODE --chain-id=$AKASH_CHAIN_ID --fees 5000uakt

Enter keyring passphrase:

{"body":{"messages":[{"@type":"/akash.provider.v1beta1.MsgCreateProvider","owner":"akash1xmz9es9ay9ln9x2m3q8dlu0alxf0ltce7ykjfx","host_uri":"https://$DEPLOYMENT_HOSTNAME:8443","attributes":[{"key":"region","value":"us-west"},{"key":"host","value":"chainzero"}],"info":{"email":"","website":""}}],"memo":"","timeout_height":"0","extension_options":[],"non_critical_extension_options":[]},"auth_info":{"signer_infos":[],"fee":{"amount":[{"denom":"uakt","amount":"5000"}],"gas_limit":"200000","payer":"","granter":""}},"signatures":[]}

confirm transaction before signing and broadcasting [y/N]: y

{"height":"3413672","txhash":"E9CA2D1ED5FF449E132531C9F6CCBD41F95F01D71C745005E00432852204C564","codespace":"","code":0,"data":"0A110A0F6372656174652D70726F7669646572","raw_log":"[{\"events\":[{\"type\":\"akash.v1\",\"attributes\":[{\"key\":\"module\",\"value\":\"provider\"},{\"key\":\"action\",\"value\":\"provider-created\"},{\"key\":\"owner\",\"value\":\"akash1xmz9es9ay9ln9x2m3q8dlu0alxf0ltce7ykjfx\"}]},{\"type\":\"message\",\"attributes\":[{\"key\":\"action\",\"value\":\"create-provider\"},{\"key\":\"sender\",\"value\":\"akash1xmz9es9ay9ln9x2m3q8dlu0alxf0ltce7ykjfx\"}]},{\"type\":\"transfer\",\"attributes\":[{\"key\":\"recipient\",\"value\":\"akash17xpfvakm2amg962yls6f84z3kell8c5lazw8j8\"},{\"key\":\"sender\",\"value\":\"akash1xmz9es9ay9ln9x2m3q8dlu0alxf0ltce7ykjfx\"},{\"key\":\"amount\",\"value\":\"5000uakt\"}]}]}]","logs":[{"msg_index":0,"log":"","events":[{"type":"akash.v1","attributes":[{"key":"module","value":"provider"},{"key":"action","value":"provider-created"},{"key":"owner","value":"akash1xmz9es9ay9ln9x2m3q8dlu0alxf0ltce7ykjfx"}]},{"type":"message","attributes":[{"key":"action","value":"create-provider"},{"key":"sender","value":"akash1xmz9es9ay9ln9x2m3q8dlu0alxf0ltce7ykjfx"}]},{"type":"transfer","attributes":[{"key":"recipient","value":"akash17xpfvakm2amg962yls6f84z3kell8c5lazw8j8"},{"key":"sender","value":"akash1xmz9es9ay9ln9x2m3q8dlu0alxf0ltce7ykjfx"},{"key":"amount","value":"5000uakt"}]}]}],"info":"","gas_wanted":"200000","gas_used":"64055","tx":null,"timestamp":""}

root@node1:~#
```

### STEP6 - Create a TLS Certificate

Create a TLS certificate for your provider. The certificate will be stored on the blockchain.

```
akash tx cert create server $DEPLOYMENT_HOSTNAME --chain-id $AKASH_CHAIN_ID --keyring-backend $AKASH_KEYRING_BACKEND --from $AKASH_PROVIDER_KEY --home=$AKASH_HOME --node=$AKASH_NODE --fees 5000uakt
```

_**Example of Creating the Certificate**_

```
root@node1:~# 

root@node1:~# akash tx cert create server $DEPLOYMENT_HOSTNAME --chain-id $AKASH_CHAIN_ID --keyring-backend $AKASH_KEYRING_BACKEND --from $AKASH_PROVIDER_KEY --home=$AKASH_HOME --node=$AKASH_NODE --fees 5000uakt

Enter keyring passphrase:

no certificate found for address akash1xmz9es9ay9ln9x2m3q8dlu0alxf0ltce7ykjfx. generating new...

Enter keyring passphrase:

{"body":{"messages":[{"@type":"/akash.cert.v1beta1.MsgCreateCertificate","owner":"akash1xmz9es9ay9ln9x2m3q8dlu0alxf0ltce7ykjfx","cert":"LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSUNFRENDQWJhZ0F3SUJBZ0lJRnJYcVY3ZU9BRTR3Q2dZSUtvWkl6ajBFQXdJd1NqRTFNRE1HQTFVRUF4TXMKWVd0aGMyZ3hlRzE2T1dWek9XRjVPV3h1T1hneWJUTnhPR1JzZFRCaGJIaG1NR3gwWTJVM2VXdHFabmd4RVRBUApCZ1ZuZ1FVQ0JoTUdkakF1TUM0eE1CNFhEVEl4TVRFd09URTFNamd5TWxvWERUSXlNVEV3T1RFMU1qZ3lNbG93ClNqRTFNRE1HQTFVRUF4TXNZV3RoYzJneGVHMTZPV1Z6T1dGNU9XeHVPWGd5YlROeE9HUnNkVEJoYkhobU1HeDAKWTJVM2VXdHFabmd4RVRBUEJnVm5nUVVDQmhNR2RqQXVNQzR4TUZrd0V3WUhLb1pJemowQ0FRWUlLb1pJemowRApBUWNEUWdBRTYrY1Q0ZkprQ3FjK01ibGdKdldjREhLK3BGL1JLb241V3NLSGdqODZDNnZpT2dGa3ZhRzVocGdZCkV2SXl2YkwvdHNxdjFtZ0I3ZzNnRG1ZTnNFaSt0YU9CaFRDQmdqQU9CZ05WSFE4QkFmOEVCQU1DQkRBd0hRWUQKVlIwbEJCWXdGQVlJS3dZQkJRVUhBd0lHQ0NzR0FRVUZCd01CTUF3R0ExVWRFd0VCL3dRQ01BQXdIUVlEVlIwUgpCQll3RklJU1kyaGhhVzU2WlhKdllXdGhjMmd1Ym1WME1DUUdBMVVkSGdFQi93UWFNQmlnRmpBVWdoSmphR0ZwCmJucGxjbTloYTJGemFDNXVaWFF3Q2dZSUtvWkl6ajBFQXdJRFNBQXdSUUloQU01c3NzaWJ6alpsRmdBWE9vdVQKTWc5YlBUeFBGNHNTZGNzcUFwOW9xSjh2QWlCQ2V0c2pwanlXWUhmdFBELzV0eGJVNFhqNUg4NWltYzY2d0lHSApqUFZCNnc9PQotLS0tLUVORCBDRVJUSUZJQ0FURS0tLS0tCg==","pubkey":"LS0tLS1CRUdJTiBFQyBQVUJMSUMgS0VZLS0tLS0KTUZrd0V3WUhLb1pJemowQ0FRWUlLb1pJemowREFRY0RRZ0FFNitjVDRmSmtDcWMrTWJsZ0p2V2NESEsrcEYvUgpLb241V3NLSGdqODZDNnZpT2dGa3ZhRzVocGdZRXZJeXZiTC90c3F2MW1nQjdnM2dEbVlOc0VpK3RRPT0KLS0tLS1FTkQgRUMgUFVCTElDIEtFWS0tLS0tCg=="}],"memo":"","timeout_height":"0","extension_options":[],"non_critical_extension_options":[]},"auth_info":{"signer_infos":[],"fee":{"amount":[{"denom":"uakt","amount":"5000"}],"gas_limit":"200000","payer":"","granter":""}},"signatures":[]}

confirm transaction before signing and broadcasting [y/N]: y

{"height":"3413739","txhash":"7E7D6E588956E39607DF7986A7B1FF75327D8456C3D18A2581BABDC5EB24E623","codespace":"","code":0,"data":"0A190A17636572742D6372656174652D6365727469666963617465","raw_log":"[{\"events\":[{\"type\":\"message\",\"attributes\":[{\"key\":\"action\",\"value\":\"cert-create-certificate\"},{\"key\":\"sender\",\"value\":\"akash1xmz9es9ay9ln9x2m3q8dlu0alxf0ltce7ykjfx\"}]},{\"type\":\"transfer\",\"attributes\":[{\"key\":\"recipient\",\"value\":\"akash17xpfvakm2amg962yls6f84z3kell8c5lazw8j8\"},{\"key\":\"sender\",\"value\":\"akash1xmz9es9ay9ln9x2m3q8dlu0alxf0ltce7ykjfx\"},{\"key\":\"amount\",\"value\":\"5000uakt\"}]}]}]","logs":[{"msg_index":0,"log":"","events":[{"type":"message","attributes":[{"key":"action","value":"cert-create-certificate"},{"key":"sender","value":"akash1xmz9es9ay9ln9x2m3q8dlu0alxf0ltce7ykjfx"}]},{"type":"transfer","attributes":[{"key":"recipient","value":"akash17xpfvakm2amg962yls6f84z3kell8c5lazw8j8"},{"key":"sender","value":"akash1xmz9es9ay9ln9x2m3q8dlu0alxf0ltce7ykjfx"},{"key":"amount","value":"5000uakt"}]}]}],"info":"","gas_wanted":"200000","gas_used":"90954","tx":null,"timestamp":""}

root@node1:~#
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

In our final step the provider is started.

_**Kubernetes Domain**_

* Create the environment variable of KUBERNETES\_HOSTNAME
* The variable will be used as the value for --cluster-public-hostname during provider start up and is the publicly accessible hostname of the Kubernetes cluster.
* If multiple master nodes exist in the Kubernetes cluster, either the DNS record should point to the IP addresses of all master nodes or an alternative load balancing strategy should be used.
* **NOTE - **within this guide --cluster-public-hostname (Kubernetes Cluster) and  --deployment-ingress-domain (Ingress Controller/Provider) point to the same domain name but often the domains will be different.

```
export KUBERNETES_HOSTNAME=chainzeroakash.net
```

Start Provider

```
akash provider run \
  --home $AKASH_HOME \
  --chain-id $AKASH_CHAIN_ID \
  --node $AKASH_NODE \
  --keyring-backend=file \
  --from $AKASH_PROVIDER_KEY \
  --fees 1000uakt \
  --kubeconfig $KUBECONFIG \
  --cluster-k8s true \
  --deployment-ingress-domain $DEPLOYMENT_HOSTNAME \
  --deployment-ingress-static-hosts true \
  --bid-price-strategy scale \
  --bid-price-cpu-scale 0.001 \
  --bid-price-memory-scale 0.001 \
  --bid-price-storage-scale 0.00001 \
  --bid-price-endpoint-scale 0 \
  --bid-deposit 5000000uakt \
  --cluster-node-port-quantity 1000 \
  --cluster-public-hostname $KUBERNETES_HOSTNAME
```

_**Expected Output**_

* When the provider starts the initial output should look like the following.&#x20;
* The full output is not displayed but only the first lines indicating a successful start

```
root@node1:~# akash provider run   --home $AKASH_HOME   --chain-id $AKASH_CHAIN_ID   --node $AKASH_NODE   --keyring-backend=file   --from $AKASH_PROVIDER_KEY   --fees 1000uakt   --kubeconfig $KUBECONFIG   --cluster-k8s true   --deployment-ingress-domain $DEPLOYMENT_HOSTNAME   --deployment-ingress-static-hosts true   --bid-price-strategy scale   --bid-price-cpu-scale 0.001   --bid-price-memory-scale 0.001   --bid-price-storage-scale 0.00001   --bid-price-endpoint-scale 0   --bid-deposit 5000000uakt   --cluster-node-port-quantity 1000   --cluster-public-hostname $KUBERNETES_HOSTNAME

Enter keyring passphrase:
Enter keyring passphrase:

I[2021-11-09|16:00:48.251] found leases                                 module=provider-cluster cmp=service num-active=0
I[2021-11-09|16:00:48.251] found deployments                            module=provider-cluster cmp=service num-active=0 num-skipped=0
D[2021-11-09|16:00:48.251] inventory ready                              module=provider-cluster cmp=service cmp=inventory-service
D[2021-11-09|16:00:48.251] inventory fetched                            module=provider-cluster cmp=service cmp=inventory-service nodes=1
D[2021-11-09|16:00:48.251] node resources                               module=provider-cluster cmp=service cmp=inventory-service node-id=solo available-cpu="units:<val:\"5000\" > " available-memory="quantity:<val:\"34359738368\" > " available-storage="quantity:<val:\"549755813888\" > "
I[2021-11-09|16:00:49.982] syncing sequence                             cmp=client/broadcaster local=2 remote=2
I[2021-11-09|16:00:51.558] found orders                                 module=bidengine-service count=109
D[2021-11-09|16:00:51.558] creating catchup order                       module=bidengine-service order=order/akash1057uu9jaehgqwk5g8g85nuq3esu0n2wxhejk9z/2200682/1/1
D[2021-11-09|16:00:51.558] creating catchup order                       module=bidengine-service order=order/akash109pttclfdj6erune0e8v9zed2pkvczq63u8yzp/3411023/1/1
D[2021-11-09|16:00:51.558] creating catchup order                       module=bidengine-service order=order/akash109pttclfdj6erune0e8v9zed2pkvczq63u8yzp/3411064/1/1
```
