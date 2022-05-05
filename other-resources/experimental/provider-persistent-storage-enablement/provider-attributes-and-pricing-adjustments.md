# Provider Attributes and Pricing Adjustments

## Storage Class Types <a href="#storage-class-types" id="storage-class-types"></a>

In the subsequent section persistent storage attributes will be defined.  Use the chart below to determine your provider's storage class.

| Class Name | Throughput/Approx matching device |
| ---------- | --------------------------------- |
| beta1      | hdd                               |
| beta2      | ssd                               |
| beta3      | NVMe                              |
| default    | Provider defined default class    |

## Attribute Adjustments

* Conduct the steps in this section on the Kubernetes master from which the provider was configured in prior steps

### Clone Repo

Clone the Akash GitHub repository and move into the cloned directory for subsequent steps.

```
cd ~

git clone https://github.com/ovrclk/helm-charts.git 
```

### Adjust Attributes

* Make updates to Provider settings for persistent storage

```
cd ~/helm-charts/charts/akash-provider

vi values.yaml
```

* Adjust the attributes section of the values.yaml file as follows
* The capabilities attributes are necessary to receive bids on persistent storage deployments
* Update the value of the `capabilities/storage/2/class` key to the correct storage class

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

#### Example Completed Attributes Section

* Note - a Provider could also take this opportunity to update their non-persistent storage specific attributes at this time if needed as well.  For example - update the organization name to your own.

```
attributes:
  - key: region
    value: us-west
  - key: host
    value: akash
  - key: tier
    value: community
  - key: organization
    value: akash.network
  - key: capabilities/storage/1/class
    value: default
  - key: capabilities/storage/1/persistent
    value: true
  - key: capabilities/storage/2/class
    value: beta2
  - key: capabilities/storage/2/persistent
    value: true
```

## Update Provider Attributes

### Pricing Adjustments

* Use the AKASH\_BID\_PRICE\_STORAGE\_SCALE environment variable to set provider pricing detail
* Use the values as indicated in the sample for initial testing

### Enact Attribute Updates

```
cd ~/helm-charts/charts

helm upgrade akash-provider ./akash-provider -n akash-services \
     --set from="$ACCOUNT_ADDRESS" \
     --set key="$(cat ~/key.pem | base64)" \
     --set keysecret="$(echo $KEY_SECRET | base64)" \
     --set domain="$DOMAIN" \
     --set node="$NODE" \
     --set chainid="akashnet-2" \
     --set image.tag="$AKASH_VERSION" \
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

#### Expected Provider Status

* Note - the Helm upgrade will spawn a new provider pod
* Possible the prior provider pod may show with a status of deleting on initial view and then would eventually disappear from output

```
root@node1:~/helm-charts/charts# kubectl get pods -n akash-services

NAME                                 READY   STATUS    RESTARTS   AGE
akash-provider-6bf9986cdc-btvlg      1/1     Running   0          3m13s
```
