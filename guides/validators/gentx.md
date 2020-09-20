## Before We begin

Make sure to have Akash client installed on your workstation, check [install guide](/guides/install.md) for instructions.

## 1. Generate Genesis Transaction (GenTx)

Create a genesis transaction to become a Akash Genesis validator, you can create one using `gentx` command from the `akashd`. To create the genesis transaction using the key `alice` and a monitor `mymoniker`:

```sh
akashd init mymoniker --chain-id akashnet-1
curl -s https://raw.githubusercontent.com/ovrclk/net/master/akashnet-1/genesis.json > ~/.akashd/config/genesis.json
akashd gentx --name alice --amount 1000000000uakt
```

You should see a response similar to:

```
Genesis transaction written to "/Users/gosuri/.akashd/config/gentx/gentx-0519098c91a23b00c33d47a53e069e9470a3e736.json"
```

{% hint style='warning' %}

You will be able to validate only if your address has a minimum balance of 1000 AKT in the genesis file

{% endhint %}

## 2. Submit GenTx using Pull Request

  * Fork the [networks repository](https://github.com/ovrclk/net) to your GitHub.
  * Clone the networks repository to your workstation. For example, where <user> is your GitHub username:
  ```sh
  git clone https://github.com/<user>/net.git
  ```
  * Copy the generated GenTx from the `akashd` home directory at `~/.akashd/config/gentx/` to `net/akashnet-1/gentxs`. For the below example, replace `<your-gentx-file>` with your local value.
  ```sh
  cp /Users/<user>/.akashd/config/gentx/<your-gentx-file>.json net/akashnet-1/gentxs/$MONIKER.json
  ```
  * Commit and push your repository.
  * Create a pull request to [networks repository](https://github.com/ovrclk/net) with your team name.

## 3. Join the Akash Discord Community

Get to know your fellow Akash community members as they're vital for your success as a validator. Join our [discord](http://discord.akash.network) group and introduce yourself. 