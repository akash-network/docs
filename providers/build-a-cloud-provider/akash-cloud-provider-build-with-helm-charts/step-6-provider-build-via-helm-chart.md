# STEP 6 - Provider Build via Helm Chart

## **Overview**

In this section the Akash Provider will be installed and customized via the use of Helm Charts.

> _**NOTE**_ - when the Helm Chart is installed the Provider instance/details will be created on the blockchain and your provider will be registered in the Akash open cloud marketplace.  The associated transaction for Provider creation is detailed [here](../../../cli/provider-services\_tx\_provider\_create.md).

## **Environment Variables**

* Declare the following environment variables for Helm use
* Replace the variables with your own settings

1. Set akash provider address that starts with `akash1`

> This allows the akash-provider to decrypt the key

```
export ACCOUNT_ADDRESS=akash1XXXX
```

2\.  Set the password you have entered upon akash keys export > key.pem

```
export KEY_PASSWORD=12341234
```

3\.  Set your domain. Register DNS A and wildcard address as specified in previous step, i.e. `provider.test.com` DNS A record and `*.ingress.test.com` DNS wildcard record.

> Domain should be a publicly accessible DNS name dedicated for your provider use such as test.com.
>
>
>
> The domain specified in this variable will be used by Helm during the Provider chart install process to produce the "provider.yourdomain.com" sub-domain name and the "ingress.yourdomain.com" sub-domain name. The domain specified will also be used by Helm during the Ingress Controller install steps coming up in this guide. Once your provider is up and running the \*.ingress.yourdomain.com URI will be used for web app deployments such as abc123.ingress.yourdomain.com.

```
export DOMAIN=test.com
```

4\.  Set the Akash RPC node for your provider to use

> If you are going to deploy Akash RPC Node using Helm-Charts then set the node to http://akash-node-1:26657 It is recommended that you install your own Akash RPC node. Follow [this guide](../../../akash-nodes/akash-node-via-helm-charts/) to do so.  \
> \
> Ensure that the RPC node utilized is in sync prior to proceeding with the provider build.\
> \
> _**NOTE**_ - in the example provided below the NODE variable is set to `akash-node-1` which is the Kubernetes service name of the RPC node when installed via Helm.  Use `kubectl get svc -n akash-services` to confirm the service name and status.

```
export NODE=http://akash-node-1:26657
```

## **Provider Withdraw Period**

* Akash providers may dictate how often they withdraw funds consumed by active deployments/tenants escrow accounts
* Few things to consider regarding the provider withdraw period:
  * The default withdraw setting in the Helm Charts is one (1) hour
  * An advantage of the one hour default setting is assurance that a deployment may not breach the escrow account dramatically.  If the withdraw period were set to 12 hours instead - the deployment could exhaust the amount in escrow in one hour (for example) but the provider would not calculate this until many hours later and the deployment would essentially operate for free in the interim.
  * A disadvantage of frequent withdraws is the possibility of losing profitability based on fees incurred by the providers withdraw transactions.  If the provider hosts primarily low resource workloads, it is very possible that fees could exceed deployment cost/profit.

#### OPTIONAL - Update the Provider Withdraw Period

* If it is desired to change the withdrawal period from the default one hour setting, update the `withdrawalperiod` setting in the provider.yaml file created subsequently in this section.
* In the example the Provider Build section of this doc the withdrawal period has been set to 12 hours.  Please adjust as preferred.

## **Provider Build Prep**

* Ensure you are applying the latest version of subsequent Helm Charts install/upgrade steps

```
helm repo update
```

### Create a provider.yaml File

* Issue the following command to build your Akash Provider
* Update the following keys for your unique use case
  * `region`
  * `organization`
* Optional Parameters - the following parameters may be added at the same level as `from` and `key` if you which to advertise your support email address and company website URL.
  * `email`
  * `website`

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
withdrawalperiod: 12h
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

#### **Example provider.yaml File Creation**

```
root@linux-server ~ % cat > provider.yaml << EOF
---
from: "$ACCOUNT_ADDRESS"
key: "$(cat ./key.pem | openssl base64 -A)"
keysecret: "$(echo $KEY_PASSWORD | openssl base64 -A)"
domain: "$DOMAIN"
node: "$NODE"
withdrawalperiod: 12h
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

### &#x20;Verification of provider.yaml File

* &#x20;Issue the following commands to verify the `provider.yaml` file created in previous steps

```
cd ~/provider

cat provider.yaml
```

#### Example provider.yaml Verification Output

* Ensure there are no empty values

```
from: akash1<REDACTED>
key: LS0tLS1CRU<REDACTED>0tLS0tCg==
keysecret: QUtB<REDACTED>XIK
domain: test.com
node: http://<rpc-address>:26657
withdrawalperiod: 12h
attributes:
- key: region
  value: us-east
- key: host
  value: akash
- key: tier
  value: community
- key: organization
  value: mycompany
```

## **Provider Bid Defaults**

* When a provider is created the default bid engine settings are used.  If desired these settings could be updated and added to the `provider.yaml` file.  But we would recommend initially using the default values.
* Note -  the `bidpricestoragescale` value will get overridden by `-f provider-storage.yaml` covered in [Provider Persistent Storage](../helm-based-provider-persistent-storage-enablement/) documentation.
* Note -  if you want to use a shellScript bid price strategy, pass the bid price script via `bidpricescript` variable detailed in the [bid pricing script doc](../akash-provider-bid-pricing/).  This will automatically suppress all `bidprice<cpu|memory|endpoint|storage>scale` settings.

```
bidpricecpuscale: "0.004" # cpu pricing scale in uakt per millicpu
bidpricememoryscale: "0.0016" # memory pricing scale in uakt per megabyte
bidpriceendpointscale: "0" # endpoint pricing scale in uakt per endpoint
bidpricestoragescale: "0.00016" # storage pricing scale in uakt per megabyte
```

## **Provider CRD Installations**

* Kubernetes CRDs are no longer delivered by the Helm as of chart `v4.3.0`.&#x20;
* CRDs are now installed manually using this step.

> _**NOTE**_ - You do not need to run this command if you previously installed the Akash Provider and are now performing an upgrade.

```
kubectl apply -f https://raw.githubusercontent.com/akash-network/provider/v0.2.1/pkg/apis/akash.network/crd.yaml
```

## **Install the Provider Helm Chart**

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

#### Troubleshooting

If your Akash Provider pod status displays `init:0/1` for a prolonged period of time, use the following command to view Init container logs.  Often the Provider may have a RPC issue and this should be revealed in these logs.  RPC issues may be caused by an incorrect declaration in the NODE variable declaration issued previously in this section.  Or possibly your custom RPC node is not in sync.

```
kubectl -n akash-services logs -l app=akash-provider -c init --tail 200 -f
```

## Helm Chart Uninstall Process

* Should a need arise to uninstall the Helm Chart and attempt the process anew, the following step can be used
* Only conduct this step if there is a problem with Akash Provider Helm Chart install
* This Helm uninstall technique can be used for this or any subsequent chart installs
* Following this step - if needed - start the Provider Helm Chart install anew via the prior step in this page

```
helm uninstall akash-provider -n akash-services
```
