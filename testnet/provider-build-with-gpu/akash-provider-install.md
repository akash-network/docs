# Akash Provider Install

> _**NOTE**_ - all steps in this guide should be performed from a Kubernetes control plane node

## Install Akash Provider Services Binary

```
wget https://github.com/akash-network/provider/releases/download/v0.3.1-rc0/provider-services_0.3.1-rc0_linux_amd64.zip

unzip provider-services_0.3.1-rc0_linux_amd64.zip 

install provider-services /usr/local/bin/

rm provider-services provider-services_0.3.1-rc0_linux_amd64.zip 
```

## Specify Provider Account Keyring Location

```
export AKASH_KEYRING_BACKEND=test
```

## Create Provider Account

> _**NOTE**_ -  capture the mnemonic phrase for the account to restore later - if it becomes necessary - using `provider-services keys add default --recover` command

> _**NOTE**_ - in the provided syntax we are creating an account with the key name of `default`

> _**NOTE**_ - the Akash Provider's address (I.e. account that begins with akash1XXXXXXXX) is required in the Testnet submission form which is to be completed when the provider is fully built and tested.  Capture the address output in the following command for your Provider Account submission later.

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

* Providers must be updated with attributes in order to bid on the GPUs.

### GPU Attributes Template

```
capabilities/gpu/vendor/<vendor name>/model/<model name>: true
```

### Example Provider Configuration File

* In the example configuration file below the Akash Provider will advertise avaialbility of NVIDIA GPU model A4000

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

## Download Provider Pricing Script

> _**NOTE**_ - the Akash pricing script used for the GPU Testnet includes address whitelisting.  The whitelist is maintained by the Akash core team and will ensure that only authorized Akash addresses will be allowed to deploy workloads onto your provider

> _**NOTE**_ - the Provider Pricing script as downloaded will not allow from your own testing account.  During initial Provider testing un-comment these [four lines](https://github.com/akash-network/helm-charts/blob/provider-4.3.4/charts/akash-provider/scripts/price\_script\_generic.sh#L12-L15) of the script and replace the `akash1XXXXX` addresses with your own test accounts.&#x20;

```
wget https://raw.githubusercontent.com/akash-network/helm-charts/main/charts/akash-provider/scripts/price_script_generic.sh
```

## Create Provider Via Helm

```
export CRDS="manifests.akash.network providerhosts.akash.network providerleasedips.akash.network"
kubectl delete crd $CRDS

kubectl apply -f https://raw.githubusercontent.com/akash-network/provider/v0.3.1-rc0/pkg/apis/akash.network/crd.yaml

for CRD in $CRDS; do
  kubectl annotate crd $CRD helm.sh/resource-policy=keep
  kubectl annotate crd $CRD meta.helm.sh/release-name=akash-provider
  kubectl annotate crd $CRD meta.helm.sh/release-namespace=akash-services
  kubectl label crd $CRD app.kubernetes.io/managed-by=Helm
done

helm upgrade --install akash-provider akash/provider -n akash-services -f provider.yaml \
--set bidpricescript="$(cat /root/provider/price_script_generic.sh | openssl base64 -A)" \
--set chainid=testnet-02 \
--set whitelist_url=https://raw.githubusercontent.com/akash-network/net/master/testnet-02/whitelist.txt \
--set image.tag=0.3.1-rc0
```

Verify the image is correct by running this command:

```
kubectl -n akash-services get pod akash-provider-0 -o yaml | grep image: | uniq -c
```

#### Expected/Example Output

```
kubectl -n akash-services get pod akash-provider-0 -o yaml | grep image: | uniq -c
      4    image: ghcr.io/akash-network/provider:0.3.1-rc0
```



## Create Akash Hostname Operator

```
helm install akash-hostname-operator akash/akash-hostname-operator -n akash-services --set image.tag=0.3.1-rc0
```

## Verify Akash Provider and Hostname Operator Status

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
