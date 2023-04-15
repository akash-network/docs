# Akash Provider Install

> _**NOTE**_ - all steps in this guide should be performed from a Kubernetes control plane node

## Install Akash Provider

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
  - key: region
    value: "ord1"
  - key: host
    value: akash
  - key: tier
    value: community
  - key: organization
    value: "overclock"
EOF
```

## Create Provider Via Helm

```
kubectl delete crd manifests.akash.network
kubectl apply -f https://raw.githubusercontent.com/akash-network/provider/v0.3.0-rc6/pkg/apis/akash.network/crd.yaml

kubectl annotate crd manifests.akash.network meta.helm.sh/release-name=akash-provider
kubectl annotate crd manifests.akash.network meta.helm.sh/release-namespace=akash-services
kubectl label crd manifests.akash.network app.kubernetes.io/managed-by=Helm

cd ~/provider
helm repo add akash https://akash-network.github.io/helm-charts
helm install akash-provider akash/provider -n akash-services -f provider.yaml --set chainid=testnet-02 --set image.tag=0.3.0-rc6
```

## Create Akash Hostname Operator

```
helm install akash-hostname-operator akash/akash-hostname-operator -n akash-services --set image.tag=0.3.0-rc6
```
