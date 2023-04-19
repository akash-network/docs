# Akash Provider Install

> _**NOTE**_ - all steps in this guide should be performed from a Kubernetes control plane node

## Install Akash Provider Services Binary

```
wget https://github.com/akash-network/provider/releases/download/v0.3.0-rc6/provider-services_0.3.0-rc6_linux_amd64.zip

unzip provider-services_0.3.0-rc6_linux_amd64.zip 

install provider-services /usr/local/bin/

rm provider-services provider-services_0.3.0-rc6_linux_amd64.zip 
```

## Specify Provider Account Keyring Location

```
export AKASH_KEYRING_BACKEND=test
```

## Create Provider Account

> _**NOTE**_ -  capture the mnemonic phrase for the account to restore later - if it becomes necessary - using `provider-services keys add default --recover` command

> _**NOTE**_ - in the provided syntax we are creating an account with the key name of `default`

```
provider-services keys add default
```

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

> _**NOTE -**_ file should contain only what's between `-----BEGIN TENDERMINT PRIVATE KEY-----` and  `-----END TENDERMINT PRIVATE KEY-----` (including the `BEGIN` and `END` lines):

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

## Fund Provider Account via Faucet

Visit the Testnet faucet [here](http://faucet.testnet-02.aksh.pw/) to fund your provider account. &#x20;

Enter the address of the `default` account created in previous steps as prompted by the faucet.

## Declare Testnet Relevant Environment Variables

* The following variables may be used with no need to edit

```
export AKASH_CHAIN_ID=testnet-02
export AKASH_NODE=http://rpc.testnet-02.aksh.pw:26657
export AKASH_GAS=auto
export AKASH_GAS_PRICES=0.025uakt
export AKASH_GAS_ADJUSTMENT=1.5
```

* Update the following variables with your own values
* The `KEY_PASSWORD` value should be the passphrase of used during the account export step

```
export ACCOUNT_ADDRESS=akash13n9ka8hxewpj9596ugyml9a94gcewl036a7gyf
export KEY_PASSWORD=akash123
export DOMAIN=akashwebapp.xyz
```

## Create Provider Configuration File

* Adjust/edit the attributes for your provider as desired

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
EOF
```

## Create Provider Via Helm

```
export CRDS="leaseparamsservices.akash.network manifests.akash.network providerhosts.akash.network providerleasedips.akash.network"

kubectl delete crd $CRDS

kubectl apply -f https://raw.githubusercontent.com/akash-network/provider/v0.3.0-rc6/pkg/apis/akash.network/crd.yaml

for CRD in $CRDS; do
  kubectl annotate crd $CRD helm.sh/resource-policy=keep
  kubectl annotate crd $CRD meta.helm.sh/release-name=akash-provider
  kubectl annotate crd $CRD meta.helm.sh/release-namespace=akash-services
  kubectl label crd $CRD app.kubernetes.io/managed-by=Helm
done

helm install akash-provider akash/provider -n akash-services -f provider.yaml --set chainid=testnet-02 --set image.tag=0.3.0-rc6
```

### Error: INSTALLATION FAILED: cannot patch "manifests.akash.network" with kind CustomResourceDefinition

Please ignore the following "cannot patch" errors during Akash Provider Helm install.:

```
# helm install akash-provider akash/provider -n akash-services -f provider.yaml --set chainid=testnet-02 --set image.tag=0.3.0-rc6
Error: INSTALLATION FAILED: cannot patch "manifests.akash.network" with kind CustomResourceDefinition: CustomResourceDefinition.apiextensions.k8s.io "manifests.akash.network" is invalid: status.storedVersions[0]: Invalid value: "v2beta2": must appear in spec.versions && cannot patch "providerhosts.akash.network" with kind CustomResourceDefinition: CustomResourceDefinition.apiextensions.k8s.io "providerhosts.akash.network" is invalid: status.storedVersions[0]: Invalid value: "v2beta2": must appear in spec.versions && cannot patch "providerleasedips.akash.network" with kind CustomResourceDefinition: CustomResourceDefinition.apiextensions.k8s.io "providerleasedips.akash.network" is invalid: status.storedVersions[0]: Invalid value: "v2beta2": must appear in spec.versions
```

The "cannot patch" errors are expected since Helm does not support CRD upgrades as described [here](https://helm.sh/docs/chart\_best\_practices/custom\_resource\_definitions/#some-caveats-and-explanations).

Verify the image is correct by running this command:

```
kubectl -n akash-services get pod akash-provider-0 -o yaml | grep image: | uniq -c
```

#### Expected/Example Output

```
kubectl -n akash-services get pod akash-provider-0 -o yaml | grep image: | uniq -c
      4    image: ghcr.io/akash-network/provider:0.3.0-rc6
```



## Create Akash Hostname Operator

```
helm install akash-hostname-operator akash/akash-hostname-operator -n akash-services --set image.tag=0.3.0-rc6
```
