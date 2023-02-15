# STEP 3 - Akash Provider Wallet

Placing a bid on an order requires a 5 AKT deposit placed into collateral per bid won. If the provider desired 2 concurrent leases, the provider’s wallet would need minimum funding of 10AKT.

As every deployment request bid requires 5 AKT to be deposited in the escrow account, it's always good to have more so your provider can keep bidding. If your provider is ready to offer 10 deployments, then it's best to have 5 x 10 = 50 AKT and a little more to make sure the provider can pay the fees for broadcasting the transactions on Akash Network.

The steps to create an Akash wallet are covered in the following documentation sections:

* [Create an Account](https://docs.akash.network/guides/cli/detailed-steps/part-2.-create-an-account)
* [Fund Your Account](https://docs.akash.network/guides/cli/detailed-steps/part-3.-fund-your-account)

## Import the Wallet onto the Akash Provider

* Capture the Akash Account in the output of `provider-services keys add` for use in the subsequent step

```
###Replace YOUR_KEY_NAME
export AKASH_KEY_NAME={YOUR_KEY_NAME}'
export AKASH_KEYRING_BACKEND=os'

###Import keys using the mnemonic phrase from your Kepler wallet
provider-services keys add $AKASH_KEY_NAME --recover
```

## Configure Network And Account Settings

```
export AKASH_NET="https://raw.githubusercontent.com/akash-network/net/master/mainnet"
export AKASH_CHAIN_ID="$(curl -s "$AKASH_NET/chain-id.txt")"
export AKASH_NODE="$(curl -s "$AKASH_NET/rpc-nodes.txt" | shuf -n 1)"

###Replace the YOUR_ACCOUNT variable with your provider account (I.e. akash1qt5jjuhwf1232vn7696s6y6c0lwfv2ggetz)
export AKASH_ACCOUNT_ADDRESS={YOUR_ACCOUNT}
```

## Check Provider Wallet Balance

```
provider-services query bank balances --node $AKASH_NODE $AKASH_ACCOUNT_ADDRESS
```

#### Expected/Example Output

```
provider-services query bank balances --node $AKASH_NODE $AKASH_ACCOUNT_ADDRESS

balances:
- amount: "30735641"
  denom: uakt
pagination:
  next_key: null
  total: "0"
```
