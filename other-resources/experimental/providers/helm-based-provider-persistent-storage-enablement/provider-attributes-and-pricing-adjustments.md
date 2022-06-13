# Provider Attributes and Pricing Adjustments

## Attribute Adjustments

* Conduct the steps in this section on the Kubernetes master from which the provider was configured in prior steps
* Adjust the following key-values pairs as necessary within the `provider-storage.yaml` file created below:
  * Update the values of the `capabilities/storage/2/class` key to the correct class type (I.e. `beta2`).  Reference the [Storage Class Types](storage-class-types.md) doc section for additional details.
  * Update the region value from current `us-west` to an appropriate value such as `us-east` OR `eu-west`
* Ensure that necessary [environment variables](../akash-cloud-provider-build-with-helm-charts/step-6-provider-build-via-helm-chart.md) are in place prior to issuing

#### Helm Chart Upgrade Commands and Template

```
cd ~

helm repo update

cat > provider-storage.yaml << EOF
---
bidpricestoragescale: "0.00016,beta2=0.00016" # set your storage class here: beta1, beta2 or beta3!
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
    value: default
  - key: capabilities/storage/1/persistent
    value: true
  - key: capabilities/storage/2/class
    value: beta2             # set your storage class here: beta1, beta2 or beta3!
  - key: capabilities/storage/2/persistent
    value: true
EOF

# Make sure you have "provider.yaml" previously created!
helm upgrade --install akash-provider akash/provider -n akash-services -f provider.yaml -f provider-storage.yaml
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
chainid: akashnet-2
domain: REDACTED
from: akash1REDACTED
gas: auto
gasadjustment: "1.25"
gasprices: 0.025uakt
image:
  tag: 0.16.4-rc0
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
