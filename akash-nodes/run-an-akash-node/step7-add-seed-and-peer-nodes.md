# STEP7 - Add Seed and Peer Nodes



A seed node is used as an initial peer on the network. The seed node will provide a list of peers which can be used going forward. In this step we will configure a seed node to connect with.

## Seed Nodes

### List Current Seed Nodes

```
curl -s "$AKASH_NET/seed-nodes.txt" | paste -d, -s
```

### Expected Output of Seed Node List

```
root@ip-10-0-10-101:~# curl -s "$AKASH_NET/seed-nodes.txt" | paste -d, -s

27eb432ccd5e895c5c659659120d68b393dd8c60@35.247.65.183:26656,8e2f56098f182ffe2f6fb09280bafe13c63eb42f@46.101.176.149:26656,fff99a2e8f3c9473e4e5ee9a99611a2e599529fd@46.166.138.218:26656
```

### **Include the Seed Nodes in Config Files**

#### Seed Nodes

*   Open the config.toml file in an editor

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
*   Following update the seeds field should appear like this:

    ```
    # Comma separated list of seed nodes to connect to
    seeds = "27eb432ccd5e895c5c659659120d68b393dd8c60@35.247.65.183:26656,8e2f56098f182ffe2f6fb09280bafe13c63eb42f@46.101.176.149:26656,fff99a2e8f3c9473e4e5ee9a99611a2e599529fd@46.166.138.218:26656"
    ```

## Peer Nodes

### List Current Peer Nodes

```
curl -s "$AKASH_NET/peer-nodes.txt" | paste -d, -s
```

### Expected Output of Peer Node List

```
root@ip-10-0-10-146:~# curl -s "$AKASH_NET/peer-nodes.txt" | paste -d, -s

27eb432ccd5e895c5c659659120d68b393dd8c60@35.247.65.183:26656,9180b99a5be3443677e0f57fc5f40e8f071bdcd8@161.35.239.0:51656,47c9acc0e7d9b244a6404458e76d50b6284bfbbb@142.93.77.25:26656,ab7b55588ea3f4f7a477e852aa262959e54117cd@3.235.249.94:26656,4acf579e2744268f834c713e894850995bbf0ffa@50.18.31.225:26656,3691ac1f56389ffec8579c13a6eb8eca41cf8ae3@54.219.88.246:26656,86afe23f116ba4754a19819a55d153008eb74b48@15.164.87.75:26656,6fbc3808f7d6c961e84944ae2d8c800a8bbffbb4@138.201.159.100:26656,a2a3ffe7ac122a218e1f59c32a670f04b8fd3033@165.22.69.102:26656
```

### **Include the Peer Nodes in Config Files**

#### Persistent Peers

*   Open the config.toml file in an editor

    ```
    vi $HOME/.akash/config/config.toml
    ```
* Within the editor find the persistent\_peers field as shown at the bottom of this output

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
# to figure out the address. ip and port are required
# example: 159.89.10.97:26656
external_address = ""

# Comma separated list of seed nodes to connect to
seeds = "429d14fe2ab411e946623c20b060efdf230a5a8a@p2p.edgenet-1.ewr1.aksh.pw:26656,174e186ab7ef0aa8add457fecc5cca41b52cc031@p2p.edgenet-1.ewr1.aksh.pw:26652,a0dcc96946847f8bee74ffabd7d6d4809d030829@p2p.edgenet-1.ewr1.aksh.pw:26653,49c15444a04187b46db5e35b428b93bda42885e8@p2p.edgenet-1.ewr1.aksh.pw:26654,d9b7aba0738fd94072f11f49d5c2c0e119ef4268@170.187.200.114:26656"

# Comma separated list of nodes to keep persistent connections to
persistent_peers = ""
```

* Copy and paste the seed nodes returned via the “List Current Peer Nodes” part of this section
* Following update the persistent\_peers field should appear like this:

```
# Comma separated list of nodes to keep persistent connections to

persistent_peers = "27eb432ccd5e895c5c659659120d68b393dd8c60@35.247.65.183:26656,9180b99a5be3443677e0f57fc5f40e8f071bdcd8@161.35.239.0:51656,47c9acc0e7d9b244a6404458e76d50b6284bfbbb@142.93.77.25:26656,ab7b55588ea3f4f7a477e852aa262959e54117cd@3.235.249.94:26656,4acf579e2744268f834c713e894850995bbf0ffa@50.18.31.225:26656,3691ac1f56389ffec8579c13a6eb8eca41cf8ae3@54.219.88.246:26656,86afe23f116ba4754a19819a55d153008eb74b48@15.164.87.75:26656,6fbc3808f7d6c961e84944ae2d8c800a8bbffbb4@138.201.159.100:26656,a2a3ffe7ac122a218e1f59c32a670f04b8fd3033@165.22.69.102:26656"
```

## RPC Listening Address



*   Open the config.toml file in an editor

    ```
    vi $HOME/.akash/config/config.toml
    ```
* Within the editor find the RPC listening address field as shown in this output
* Update the listening address field to `"tcp://0.0.0.0:26657"` as shown
* This setting will ensure listening occurs on all interfaces

```
[rpc]

# TCP or UNIX socket address for the RPC server to listen on
laddr = "tcp://0.0.0.0:26657"
```
