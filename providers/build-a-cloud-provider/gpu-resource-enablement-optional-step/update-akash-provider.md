# Update Akash Provider

## Update Provider Configuration File

Providers must be updated with attributes in order to bid on the GPUs.

> NOTE - in the Akash Provider build documentation a `provider.yaml` file was created and which stores provider attribute/other settings. In this section we will update that `provider.yaml` file with GPU related attributes. The remainder of the pre-existing file should be left unchanged.

### GPU Attributes Template

* GPU model template is used in the subsequent `Provider Configuration File`
* Multiple such entries should be included in the `Provider Configuration File` if the providers has multiple GPU types
* Currently Akash providers may only host one GPU type per worker node. But different GPU models/types may be hosted on separate Kubernetes nodes.

```
capabilities/gpu/vendor/<vendor name>/model/<model name>: true
```

### Example Provider Configuration File

* In the example configuration file below the Akash Provider will advertise availability of NVIDIA GPU model A4000
* Steps included in this code block create the necessary `provider.yaml` file in the expected directory
* Ensure that the attributes section is updated with your own values

```
cd ~

cd provider

vim provider.yaml
```

### **Update the Provider YAML File With GPU Attribute**

* When the `provider.yaml` file update is complete look like the following example.

> _**NOTE**_ - provider GPU attributes must now adhere to the naming conventions in this [JSON file](https://github.com/akash-network/provider-configs/blob/main/devices/pcie/gpus.json).  Your attributes may need to be updated to follow these standards.  If your provider attributes do not adhere to the naming conventions in this JSON file it may not bid when specific models are included in the SDL.  If the GPU model has multiple memory options the attributes should be in the form such as the following where again the model and the RAM spec use the nomenclatures of the JSON file.

```
  - key: capabilities/gpu/vendor/nvidia/model/a100/ram/40Gi
    value: true
```

#### Example Provider Config File

```

---
from: "$ACCOUNT_ADDRESS"
key: "$(cat ~/key.pem | openssl base64 -A)"
keysecret: "$(echo $KEY_PASSWORD | openssl base64 -A)"
domain: "$DOMAIN"
node: "$AKASH_NODE"
withdrawalperiod: 12h
attributes:
  - key: host
    value: akash
  - key: tier
    value: community
  - key: capabilities/gpu/vendor/nvidia/model/a4000
    value: true
```

## **Provider Bid Defaults**

* When a provider is created the default bid engine settings are used which are used to derive pricing per workload. If desired these settings could be updated. But we would recommend initially using the default values.
* For a through discussion on customized pricing please visit this [guide](../akash-cloud-provider-build-with-helm-charts/step-6-provider-bid-customization.md).

## Update Provider Via Helm

```

helm upgrade --install akash-provider akash/provider -n akash-services -f provider.yaml \
--set bidpricescript="$(cat /root/provider/price_script_generic.sh | openssl base64 -A)"
```

## Verify Health of Akash Provider

Use the following command to verify the health of the Akash Provider and Hostname Operator pods

```
kubectl get pods -n akash-services
```

#### Example/Expected Output

```
root@node1:~/provider# kubectl get pods -n akash-services
NAME                                       READY   STATUS    RESTARTS   AGE
akash-hostname-operator-5c59757fcc-kt7dl   1/1     Running   0          17s
akash-provider-0                           1/1     Running   0          59s
```

## Verify Akash Provider Image

Verify the Provider image is correct by running this command:

```
kubectl -n akash-services get pod akash-provider-0 -o yaml | grep image: | uniq -c
```

#### Expected/Example Output

```
root@node1:~/provider# kubectl -n akash-services get pod akash-provider-0 -o yaml | grep image: | uniq -c
      4     image: ghcr.io/akash-network/provider:0.4.6
```
