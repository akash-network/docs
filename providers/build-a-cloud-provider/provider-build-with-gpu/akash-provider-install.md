# Akash Provider Install

> _**NOTE**_ - all steps in this guide should be performed from a Kubernetes control plane node

## Install Akash Provider Services Binary

```
wget https://github.com/akash-network/provider/releases/download/v0.4.6/provider-services_0.4.6_linux_amd64.zip

unzip provider-services_0.4.6_linux_amd64.zip

install provider-services /usr/local/bin/

rm provider-services provider-services_0.4.6_linux_amd64.zip
```

## Confirm Akash Provider Services Install

* Issue the following command to confirm successful installation of the binary:

```
provider-services version
```

#### Expected/Example Output

```
root@node1:~# provider-services version
v0.4.6
```

## Specify Provider Account Keyring Location

```
export AKASH_KEYRING_BACKEND=test
```

## Create Provider Account

The wallet created in this step used will be used for the following purposes:

* Pay for provider transaction gas fees
* Pay for bid collateral which is discussed further in this section

> _**NOTE**_ - Make sure to create a new Akash account for the provider and do not reuse an account used for deployment purposes.  Bids will not be generated from your provider if the deployment orders are created with the same key as the provider.

> _**NOTE**_ - capture the mnemonic phrase for the account to restore later if necessary

> _**NOTE**_ - in the provided syntax we are creating an account with the key name of `default`

```
provider-services keys add default
```

## Fund Provider Account via Faucet

Ensure that the provider account - created in the prior step - is funded.  Avenues to fund an account are discussed in this [document](https://docs.akash.network/guides/cli/detailed-steps/part-3.-fund-your-account).

## Export Provider Key for Build Process

### STEP 1 - Export Provider Key

* Enter pass phrase when prompted
* The passphrase used will be needed in subsequent steps

```
cd ~
provider-services keys export default
```

#### Expected/Example Output

```
provider-services keys export default

Enter passphrase to encrypt the exported key:                          
Enter keyring passphrase:                                              
-----BEGIN TENDERMINT PRIVATE KEY-----
kdf: bcrypt
salt: REDACTED
type: secp256k1

REDACTED
-----END TENDERMINT PRIVATE KEY-----
```

### STEP 2 - Create key.pem and Copy Output Into File

* Copy the contents of the prior step into the `key.pem` file

> _**NOTE -**_ file should contain only what's between `-----BEGIN TENDERMINT PRIVATE KEY-----` and `-----END TENDERMINT PRIVATE KEY-----` (including the `BEGIN` and `END` lines):

```
vim key.pem
```

#### Verification of key.pem File

```
cat key.pem
```

#### Expected/Example File

```
cat key.pem
-----BEGIN TENDERMINT PRIVATE KEY-----
kdf: bcrypt
salt: REDACTED
type: secp256k1

REDACTED
-----END TENDERMINT PRIVATE KEY-----
```

## Provider RPC Node

Akash Providers need to run their own blockchain RPC node to remove dependence on public nodes.  This is a strict requirement.&#x20;

We have recently released documentation guiding thru the process of building a [RPC node via Helm Charts](../../../akash-nodes/akash-node-via-helm-charts/) with state sync.

## Declare Relevant Environment Variables

* Update `RPC-NODE-ADDRESS` with your own value

```
export AKASH_CHAIN_ID=akashnet-2
export AKASH_NODE=<RPC-NODE-ADDRESS>
export AKASH_GAS=auto
export AKASH_GAS_PRICES=0.025uakt
export AKASH_GAS_ADJUSTMENT=1.5
```

* Update the following variables with your own values
* The `KEY_PASSWORD` value should be the passphrase of used during the account export step
* Further discussion of the Akash provider domain is available [here](step-5-domain-name-review.md)

```
export ACCOUNT_ADDRESS=<AKASH_PROVIDER_ADDRESS>
export KEY_PASSWORD=<PASSPHASE>
export DOMAIN=<PROVIDER_DOMAIN>
```

## Create Provider Configuration File

* Providers must be updated with attributes in order to bid on the GPUs.

### GPU Attributes Template

* GPU model template is used in the subsequent `Provider Configuration File`
* Multiple such entries should be included in the `Provider Configuration File` if the providers has multiple GPU types
* Currently Akash providers may only host one GPU type per worker node.  But different GPU models/types may be hosted on separate Kubernetes nodes.

```
capabilities/gpu/vendor/<vendor name>/model/<model name>: true
```

### Example Provider Configuration File

* In the example configuration file below the Akash Provider will advertise availability of NVIDIA GPU model A4000
* Steps included in this code block create the necessary `provider.yaml` file in the expected directory
* Ensure that the attributes section is updated witih your own values

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
node: "$AKASH_NODE"
withdrawalperiod: 12h
attributes:
  - key: host
    value: akash
  - key: tier
    value: community
  - key: capabilities/gpu/vendor/nvidia/model/a4000
    value: true
EOF
```

## **Provider Bid Defaults**

* When a provider is created the default bid engine settings are used which are used to derive pricing per workload.  If desired these settings could be updated.  But we would recommend initially using the default values.
* For a through discussion on customized pricing please visit this [guide](../akash-cloud-provider-build-with-helm-charts/step-6-provider-bid-customization.md).

## Create Provider Via Helm

```
export CRDS="manifests.akash.network providerhosts.akash.network providerleasedips.akash.network"
kubectl delete crd $CRDS

kubectl apply -f https://raw.githubusercontent.com/akash-network/provider/v0.4.6/pkg/apis/akash.network/crd.yaml

for CRD in $CRDS; do
  kubectl annotate crd $CRD helm.sh/resource-policy=keep
  kubectl annotate crd $CRD meta.helm.sh/release-name=akash-provider
  kubectl annotate crd $CRD meta.helm.sh/release-namespace=akash-services
  kubectl label crd $CRD app.kubernetes.io/managed-by=Helm
done

helm upgrade --install akash-provider akash/provider -n akash-services -f provider.yaml \
--set bidpricescript="$(cat /root/provider/price_script_generic.sh | openssl base64 -A)"
```

#### Verification

* Verify the image is correct by running this command:

```
kubectl -n akash-services get pod akash-provider-0 -o yaml | grep image: | uniq -c
```

#### Expected/Example Output

```
root@node1:~/provider# kubectl -n akash-services get pod akash-provider-0 -o yaml | grep image: | uniq -c
      4     image: ghcr.io/akash-network/provider:0.4.6
```

## Create Akash Hostname Operator

```
helm upgrade --install akash-hostname-operator akash/akash-hostname-operator -n akash-services
```

## Verify Health of Akash Provider

* Use the following command to verify the health of the Akash Provider and Hostname Operator pods

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
