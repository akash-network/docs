# Funding your Account

This guide will walk you through funding an account on an Akash network. Funding your network account is, of course, crucial to using the network - all messages charge a transaction fee, and if you are deploying applications then the leases for that deployment are paid out of your account.

### Before We Begin

You'll need to know information about the network you're connecting your node to. See [Choosing a Network](version.md) for how to obtain any network-related information.

Make sure to have Akash client installed on your workstation, check [install guide](install.md) for instructions.

You'll need a key to use for your account and your account address handy. See the [wallet guide](https://github.com/ovrclk/docs/tree/9ba5597d7a6d9df65c8de647b52806904d25d845/guides/wallet.md) for how to set this up.

#### Shell Variables Required

| Name | Description |
| :--- | :--- |
| `AKASH_NET` | Akash network configuration base URL. See [here](version.md). |
| `AKASH_NODE` | Akash network configuration base URL. See [here](version.md). |
| `ACCOUNT_ADDRESS` | The address of your account.  See [here](wallet.md#account-address). |

## Funding Method

There are a number of different ways to fund your account. Some work for `mainnet` and some don't; pick an appropriate option from below for the network you're connecting to.

### Faucet

**Non-`mainnet`** networks will often times have a "faucet" running - a server that will send tokens to your account. You can see the faucet url by running:

```bash
curl "$AKASH_NET/faucet-url.txt"
```

Go to the resulting URL and enter your account address; you should see tokens in your account shortly.

### Purchasing Tokens

**`mainnet`-only**

Tokens may currently be purchased on bitmax.io. From there you can withdraw tokens to your address.

### Check Balance

Check your account balance with

```bash
akash \
  --node "$AKASH_NODE" \
  query bank balances "$ACCOUNT_ADDRESS"
```

You should see a non-zero entry containing `uakt` tokens!

