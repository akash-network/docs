# Configure your Network

## Configure the Testnet Chain ID and RPC Node

```bash
export AKASH_CHAIN_ID=testnet-02
export AKASH_NODE=http://rpc.testnet-02.aksh.pw:26657
```

## Confirm your network variables are setup

Your values may differ depending on the network you're connecting to.

```bash
echo $AKASH_NODE $AKASH_CHAIN_ID $AKASH_KEYRING_BACKEND
```

You should see something similar to:

```
http://rpc.testnet-02.aksh.pw:26657 testnet-02 os
```

## Set Additional Environment Variables

Set the below set of environment variables to ensure smooth operations

| Variable               | Description                                                                               | Recommended Value |
| ---------------------- | ----------------------------------------------------------------------------------------- | ----------------- |
| AKASH\_GAS             | Gas limit to set per-transaction; set to "auto" to calculate sufficient gas automatically | `auto`            |
| AKASH\_GAS\_ADJUSTMENT | Adjustment factor to be multiplied against the estimate returned by the tx simulation     | `1.15`            |
| AKASH\_GAS\_PRICES     | Gas prices in decimal format to determine the transaction fee                             | `0.025uakt`       |
| AKASH\_SIGN\_MODE      | Signature mode                                                                            | `amino-json`      |

```
export AKASH_GAS=auto
export AKASH_GAS_ADJUSTMENT=1.25
export AKASH_GAS_PRICES=0.025uakt
export AKASH_SIGN_MODE=amino-json
```

## Check your Account Balance

Check your account has sufficient balance by running:

```bash
provider-services query bank balances --node $AKASH_NODE $AKASH_ACCOUNT_ADDRESS
```

You should see a response similar to:

```
balances:
- amount: "25000000"
  denom: uakt
pagination:
  next_key: null
  total: "0"
```

{% hint style="info" %}
Your account must have a minimum balance of 5 AKT to create a deployment. This 5 AKT funds the escrow account associated with the deployment and is used to pay the provider for their services. It is recommended you have more than this minimum balance to pay for transaction fees. For more information on escrow accounts, see [here](https://github.com/ovrclk/docs/blob/master/guides/cli/detailed-steps/broken-reference/README.md)
{% endhint %}
