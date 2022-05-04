# STEP 5 - Provider Build via Helm Chart

## **Environment Variables**

* Declare the following environment variables for Helm
* Replace the variable  with your own settings
* Notes on settings and values
  * [ ] Domain should be a publicly accessible DNS name dedicated for your provider use such as myprovider.com.  More info on provider domain name use is available [here](broken-reference).
  * [ ] The moniker does not consequence and can be any identifier of your choosing

```
ACCOUNT_ADDRESS=<wallet-address-exported-previously-into-key.pem-file>
KEY_SECRET=<password-used-for-private-key-export>
DOMAIN=<domain-name-of-provider>
MONIKER=<identifier-of-node-on-chain>
```

## **Provider Helm Chart Build**



* Add the following if you are running your own RPC server.&#x20;
  * \--set node="http://\<IP-ADDRESS-OF-YOUR-RPC-NODE>:26657"
* Additionally consider personalizing the attributes - listed in the ./provider/values.yaml file.  For example - edit the organization attribute with your own org name.

```
helm install akash-provider akash/provider -n akash-services \
     --set from="$ACCOUNT_ADDRESS" \
     --set key="$(cat ./key.pem | base64)" \
     --set keysecret="$(echo $KEY_SECRET | base64)" \
     --set domain="$DOMAIN" \
     --set node="http://<IP-ADDRESS-OF-YOUR-RPC-NODE>:26657" \
     --set chainid="edgenet-1" \
     --set image.tag="0.15.0-rc15" \
     --set gas=auto \
     --set gasadjustment=1.3 \
     --set gasprices=0.025uakt
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
