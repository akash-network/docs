# Create Akash Account and Certificate

## **Overview**

The steps in this section should be followed if you have a pre-existing Akash account that needs to be imported.\


If you do not have an Akash account and need to create one, follow the steps in this[ guide](https://docs.akash.network/token/keplr) and then proceed with the step below.

## **Import Pre-Existing Account**

* Follow instructions create a new key named `deploy`
* You will be prompted to enter the account mnemonic for import

```
akash keys add deploy --recover
```

### Confirm Key Creation in Local Key Chain

```
akash keys list
```

### Create/Export Key Environment Variable

```
export AKASH_KEY_NAME=deploy
```

## Create your Certificate

In this step we will create a local certificate and then store the certification on the block chain

* NOTE - for those familiar with previous Akash CLI versions the following commands for cert creation have changed.  We believe the new command sets in this version make steps more clear.
* Ensure that prior steps in this guide have been completed and that you have a funded wallet before attempting certificate creation.
* **Your certificate needs to be created only once per account** and can be used across all deployments.

#### Generate Cert

* Note: If it errors with `Error: certificate error: cannot overwrite certificate`, then add `--overwrite` should you want to overwrite the cert. Normally you can ignore that error and proceed with publishing the cert (next step).

```
akash tx cert generate client --from $AKASH_KEY_NAME
```

#### Publish Cert to the Blockchain

```
akash tx cert publish client --from $AKASH_KEY_NAME --gas-prices="0.025uakt" --gas="auto" --gas-adjustment=1.15
```
