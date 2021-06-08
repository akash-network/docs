# Fund the Account

This guide will walk you through funding an account on an Akash network. Funding your network account is, of course, crucial to using the network - all messages charge a transaction fee, and if you are deploying applications then the leases for that deployment are paid out of your account.

### Before We Begin

Make sure to have Akash client installed on your workstation, check [install guide](install.md) for instructions. You'll need a key to use for your account and your account address handy. See the [wallet guide](wallet.md) for how to set this up.

#### Shell Variables Required

| Name | Description |
| :--- | :--- |
| `AKASH_NET` | Akash network configuration base URL. |
| `AKASH_NODE` | Akash network configuration base URL. |
| `AKASH_ACCOUNT_ADDRESS` | The address of your account.  See [here](wallet.md#account-address). |

## Funding Method

There are a number of different ways to fund your account. Some work for `mainnet` and some don't; pick an appropriate option from below for the network you're connecting to.

### Seed Funding

Developers can qualify for a small amount of tokens, up to $1,000 paid in AKT. To qualify follow these steps:

1. Join the Akash Discord server [**discord.akash.network**](http://discord.akash.network) to introduce yourself and verify your wallet address. We will send up to $100 to support your first deployment. 
2. Write a detailed post on [**forum.akash.network**](http://forum.akash.network) about your project and **include a poll** in the proposal post to determine the level of interest in the community. Your forum post should include answers to the following questions:
   * **Problem Statement:** What is the problem you will solve?
   * **Impact:**  What impact will this project have?
   * **Goals:** What are you aiming to accomplish?
   * **Methodology:** How will this task be accomplished?
   * **Timeline:** What is the timeline for accomplishing this task?
   * **Reporting**: How will you report your progress to the community \(e.g. weekly calls, reports\)?

### **Grant Funding as Akash Compute Credits**

Developers can qualify for a long-term Akash Credits as tokens, up to $100,000 paid in AKT. The **Akash Credits** funding process is coming soon. Check back on June 15th, 2021.

### Gitcoin Bounties

We have three bounties on Gitcoin offerring up to $100,000 in funding:

1. [**Akash Deploy UI Challenge**](https://gitcoin.co/issue/ovrclk/awesome-akash/177/100025806)
2. [**Akash Open Cloud Challenge**](https://gitcoin.co/issue/ovrclk/awesome-akash/178/100025807)
3. [**Akash Sovryn Node Challenge**](https://gitcoin.co/issue/ovrclk/awesome-akash/179/100025808)

### Purchasing Tokens

Tokens may currently be purchased on exchanges listed [here](https://akash.network/token). From there you can withdraw tokens to your address.

### Check Balance

Check your account balance with

```bash
akash \
  --node "$AKASH_NODE" \
  query bank balances "$AKASH_ACCOUNT_ADDRESS"
```

You should see a non-zero entry containing `uakt` tokens!

