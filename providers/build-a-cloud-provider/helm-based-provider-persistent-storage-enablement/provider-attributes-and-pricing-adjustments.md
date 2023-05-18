# Provider Attributes and Pricing Adjustments

## Attribute Adjustments

* Conduct the steps in this section on the Kubernetes master from which the provider was configured in prior steps
* Adjust the following key-values pairs as necessary within the `provider-storage.yaml` file created below:
  * Update the values of the `capabilities/storage/2/class` key to the correct class type (I.e. `beta2`).  Reference the [Storage Class Types](storage-class-types.md) doc section for additional details.
  * Update the region value from current `us-west` to an appropriate value such as `us-east` OR `eu-west`
* Ensure that necessary [environment variables](../akash-cloud-provider-build-with-helm-charts/step-6-provider-build-via-helm-chart.md) are in place prior to issuing

#### Caveat on Attributes Updates in Active Leases

* If your provider has active leases, attributes that were used during the creation of those leases cannot be updated
* Example - if a lease was created and is active on your provider with `key=region` and `value=us-east`- it would not be possible to update the `region` attribute without closing those active leases prior

#### Helm Chart Update

```
cd ~

helm repo update
```

### Capture and Edit provider.yaml File

* In this section we will capture the current provider settings and add necessary persistent storage elements
* _**NOTE**_ - the `bidpricestoragescale` setting in the `provider.yaml` file will be ignored if the [bid pricing script](../akash-provider-bid-pricing/) is used.

#### **Capture Current Provider Settings and Write to File**

```
cd ~

helm -n akash-services get values akash-provider > provider.yaml
```

#### **Update provider.yaml File With Persistent Storage Settings**

* Open the `provider.yaml` file with your favorite editor (I.e. `vi` or `vim`) and add the following

```
attributes:
<keep the existing ones and add the following ones:>
  - key: capabilities/storage/1/class
    value: beta2             # set your storage class here: beta1, beta2 or beta3!
  - key: capabilities/storage/1/persistent
    value: true
```

And add this attribute if you are not using the bid pricing script:

```
bidpricestoragescale: "0.00016,beta2=0.00016" # set your storage class here: beta1, beta2 or beta3!
```

#### Finalized provider.yaml File

* Post additions discussed above, your `provider.yaml` file should look something like this:

```
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
  - key: capabilities/storage/1/class
    value: beta2             # set your storage class here: beta1, beta2 or beta3!
  - key: capabilities/storage/1/persistent
    value: true

bidpricestoragescale: "0.00016,beta2=0.00016" # set your storage class here: beta1, beta2 or beta3!
```

### Upgrade the Helm Install

```
# Make sure you have "provider.yaml" previously created!
helm upgrade --install akash-provider akash/provider -n akash-services -f provider.yaml
```

#### Expected/Example Output

```
NAME: akash-provider
LAST DEPLOYED: Wed May 11 13:45:56 2022
NAMESPACE: akash-services
STATUS: deployed
REVISION: 1
TEST SUITE: None
```

## Verify Provider Settings

* Issue the following command to verify values applied by Helm&#x20;

```
helm -n akash-services get values akash-provider
```

### Example/Expected Output

```
helm -n akash-services get values akash-provider

USER-SUPPLIED VALUES:
attributes:
- key: region
  value: europe
- key: host
  value: akash
- key: tier
...
...
bidpricestoragescale: "0.00016"
domain: REDACTED
from: akash1REDACTED
image:
  tag: 0.1.0
...
```

## Provider Status

* Note - the Helm upgrade will spawn a new provider pod
* Possible the prior provider pod may show with a status of deleting on initial view and then would eventually disappear from output

```
kubectl get pods -n akash-services
```

#### Expected/Example Output

```
root@node1:~/helm-charts/charts# kubectl get pods -n akash-services

NAME                                 READY   STATUS    RESTARTS   AGE
akash-provider-6bf9986cdc-btvlg      1/1     Running   0          3m13s
```
