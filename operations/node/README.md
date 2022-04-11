# Run an Akash Node

We would want our own Akash node when we want to run:

* Akash Validator - a full Akash Node is a prerequisite step to run a validator&#x20;
* Akash Provider - a dedicated Akash Node is recommended for providers&#x20;
* Akash Production dApps - a dedicated Akash Node is best practice to eliminate reliance on public nodes when you take your distributed apps past the testing phase.

In this guide we will review the Akash Node setup.

## Akash Node Setup

### STEP1 - Install Akash Software

In this step we will cover Installing the Akash software on a Linux server.  We will use an Ubuntu server for our examples.  The commands may need to be changed slightly depending on your Linux distribution.

_**Download and Install Akash**_

* Install the Linux unzip utility if needed

```
sudo apt install zip
```

* These commands will retrieve the latest, stable version of the Akash software, store the version in a local variable, and then install that version.

```
cd ~

AKASH_VERSION="$(curl -s "https://raw.githubusercontent.com/ovrclk/net/master/mainnet/version.txt")"

curl https://raw.githubusercontent.com/ovrclk/akash/master/godownloader.sh | sh -s -- "v$AKASH_VERSION"
```

### STEP2 - Add Akash Install Location in the User’s Path

Add the Akash install location to the user’s path for ease of use.

**NOTE -** below we provide the steps to add the Akash install directory to a user’s path on a Linux Ubuntu server.  Please take a look at a guide for your operating system and how to add a directory to a user’s path.

_**Open the user’s path in an editor**_

```
vi /etc/environment
```

_**It is always best practice to view the path within a text editor or cat it out to console prior to the update to avoid errors.**_

```
PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin"
~                                                                                                                                                                                                          
~                                                                                                                                                                                                          
~  
```

_**Add the following directory, which is the Akash install location, to PATH**_

* Note - this assumes Akash was installed while logged in as the root user.

```
/root/bin
```

_**View within the text editor or console following the update**_

```
PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/root/bin"
~                                                                                                                                                                                                          
~                                                                                                                                                                                                          
~ 
```

_**Make the new path active in the current session**_

```
​​source /etc/environment
```

_**Display the version of Akash software installed.  This confirms the software installed and that the new user path addition worked.**_

```
akash version
```

_**Expected**_ _**result**_

* The exact, current version displayed may be different

```
root@node2:~# akash version
v0.14.0
```

### STEP3 - Choose a Node Moniker

We choose a "moniker" which is a readable name for your Akash Node.

* Replace the moniker value with a name of your choice
* **NOTE** - monikers can contain only ASCII characters

```
AKASH_MONIKER=<moniker>
```

_**The moniker can be changed later, if needed, within the following file**_

```
~/.akash/config/config.toml
```

### **STEP4 - Initialize New Node**

In this step we will initialize our new Akash Node.  In the background several configuration files will be created which can be edited later as needed.

_**Before starting the node, we specify the Akash network and chain ID**_

```
AKASH_NET="https://raw.githubusercontent.com/ovrclk/net/master/mainnet"

export AKASH_CHAIN_ID="$(curl -s "$AKASH_NET/chain-id.txt")"
```

_**Start the node**_

```
akash init --chain-id "$AKASH_CHAIN_ID" "$AKASH_MONIKER"
```

_**Example/Expected Result**_

```
{"app_message":{"audit":{"attributes":[]},"auth":{"accounts":[],"params":{"max_memo_characters":"256","sig_verify_cost_ed25519":"590","sig_verify_cost

<output truncated>

},"upgrade":{},"vesting":{}},"chain_id":"akashnet-2","gentxs_dir":"","moniker":"chainzero","node_id":"2f4491952df08e69fd988c6f5d6ed21e25318fbc"}

```

### STEP5 - Set Minimum Gas Price

Your node keeps unconfirmed transactions in its mempool. In order to protect the node from spam, it is best to set a minimum gas price that the transaction must meet in order to be accepted into the mempool.

_**This setting can be found in the following file and we will change the default value which is blank.**_

```
~/.akash/config/app.toml
```

_**The initial recommended min-gas-prices is 0.025uakt but you might want to change it later.**_

```
# This is a TOML config file.
# For more information, see https://github.com/toml-lang/toml

##### main base config options #####

# The minimum gas prices a validator is willing to accept for processing a
# transaction. A transaction's fees must meet the minimum of any denomination
# specified in this config (e.g. 10uatom).

minimum-gas-prices = "0.025uakt"
```

### STEP6 - Copy the Genesis File

Akash nodes need the Genesis file for the blockchain.  In this step we will gather the genesis.json file and make sure it is valid.

_**Copy the Genesis File**_

```
curl -s "$AKASH_NET/genesis.json" > $HOME/.akash/config/genesis.json
```

_**Verify the Genesis File**_

```
akash validate-genesis
```

_**Expected Output of Validate Genesis**_

```
root@ip-10-0-10-101:~# akash validate-genesis

File at /root/.akash/config/genesis.json is a valid genesis file
```

### STEP7 - Add Seed Nodes

A seed node is used as an initial peer on the network. The seed node will provide a list of peers which can be used going forward. In this step we will configure a seed node to connect with.

_**List Current Seed Nodes**_

```
curl -s "$AKASH_NET/seed-nodes.txt" | paste -d, -s
```

_**Expected Output of Seed Node List**_

```
root@ip-10-0-10-101:~# curl -s "$AKASH_NET/seed-nodes.txt" | paste -d, -s

27eb432ccd5e895c5c659659120d68b393dd8c60@35.247.65.183:26656,8e2f56098f182ffe2f6fb09280bafe13c63eb42f@46.101.176.149:26656,fff99a2e8f3c9473e4e5ee9a99611a2e599529fd@46.166.138.218:26656
```

_**Include the Peer Nodes in Config File**_

* Open the config.toml file in an editor

```
vi $HOME/.akash/config/config.toml
```

* Within the editor find the seeds field as shown at the bottom of this output

```
#######################################################
###           P2P Configuration Options             ###
#######################################################
[p2p]

# Address to listen for incoming connections
laddr = "tcp://0.0.0.0:26656"

# Address to advertise to peers for them to dial
# If empty, will use the same port as the laddr,
# and will introspect on the listener or use UPnP
# to figure out the address.
external_address = ""

# Comma separated list of seed nodes to connect to
seeds = ""
```

* Copy and paste the seed nodes returned via the “List Current Seed Nodes” part of this section
* Following update the seeds field should appear like this:

```
# Comma separated list of seed nodes to connect to
seeds = "27eb432ccd5e895c5c659659120d68b393dd8c60@35.247.65.183:26656,8e2f56098f182ffe2f6fb09280bafe13c63eb42f@46.101.176.149:26656,fff99a2e8f3c9473e4e5ee9a99611a2e599529fd@46.166.138.218:26656"
```

### STEP8 - Fast Sync

Fast Sync means nodes can catch up quickly by downloading blocks in bulk.

_**Fast Sync settings can be found in the following file**_

```
~/.akash/config/config.toml
```

_**Verify Fast Sync Settings**_

* Most likely no changes will be necessary to config.toml and the default settings will be fine. But we will make sure.&#x20;
* Verify the fast\_sync field is set to true

```
# If this node is many blocks behind the tip of the chain, FastSync
# allows them to catchup quickly by downloading blocks in parallel
# and verifying their commits
fast_sync = true
```

* Verify the Fast Sync version is set to v0.&#x20;
* While version 0 is said to be the “legacy” version, in our experience this version works better.

```
#######################################################
###       Fast Sync Configuration Connections       ###
#######################################################
[fastsync]

# Fast Sync version to use:
#   1) "v0" (default) - the legacy fast sync implementation
#   2) "v1" - refactor of v0 version for better testability
#   2) "v2" - complete redesign of v0, optimized for testability & readability
version = "v0"
```

### STEP9 - Blockchain Snapshot Use

We could let our node catch up to the current block but this would take a very long time. Instead we will download a snapshot of the blockchain before starting our node.

**NOTE** - at the time of this writing the snapshot is 200GB and could take some time to pull down.

_**Remove Existing Data**_

```
rm -rf ~/.akash/data; \
mkdir -p ~/.akash/data; \
cd ~/.akash/data
```

_**Download Snapshot**_

```
SNAP_NAME=$(curl -s http://135.181.60.250/akash/ | egrep -o ">akashnet-2.*tar" | tr -d ">"); \
wget -O - http://135.181.60.250/akash/${SNAP_NAME} | tar xf -
```

### STEP10 - Start the Akash Node

_**Start the node**_

```
akash start
```

_**Check the status of the node**_

* At first the node will show it is catching up.&#x20;
* Eventually the node will show the height of the latest block.&#x20;
* The latest block number can be found on the [Mintscan](https://www.mintscan.io/akash) website for comparison.

```
akash status
```

## Additional Information

### Config Files

Akash Node configurations are found within these files:

_**Cosmos specific configuration**_

```
~/.akash/config/app.toml
```

_**Tendermint specific configuration**_

```
~/.akash/config/config.toml
```

### Akash Networks

Within this guide the Akash mainnet is used and as specified in the AKASH\_NET value.  To launch a node on the testnet or edgenet and for additional network information, use this [guide](https://github.com/ovrclk/net).

### State Pruning

There are several strategies for pruning state, please be aware that this is only for state and not for block storage:

1. **default:** the last 100 states are kept in addition to every 500th state; pruning at 10 block intervals
2. **nothing:** all historic states will be saved, nothing will be deleted (i.e. archiving node)
3. **everything:** all saved states will be deleted, storing only the current state; pruning at 10 block intervals
4. **custom:** allow pruning options to be manually specified through pruning-keep-recent, pruning-keep-every, and pruning-interval

You can configure the node's pruning strategy at start time with the --pruning or by configuring the app.toml file.

_**Validator Node Pruning Note**_** -** please do not use --pruning everything on validator nodes as it is known to cause issues. Instead use --pruning default.
