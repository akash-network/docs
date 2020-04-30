# Phase 1: Node Operations

## Before we begin

Make sure to have Akash client installed on your workstation, check [install guide](/guides/install.md) for instructions.

## Become a Genesis Validator

### Add a Key
Pick a memorable team name, ideally team you've registered with for Akashian. Create a key locally using that name:

```
export TEAM=<name>
akashctl keys add $TEAM
```

{% hint style='warning' %}

Please store the menonic keys in a safe place

{% endhint %}

### Generate Genesis Transaction

```sh
curl -s https://raw.githubusercontent.com/ovrclk/net/master/centauri/genesis.json > ~/.akashd/config/genesis.json
akashd add-genesis-account $(akashctl keys show gosuri -a) 10000000uakt # other values will be removed.
akashd gentx --name gosuri --amount 9000000uakt
```

You should see a response similar to:

```
Genesis transaction written to "/Users/gosuri/.akashd/config/gentx/gentx-0519098c91a23b00c33d47a53e069e9470a3e736.json"
```

### Submit GetTx using Pull Request

1. Fork the [networks repository](https://github.com/ovrclk/net) to your GitHub.
2. Clone the networks repository to your workstation. For example, where <user> is your GitHub username:
  ```sh
  git clone https://github.com/<user>/net.git
  ```
3. Copy the generated GenTx from the `akashd` home directory at `~/.akashd/config/gentx/` to `net/centauri/gentxs`. For the below example, replace `<your-gentx-file>` with your local value.
  ```sh
  cp /Users/gosuri/.akashd/config/gentx/<your-gentx-file>.json net/centauri/gentxs/$TEAM.json
  ```
4. Commit and push your repository.
5. Create a pull request to [networks repository](https://github.com/ovrclk/net) with your team name.
