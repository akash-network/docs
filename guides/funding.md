# Fund the Account

This guide will walk you through funding an account on an Akash network. Funding your network account is, of course, crucial to using the network - all messages charge a transaction fee, and if you are deploying applications then the leases for that deployment are paid out of your account.

### Before We Begin

Make sure to have Akash client installed on your workstation, check [install guide](install.md) for instructions. You'll need a key to use for your account and your account address handy. See the [wallet guide](wallet.md) for how to set this up.

#### Shell Variables Required

| Name | Description |
| :--- | :--- |
| `AKASH_NET` | Akash network configuration base URL.  |
| `AKASH_NODE` | Akash network configuration base URL.  |
| `AKASH_ACCOUNT_ADDRESS` | The address of your account.  See [here](wallet.md#account-address). |

## Funding Method

There are a number of different ways to fund your account. Some work for `mainnet` and some don't; pick an appropriate option from below for the network you're connecting to.

### Developer Seed Funding

Write a detailed post on ****[**forum.akash.network**](http://forum.akash.network) about your project to qualify for Seed Funding up to $100. Join the Akash Discord server [**discord.akash.network**](http://discord.akash.network) to verify your wallet address for seed funding. Message @colinster\#0001 to discuss seed funding. 

### Developer Grant Funding

Grant funding is coming soon! Check back on June 15th, 2021.

### Purchasing Tokens

**`mainnet`-only**

Tokens may currently be purchased on exchanges listed [here](https://akash.network/token). From there you can withdraw tokens to your address.

### Check Balance

Check your account balance with

```bash
akash \
  --node "$AKASH_NODE" \
  query bank balances "$AKASH_ACCOUNT_ADDRESS"
```

You should see a non-zero entry containing `uakt` tokens!

