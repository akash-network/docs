# Provider Attributes and Pricing Adjustments

## Attribute Adjustments

* In this section we will make updates to Provider settings for persistent storage

```
cd ~/provider

vi values.yaml
```

* Adjust the attributes section of the values.yaml file as follows
* The non capabilities/storage attributes values may be of your own choosing
* The capabilities attributes are necessary to receive bids on persistent storage deployments

```
attributes:
  - key: capabilities/storage/1/class
    value: default
  - key: capabilities/storage/1/persistent
    value: true
  - key: capabilities/storage/2/class
    value: <beta1|beta2|beta3>
  - key: capabilities/storage/2/persistent
    value: true
```

## Pricing Adjustments

* Use the AKASH\_BID\_PRICE\_STORAGE\_SCALE environment variable to set provider pricing detail
* Use the values as indicated in this sample for initial testing

```
cd ~

helm upgrade akash-provider ./provider -n akash-services \
     --set from="$ACCOUNT_ADDRESS" \
     --set key="$(cat ./key.pem | base64)" \
     --set keysecret="$(echo $KEY_SECRET | base64)" \
     --set domain="$DOMAIN" \
     --set node="http://rpc.edgenet-1.ewr1.aksh.pw:26657" \
     --set chainid="edgenet-1" \
     --set image.tag="0.16.4-rc0" \
     --set bidpricestoragescale="0.0001\,beta2=0.002"
```

#### Expected Result

```
Release "akash-provider" has been upgraded. Happy Helming!
NAME: akash-provider
LAST DEPLOYED: Mon Mar  7 17:16:20 2022
NAMESPACE: akash-services
STATUS: deployed
REVISION: 2
TEST SUITE: None
```

## **Restart Provider Pod**

### **Capture the Name of Provider Pod**

```
kubectl get pods -n akash-services
```

### Provider Restart

* Use the pod name captured in the previous step to restart the provider
* Deleting the pod will force it to spawn anew

```
kubectl -n akash-services delete pod <provider-pod-name>
```

#### Example Restart

```
kubectl -n akash-services delete pod akash-provider-64bff5f75c-5vvp5
```
