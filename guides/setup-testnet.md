# Setup Local Testnet
### Before We Begin

Make sure to have Akash client installed on your workstation, check install guide for instructions.

### Get Started

To setup local testnet, please create a key on your local machine.

To create a key, please make sure you installed Akash client on your workstation and run the below:

```
$ akash keys add <key-name>
```
> **Example:**
```
$ akash keys add bob

- name: bob
  type: local
  address: akash1qgjla78dk2yk2eh6dmjeejz6m374ykdtt20r66
  pubkey: akashpub1addwnpepqfv0ap2r7jll2e6pelljx53ar6rk5er58sr0sljwn9whvygut6eputypu4e
  mnemonic: ""
  threshold: 0
  pubkeys: []


**Important** write this mnemonic phrase in a safe place.
It is the only way to recover your account if you ever forget your password.

main nerve normal hill analyst iron weapon ordinary evoke sniff kitchen pyramid address apple direct inform skirt ozone stage market clown home fit height
```
### Running Network
* To initialize configuration and a genesis.json file for your application, start by running:

    ```
    $ akashd init <moniker-name> --chain-id <chain-id>
    
      #moniker is the name of your node
    ```

    ###### Example:
    ```
    $ akashd init newmoniker --chain-id devnet
    ```
* Add account to genesis file along with coins and generate transaction:

    ```
    $ akashd add-genesis-account <key-name> <amount-with-denom>
    $ akashd gentx --name  <key-name>
    ```
    ###### Example:
    ```
    $ akashd add-genesis-account bob 1000000000stake
    $ akashd gentx --name bob
    ```
* To input generated transaction into genesis file and start node, run below commands:
    ```
    $ akashd collect-gentxs

    $ akashd start
    I[2020-02-27|15:43:03.835] starting ABCI with Tendermint   module=main 
    I[2020-02-27|15:43:10.594] processed active leases         module=main count=0
    I[2020-02-27|15:43:10.594] Executed block                  module=state height=1 validTxs=0 invalidTxs=0
    ```

You will be seen with streaming logs which indicates production of blocks.

**That's it, your node has been successfully started.**