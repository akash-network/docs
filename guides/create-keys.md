Creating Keys
-------------

To interact with the Akash Network, an account key pair is needed to create and sign transactions. Akash uses the [Cosmos SDK Keyring](https://hub.cosmos.network/master/delegators/delegator-guide-cli.html#cosmos-accounts) toolchain to manage keys. The Cosmos SDK provides key management via a Ledger device, OS keyring, and files(for testing) are all supported and configured with the `akashctl... --keyring-backend` global flag. For more key management documentation see [Manage keys](usage/cli/keys.md).

## Creating a Key Set

Pick a memorable name, ideally team you've registered with for Akashian. Create a key locally using that name:

```
export TEAM=<name>
akashctl keys add $TEAM
```

{% hint style='warning' %}

Please store the menonic keys in a safe place

{% endhint %}

## Interacting with Akash Network

To view the *address* of your created key:
```sh
akashctl keys show $TEAM -a
<Address to request faucet funds>
```

Example address format: `akash1yg7y928farnqeggrduu7l4j427vez9j3uf40jp`

**Note: To join the Akash Network after the Genesis file has been finalized, requires your key to be initialized on the chain by a transaction.**

Join the [Akash Network](https://riot.im/app/#/room/#akashnet:matrix.org) Riot channel and request funds to be transfered to your *address* from an admin. Once the transaction is complete, you'll be able to interact with the Akash Network using that key!
