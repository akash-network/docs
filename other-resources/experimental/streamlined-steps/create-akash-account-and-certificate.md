# Create Akash Account and Certificate

## **Overview**

The steps in this section should be followed if you have a pre-existing Akash account that needs to be imported.\


If you do not have an Akash account and need to create one, follow the steps in this[ guide](https://docs.akash.network/token/keplr) and then proceed with the step below.

## **Import Pre-Existing Account**

* Follow instructions create a new key/account named `myWallet`
* You will be prompted to enter the account mnemonic for import

```
provider-services keys add myWallet --recover
```

### Confirm Key Creation in Local Key Chain

```
provider-services keys list
```

#### Example/Expected Output

```
provider-services keys list

- name: myWallet
  type: local
  address: akash1f53f<REDACTED>fud7
  pubkey: '{"@type":"/cosmos.crypto.secp256k1.PubKey","key":"A21Z<REDACTED>WObs"}'
  mnemonic: ""
```

### Create/Export Key Environment Variable

```
export AKASH_KEY_NAME=myWallet
```

## Create your Certificate

In this step we will create a local certificate and then store the certification on the block chain

* Ensure that prior steps in this guide have been completed and that you have a funded wallet before attempting certificate creation.
* **Your certificate needs to be created only once per account** and can be used across all deployments.

#### Generate Cert

* Note: If it errors with `Error: certificate error: cannot overwrite certificate`, then add `--overwrite` should you want to overwrite the cert. Normally you can ignore that error and proceed with publishing the cert (next step).

```
provider-services tx cert generate client --from $AKASH_KEY_NAME
```

#### Publish Cert to the Blockchain

```
provider-services tx cert publish client --from $AKASH_KEY_NAME --gas-prices="0.025uakt" --gas="auto" --gas-adjustment=1.15
```
