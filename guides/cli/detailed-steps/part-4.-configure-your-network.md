# Part 4.  Configure your Network



First configure the base URL (`$AKASH_NET`) for the Akash Network; copy and paste the command below:

```bash
AKASH_NET="https://raw.githubusercontent.com/ovrclk/net/master/mainnet"
```

#### Version

Next configure the version of the Akash Network `AKASH_VERSION`; copy and paste the command below:

```bash
AKASH_VERSION="$(curl -s "$AKASH_NET/version.txt")"
```

#### Chain ID

The akash CLI will recogonize `AKASH_CHAIN_ID` environment variable when exported to the shell.

```bash
export AKASH_CHAIN_ID="$(curl -s "$AKASH_NET/chain-id.txt")"
```

#### Network Node

You need to select a node on the network to connect to, using an RPC endpoint. To configure the`AKASH_NODE` environment variable use this export command:

```bash
export AKASH_NODE="$(curl -s "$AKASH_NET/rpc-nodes.txt" | shuf -n 1)"
```

#### Confirm your network variables are setup

Your values may differ depending on the network you're connecting to.

```bash
echo $AKASH_NODE $AKASH_CHAIN_ID $AKASH_KEYRING_BACKEND
```

You should see something similar to:

`http://135.181.60.250:26657 akashnet-2 os`

### Check your Account Balance

Check your account has sufficient balance by running:

```bash
akash query bank balances --node $AKASH_NODE $AKASH_ACCOUNT_ADDRESS
```

You should see a response similar to:

```
balances:
- amount: "93000637"
  denom: uakt
pagination:
  next_key: null
  total: "0"
```

If you don't have a balance, please see the [funding guide](https://github.com/ovrclk/docs/tree/b65f668b212ad1976fb976ad84a9104a9af29770/guides/wallet/funding.md). Please note the balance indicated is denominated in uAKT (AKT x 10^-6), in the above example, the account has a balance of _93 AKT_. We're now setup to deploy.

{% hint style="info" %}
Your account must have a minimum balance of 5 AKT to create a deployment. This 5 AKT funds the escrow account associated with the deployment and is used to pay the provider for their services. It is recommended you have more than this minimum balance to pay for transaction fees. For more information on escrow accounts, see [here](broken-reference)
{% endhint %}
