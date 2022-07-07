# STEP 6 - Provider Build via Helm Chart

## **Environment Variables**

* Declare the following environment variables for Helm
* Replace the variable  with your own settings
* Notes on settings and values
  * Domain should be a publicly accessible DNS name dedicated for your provider use such as myprovider.com.

```
ACCOUNT_ADDRESS=akash1XXXX #akash provider address that starts with `akash1`
KEY_PASSWORD=12341234 #set to the password you have entered upon `akash keys export <key-name> > key.pem`; this is for the akash-provider pod to decrypt the key
DOMAIN=test.com  #Registers DNS A and wildcard address as specified in previous step, i.e. `provider.test.com` DNS A record and `*.ingress.test.com` DNS wildcard record
NODE=http://<IP_address_of_your_RPC_node>:26657  # if you are going to deploy Akash RPC Node using Helm-Charts then set it to `http://akash-node-1:26657`
```

## **Provider Helm Chart Build**

### **Provider Withdraw Period**

* Akash providers may dictate how often they withdraw funds consumed by active deployments/tenants escrow accounts
* Few things to consider regarding the provider withdraw period:
  * The default withdraw setting in the Helm Charts is one (1) hour
  * An advantage of the one hour default setting is assurance that a deployment may not breach the escrow account dramatically.  If the withdraw period were set to 24 hours instead - the deployment could exhaust the amount in escrow in one hour (for example) but the provider would not calculate this until many hours later and the deployment would essentially operate for free in the interim.
  * A disadvantage of frequent withdraws is the possibility of losing profitability based on fees incurred by the providers withdraw transactions.  If the provider hosts primarily low resource workloads, it is very possible that fees could exceed deployment cost/profit.

#### OPTIONAL - Update the Provider Withdraw Period

* If it is desired to change the withdrawl period from the default one hour setting, update the `withdrawalperiod` setting in the provider.yaml file created subsequently in this section.
* In the example the Provider Build section of this doc the withdrawl period has been set to 24 hours.  Please adjust as preferred.

### **Provider Build**

* Ensure you are applying the latest version of subsequent Helm Charts install/upgrade steps

```
helm repo update
```

#### Create a provider.yaml File

* Issue the following command to build your Akash Provider
* Update the following keys for your unique use case
  * `region`
  * `organization`

```
cd ~

mkdir provider

cd provider

cat > provider.yaml << EOF
---
from: "$ACCOUNT_ADDRESS"
key: "$(cat ~/key.pem | openssl base64 -A)"
keysecret: "$(echo $KEY_PASSWORD | openssl base64 -A)"
domain: "$DOMAIN"
node: "$NODE"
withdrawalperiod: 24h
attributes:
  - key: region
    value: "<YOUR REGION>"   # set your region here, e.g. "us-west"
  - key: host
    value: akash
  - key: tier
    value: community
  - key: organization
    value: "<YOUR ORG>"      # set your organization name here
EOF
```

**Example provider.yaml File Creation**

```
root@linux-server ~ % cat > provider.yaml << EOF
---
from: "$ACCOUNT_ADDRESS"
key: "$(cat ./key.pem | openssl base64 -A)"
keysecret: "$(echo $KEY_PASSWORD | openssl base64 -A)"
domain: "$DOMAIN"
node: "$NODE"
withdrawalperiod: 24h
attributes:
  - key: region
    value: us-east
  - key: host
    value: akash
  - key: tier
    value: community
  - key: organization
    value: myorganization
EOF
```

**Provider Bid Defaults**

* When a provider is created the default bid engine settings are used.  If desired these settings could be updated and added to the `provider.yaml` file.  But we would recommend initially using the default values.
* Note -  the `bidpricestoragescale` value will get overridden by `-f provider-storage.yaml` covered in [Provider Persistent Storage](../helm-based-provider-persistent-storage-enablement/) documentation.
* Note -  if you want to use a shellScript bid price strategy, pass the bid price script via `bidpricescript` variable detailed in the [bid pricing script doc](../akash-provider-bid-pricing/).  This will automatically suppress all `bidprice<cpu|memory|endpoint|storage>scale` settings.

```
bidpricecpuscale: "0.004" # cpu pricing scale in uakt per millicpu
bidpricememoryscale: "0.0016" # memory pricing scale in uakt per megabyte
bidpriceendpointscale: "0" # endpoint pricing scale in uakt per endpoint
bidpricestoragescale: "0.00016" # storage pricing scale in uakt per megabyte
```

#### **Install the Provider Helm Chart**

```
helm install akash-provider akash/provider -n akash-services -f provider.yaml
```

#### **Expected Output of Provider Helm Install**

```
NAME: akash-provider
LAST DEPLOYED: Thu Apr 28 18:58:10 2022
NAMESPACE: akash-services
STATUS: deployed
REVISION: 1
TEST SUITE: None
```

## Specific Version

If a need arises to use a different software version other than the one defined in the values.yaml Helm file - include the following section in the provider.yaml file and re-run the helm install command. In most circumstances this should not be necessary.

* Example:

```
image:
  tag: 0.16.4-rc4
```

## **Provider Confirmation**

```
kubectl get pods -n akash-services
```

#### **Expected output (example and name following akash-provider will differ)**

```
root@node1:~# kubectl get pods -n akash-services

NAME                              READY   STATUS    RESTARTS   AGE
akash-provider-6d7c455dfb-qkf5z   1/1     Running   0          4m37s
```



## Helm Chart Uninstall Process

* Should a need arise to uninstall the Helm Chart and attempt the process anew, the following step can be used
* Only conduct this step if there is a problem with Akash Provider Helm Chart install
* This Helm uninstall technique can be used for this or any subsequent chart installs
* Following this step - if needed - start the Provider Helm Chart install anew via the prior step in this page

```
helm uninstall akash-provider -n akash-services
```
