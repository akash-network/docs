# STEP 6 - Provider Build via Helm Chart

## **Environment Variables**

* Declare the following environment variables for Helm
* Replace the variable  with your own settings
* Notes on settings and values
  * [ ] Domain should be a publicly accessible DNS name dedicated for your provider use such as myprovider.com.

```
ACCOUNT_ADDRESS=akash1XXXX #akash provicer address that starts with `akash1`
KEY_PASSWORD=12341234 #set to the password you have entered upon `akash keys export <key-name> > key.pem`; this is for the akash-provider pod to decrypt the key
DOMAIN=test.com  #Register certains DNS A and wildcard address as specific in previous step, i.e. `provider.test.com` DNS A record and `*.ingress.test.com` DNS wildcard record
NODE=http://<IP_address_of_your_RPC_node>:26657
AKASH_VERSION=<current_akash_version>
```

## **Provider Helm Chart Build**

### **Provider Withdrawl Period**

* Akash providers may dictate how often they withdrawl funds consumed by active deployments/tenants escrow accounts
* Few things to consider regarding the provider withdrawl period:
  * The default withdrawl setting in the Helm Charts is one (1) hour
  * An advantage of the one hour default setting is assurance that a deployment may not breach the escrow account dramatically.  If the withdrawl period were set to 24 hours instead - the deployment could exhaust the amount in escrow in one hour (for example) but the provider would not calculate this until many hours later and the deployment would essentially operate for free in the interim.
  * A disadvantage of frequent withdrawls is the possibility of losing profitability based on fees incurred by the providers withdrawl transactions.  If the provider hosts primarily low resource workloads, it is very possible that fees could exceed deployment cost/profit.

#### OPTIONAL - Update the Provider Withdrawl Period

* If it is desired to change the withdrawl period from the default one hour setting, include the following set command in the `helm install akash-provider` command covered in the next section.
* In the example the Provider Build section of this doc the  withdrawl period has been set to 24 hours.  Please adjust as preferred.

### **Provider Build**

* Ensure you are applying the latest version of subsequent Helm Charts install/upgrade steps

```
helm repo update
```

* Issue the following command to build your Akash Provider

```
helm install akash-provider akash/provider -n akash-services \
     --set keyringbackend="test" \
     --set from="$ACCOUNT_ADDRESS" \
     --set key="$(cat ./key.pem | base64)" \
     --set keysecret="$(echo $KEY_PASSWORD | base64)" \
     --set domain="$DOMAIN" \
     --set node="$NODE" \
     --set chainid="akashnet-2" \
     --set image.tag="$AKASH_VERSION" \
     --set AKASH_FEES=5123uakt \
     --set gas=auto \
     --set gasadjustment=1.25 \
     --set gasprices=0.025uakt \
     --set withdrawalperiod=24h
```

#### **Expected output**

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



## Helm Chart Uninstall Process

* Should a need arise to uninstall the Helm Chart and attempt the process anew, the following step can be used
* Only conduct this step if there is a problem with Akash Provider Helm Chart install
* This Helm uninstall technique can be used for this or any subsequent chart installs
* Following this step - if needed - start the Provider Helm Chart install anew via the prior step in this page

```
helm uninstall akash-provider -n akash-services
```
