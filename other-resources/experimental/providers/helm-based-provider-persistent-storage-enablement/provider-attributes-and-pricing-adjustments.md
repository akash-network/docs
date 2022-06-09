# Provider Attributes and Pricing Adjustments

## Attribute Adjustments

* Conduct the steps in this section on the Kubernetes master from which the provider was configured in prior steps
* Adjust the following key-values pairs as necessary with the `helm upgrade` command:
  * Update the values of the `bidpricestoragescale` and `attributes[5].value` keys to the correct class type (I.e. `beta2`).  Reference the [Storage Class Types](storage-class-types.md) doc section for additional details.
  * Update the region value from current `us-west` to an appropriate value such as `us-east` OR `eu-west`
* Ensure that necessary [environment variables](../akash-cloud-provider-build-with-helm-charts/step-6-provider-build-via-helm-chart.md) are in place prior to issuing

#### Helm Chart Upgrade Commands and Template

```
cd ~

helm repo update

helm upgrade akash-provider akash/provider -n akash-services \
  --set keyringbackend="test" \
  --set from="$ACCOUNT_ADDRESS" \
  --set key="$(cat ./key.pem | base64)" \
  --set keysecret="$(echo $KEY_PASSWORD | base64)" \
  --set domain="$DOMAIN" \
  --set chainid="akashnet-2" \
  --set image.tag="$AKASH_VERSION" \
  --set gas=auto \
  --set gasadjustment=1.25 \
  --set gasprices=0.025uakt \
  --set withdrawalperiod=24h \
  --set bidpricestoragescale="0.00016,<beta1|beta2|beta3>=0.00016" \
  --set node="$NODE" \
  --set attributes[0].key="region" \
  --set attributes[0].value="us-west" \
  --set attributes[1].key="host" \
  --set attributes[1].value="akash" \
  --set attributes[2].key="tier" \
  --set attributes[2].value="community" \
  --set attributes[3].key="capabilities/storage/1/class" \
  --set attributes[3].value="default" \
  --set attributes[4].key="capabilities/storage/1/persistent" \
  --set attributes[4].value="true" \
  --set attributes[5].key="capabilities/storage/2/class" \
  --set attributes[5].value="<beta1|beta2|beta3>" \
  --set attributes[6].key="capabilities/storage/2/persistent" \
  --set attributes[6].value="true"
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