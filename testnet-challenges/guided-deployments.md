# Guided Deployments

In Week 1, challenges will focus on deploying stand-alone applications, from website deployments to single-node blockchain networks.

**Qualification Criteria**:

Although we do not limit anyone from participating, to claim AKT rewards:

* You must not be a resident of any of the OFAC sanctioned countries.
* You must pass KYC/AML verification when collecting the reward. The details for which will be posted at a later time.

{% hint %}
Each of these challenges will ask you to follow the [deployment guide](/guides/deploy) to deploy a specific [SDL](/sdl/README.md) file.
{% endhint %}

* [Challenge 1 (Week 1)](#challenge-1-week-1)
* [Challenge 2 (Week 1)](#challenge-2-week-1)
* [Challenge 3 (Week 1)](#challenge-3-week-1)
* [Challenge 1 (Week 2)](#challenge-1-week-2)
* [Challenge 2 (Week 2)](#challenge-2-week-2)
* [Challenge 3 (Week 2)](#challenge-3-week-2)

## Challenge 1 (Week 1)

{% hint style="warning" %}
The submission deadline for this challenge has passed.
{% endhint %}

**Challenge**: Deploy a web app on Akash and attach a custom domain.

**Reward**: 150 AKTs

**Winners**: First 200 submissions — measured by the timestamp of the git commit — that pass the qualification criteria. 

**Instructions**:

1) Sign up to Akash [Testnet](https://app.akash.network).

2) Using [this](deploy-1-1.yaml) SDL file when following the [deploy instructions](/guides/deploy) to deploy your own
instance of the [Lunie-Lite](https://github.com/luniehq/lunie-light) wallet.

### Submission

**Scoring Starts**: Nov 30, 2020 9:00 AM PT 

**Scoring End**: Dec 2, 2020 5:00 PM PT

**Instructions**:

1) Fork the [ecosystem repository](https://github.com/ovrclk/ecosystem).

2) Clone the ecosystem repository to your workstation. For example, where `<user>` is your GitHub username:
  
  ```shell
  git clone https://github.com/<user>/ecosystem.git
  ```

3) Submit the JSON for your lease as the proof with the **Participation ID** from [Testnet](https://app.akash.network) as the filename under `akashian/phase3/challenge1` directory.

For example, if your code is `dgbfr0rugcxnyuu`, the file will be `akashian/phase3/challenge1/dgbfr0rugcxnyuu.json`.

Popuate `$CODE` with your **Participation ID** from [Testnet](https://app.akash.network) and run the below:

```sh
akash query market lease get \
  --dseq $DSEQ \
  --gseq $GSEQ \
  --oseq $OSEQ \
  --provider $PROVIDER \
  --owner $ACCOUNT_ADDRESS \
  --node $AKASH_NODE -o json \> akashian/phase3/challenge1/$CODE.json
```

See https://github.com/ovrclk/ecosystem/tree/master/akashian/phase3/challenge1/dgbfr0rugcxnyuu.json for example.

4) Commit your code, and send a pull request to [ecosystem repo](https://github.com/ovrclk/ecosystem).

## Challenge 2 (Week 1)

{% hint style="warning" %}
The submission deadline for this challenge has passed.
{% endhint %}

**Challenge**: Deploy a databased-backed web app on Akash and attach a custom domain.

**Reward**: 200 AKTs

**Winners**: First 200 submissions — measured by the timestamp of the git commit — that pass the qualification criteria. 

**Instructions**:

1) Sign up to Akash [Testnet](https://app.akash.network).

2) Using [this](deploy-1-2.yaml) SDL file when following the [deploy instructions](/guides/deploy) to deploy your own
instance of the a [retwis](https://github.com/fager/retwis), a Twitter-toy clone written in PHP and Redis, used in the early days to introduce Redis data types.

### Submission

**Scoring Starts**: Dec 1, 2020 9:00 AM PT 

**Scoring End**: Dec 3, 2020 5:00 PM PT

**Instructions**:

1) Fork the [ecosystem repository](https://github.com/ovrclk/ecosystem).

2) Clone the ecosystem repository to your workstation. For example, where `<user>` is your GitHub username:
  
  ```shell
  git clone https://github.com/<user>/ecosystem.git
  ```

3) Submit the JSON for your lease as the proof with the **Participation ID** from [Testnet](https://app.akash.network) as the filename under `akashian/phase3/challenge2` directory.

For example, if your code is `dgbfr0rugcxnyuu`, the file will be `akashian/phase3/challenge2/dgbfr0rugcxnyuu.json`.

Popuate `$CODE` with your **Participation ID** from [Testnet](https://app.akash.network) and run the below:

```sh
akash query market lease get \
  --dseq $DSEQ \
  --gseq $GSEQ \
  --oseq $OSEQ \
  --provider $PROVIDER \
  --owner $ACCOUNT_ADDRESS \
  --node $AKASH_NODE -o json \> akashian/phase3/challenge2/$CODE.json
```

See https://github.com/ovrclk/ecosystem/tree/master/akashian/phase3/challenge1/dgbfr0rugcxnyuu.json for example.

4) Commit your code, and send a pull request to [ecosystem repo](https://github.com/ovrclk/ecosystem).


## Challenge 3 (Week 1)

{% hint style="warning" %}
The submission deadline for this challenge has passed.
{% endhint %}

**Challenge**: Deploy a single node network on Akash.  Single nodes can be useful for development and testing; this
is a sneak-peak of next week's challenges, which will guide you through bringing up a node that joins a real blockchain
network.

**Reward**: 250 AKTs

**Winners**: First 200 submissions — measured by the timestamp of the git commit — that pass the qualification criteria. 

**Instructions**: Instructions will be available on Dec 2, 2020 9:00 AM 

1) Fork the [ecosystem repository](https://github.com/ovrclk/ecosystem).

2) Using [this](deploy-1-3.yaml) SDL file when following the [deploy instructions](/guides/deploy) to deploy your own
instance of an [Akash](https://github.com/ovrclk/akash), node!

The given [SDL](deploy-1-3.yaml) exposes your node's RPC service on port 80.  Here's how you can test it out:

1. Look up the generated hostname for your deployment with the `lease-status` command as described in the [guide](/guides/deploy).
1. Use that hostname (we'll call it `$DEPLOYMENT_HOST`) in the `--node` argument to `akash`:

```sh
akash --node "tcp://$DEPLOYMENT_HOST:80" status
```
Or, for those that are more comfortable on the command line:

```sh
DEPLOYMENT_HOST="$(\
  akash provider lease-status \
    --node $AKASH_NODE \
    --dseq $DSEQ \
    --oseq $OSEQ \
    --gseq $GSEQ \
    --provider $PROVIDER \
    --owner $ACCOUNT_ADDRESS \
  | jq -r '.services.akash.uris[0]')"
akash --node "tcp://$DEPLOYMENT_HOST:80" status
```

**Note**: Once you have [submitted](#submission) your participation, you should close your lease.

### Submission

**Scoring Starts**: Dec 2, 2020 9:00 AM PT 

**Scoring End**: Dec 4, 2020 5:00 PM PT

**Instructions**:

1) Fork the [ecosystem repository](https://github.com/ovrclk/ecosystem).

2) Clone the ecosystem repository to your workstation. For example, where `<user>` is your GitHub username:
  
  ```shell
  git clone https://github.com/<user>/ecosystem.git
  ```

3) Submit the JSON for your lease as the proof with the **Participation ID** from [Testnet](https://app.akash.network) as the filename under `akashian/phase3/challenge2` directory.

For example, if your code is `dgbfr0rugcxnyuu`, the file will be `akashian/phase3/challenge2/dgbfr0rugcxnyuu.json`.

Popuate `$CODE` with your **Participation ID** from [Testnet](https://app.akash.network) and run the below:

```sh
akash query market lease get \
  --dseq $DSEQ \
  --gseq $GSEQ \
  --oseq $OSEQ \
  --provider $PROVIDER \
  --owner $ACCOUNT_ADDRESS \
  --node $AKASH_NODE -o json \> akashian/phase3/challenge3/$CODE.json
```

See https://github.com/ovrclk/ecosystem/tree/master/akashian/phase3/challenge1/dgbfr0rugcxnyuu.json for example.

## Challenge 1 (Week 2)

{% hint style="warning" %}
The submission deadline for this challenge has passed.
{% endhint %}

**Challenge**: Deploy an API node on a live network.  API nodes are useful for creating wallets and explorers and are
a perfect fit for use on Akash.

Note that when you deploy this node it will connect to a **live** Akash network, catch up to the latest block height, and
participate in the peer-to-peer protocol.

The settings for the network that your node will be connecting to are [here](https://github.com/ovrclk/net/tree/master/definet).

**Reward**: 150 AKTs

**Winners**: First 200 submissions — measured by the timestamp of the git commit — that pass the qualification criteria. 

**Instructions**:

1) Using [this](deploy-2-1.yaml) SDL file when following the [deploy instructions](/guides/deploy) to deploy your own
instance of an [Akash](https://github.com/ovrclk/akash) API node.

The given [SDL](deploy-2-1.yaml) exposes your node's API service on a random port.  Here's how you can test it out:

Look up the generated hostname for your deployment with the `lease-status` command as described in the [guide](/guides/deploy).  There will be a list of `"forwarded-ports"`. Look for an entry for port `1317`; the `host` and `externalPort` fields
from that are where you can reach your API node.

For advanced users:
```sh
akash provider lease-status \
  --dseq $DSEQ \
  --gseq $GSEQ \
  --oseq $OSEQ \
  --provider $PROVIDER \
  --owner $ACCOUNT_ADDRESS \
  --node $AKASH_NODE \
  | jq '.["forwarded-ports"].akash[] | select(.port==1317)'
```

The above command will produce:

```json
{
  "host": "ext.provider1.akashdev.net",
  "port": 1317,
  "externalPort": 32747,
  "proto": "TCP",
  "available": 1,
  "name": "akash"
}
```

You can then test your API server by visiting it with a browser or using `curl`.  The below examples use
the data from above; change the host and port to match your output.

1. `curl http://ext.provider1.akashdev.net:32747/node_info`
1. Swagger interface: [http://ext.provider1.akashdev.net:32747/swagger/#/](http://ext.provider1.akashdev.net:32747/swagger/#/)

If you run into problems, [check your logs](/guides/deploy#view-your-logs) to see if you can remedy the problem.

**Note**: Once you have [submitted](#submission) your participation, you should close your lease.

### Submission

**Scoring Starts**: Dec 7, 2020 9:00 AM PT 

**Scoring End**: Dec 10, 2020 5:00 PM PT

**Instructions**:

1) Fork the [ecosystem repository](https://github.com/ovrclk/ecosystem).

2) Clone the ecosystem repository to your workstation. For example, where `<user>` is your GitHub username:
  
  ```shell
  git clone https://github.com/<user>/ecosystem.git
  ```

3) Submit the JSON for your lease as the proof with the **Participation ID** from [Testnet](https://app.akash.network) as the filename under `akashian/phase3/challenge4` directory.

For example, if your code is `dgbfr0rugcxnyuu`, the file will be `akashian/phase3/challenge4/dgbfr0rugcxnyuu.json`.

Popuate `$CODE` with your **Participation ID** from [Testnet](https://app.akash.network) and run the below:

```sh
akash query market lease get \
  --dseq $DSEQ \
  --gseq $GSEQ \
  --oseq $OSEQ \
  --provider $PROVIDER \
  --owner $ACCOUNT_ADDRESS \
  --node $AKASH_NODE -o json \
  > akashian/phase3/challenge4/$CODE.json
```

See https://github.com/ovrclk/ecosystem/tree/master/akashian/phase3/challenge1/dgbfr0rugcxnyuu.json for example.

## Challenge 2 (Week 2)

**Challenge**: Deploy an RPC node on a live network and send a transaction to it.

RPC nodes allow querying similar to the API nodes from the [previous challenge](#challenge-1-week-2),
but also allow sending transactions to the network.

{% hint %}

In this challenge you will be deploying an [Akash](https://github.com/ovrclk/akash) node by creating a deployment on the current [edgenet](https://github.com/ovrclk/net/tree/master/edgenet) network.

The node that you deploy will join a [separate network](https://github.com/ovrclk/net/tree/master/definet).

The [SDL](/sdl/README.md) file that is included in this challenge describes how the new node should be deployed,
and you will create this deployment **on the `edgenet` network**.

**YOU DO NOT NEED TO CREATE A NODE FOR, OR INTERACT WITH, THE [SEPARATE NETWORK](https://github.com/ovrclk/net/tree/master/definet) BEYOND WHAT IS DESCRIBED BELOW** 

{% endhint %}

**Reward**: 200 AKTs

**Winners**: First 200 submissions — measured by the timestamp of the git commit — that pass the qualification criteria. 

**Instructions**:

1) Using [this](deploy-2-2.yaml) SDL file when following the [deploy instructions](/guides/deploy) to deploy your own
instance of an [Akash](https://github.com/ovrclk/akash) RPC node.

The given [SDL](deploy-2-2.yaml) exposes your node's RPC service on a random port.  Here's how you can test it out:

Look up the generated hostname for your deployment with the `lease-status` command as described in the [guide](/guides/deploy).  There will be a list of `"forwarded-ports"`. Look for an entry for port `26657`; the `host` and `externalPort` fields
from that are where you can reach your API node.

For advanced users:
```sh
akash provider lease-status \
  --dseq $DSEQ \
  --gseq $GSEQ \
  --oseq $OSEQ \
  --provider $PROVIDER \
  --owner $ACCOUNT_ADDRESS \
  --node $AKASH_NODE \
  | jq -r '.["forwarded-ports"].akash[] | select(.port==26657)'
```

The above command will produce:

```json
{
  "host": "ext.provider1.akashdev.net",
  "port": 26657,
  "externalPort": 32747,
  "proto": "TCP",
  "available": 1,
  "name": "akash"
}
```

{% hint style="notice" %}
If the `"host"` field is not present in the command above,
please use the following to look up the host:

```sh
akash provider lease-status \
  --dseq $DSEQ \
  --gseq $GSEQ \
  --oseq $OSEQ \
  --provider $PROVIDER \
  --owner $ACCOUNT_ADDRESS \
  --node $AKASH_NODE \
  | jq -r '.services.akash.uris[0]'
```
{% endhint %}

With this information we can construct the RPC endpoint:

```sh
TESTNET_NODE=http://ext.provider1.akashdev.net:32747
```

You can then test your RPC server by visiting it with a browser or using `curl`:

```sh
curl -s "$TESTNET_NODE/status"
```

Or with the [Akash](https://github.com/ovrclk/akash) client:

```sh
akash --node "$TESTNET_NODE"
```

When your node first starts, it will attempt to sync with the network by "catching up".  You can see this in the
status:

```sh
akash --node $TESTNET_NODE status | jq '.sync_info.catching_up'
true
```

Wait for your node to catch up.  **This may take some time**.  Your node is using the new [state-sync](https://docs.tendermint.com/master/tendermint-core/state-sync.html) feature of tendermint, but the peer-to-peer protocol can run into problems
which makes this take longer than we'd like.

The *good* news is that today's [SDL](deploy-2-2.yaml) turns on it's ability to serve `state-sync` blocks, so
as more people participate in the challenge, the new nodes _may_ get up to speed faster.

[Check your logs](/guides/deploy#view-your-logs) to see how things are going during the process.

If and when your node catches up, continue on.  If it turns out that many people are having problems getting
their nodes caught up, we will not require [sending a transaction to your node](#send-a-transaction).  Let's see what happens - this _is_ a **testnet**, after all.

### Send a Transaction

If you've made it this far, let's put our efforts to work: we will send a transaction *to your new node*.

1) Follow the steps for using the faucet in [Funding your Account](/guides/wallet/funding.md).  The faucet is currently
configured to send your address tokens **on both networks**.

2) Send 1 AKT to the following address **through the node you created in this challenge**: `akash1vl3gun7p8y4ttzajrtyevdy5sa2tjz3a29zuah`.  Include your **Participation ID** (`$CODE`) from [Testnet](https://app.akash.network) in the memo field of the transaction:

```sh
akash \
  --node "$TESTNET_NODE" \
  --chain-id akash-edgenet-2 \
  --keyring-backend "$KEYRING_BACKEND" \
  --memo "$CODE" \
  tx send "$KEY_NAME" akash1vl3gun7p8y4ttzajrtyevdy5sa2tjz3a29zuah 1000000uakt
```

Once your transaction is complete, you have finished today's challenge and can [submit](#submission) your
participation.

**Note**: Once you have [submitted](#submission) your participation, you should close your lease.

### Submission

**Scoring Starts**: Dec 8, 2020 9:00 AM PT 

**Scoring End**: Dec 11, 2020 5:00 PM PT

**Instructions**:

1) Fork the [ecosystem repository](https://github.com/ovrclk/ecosystem).

2) Clone the ecosystem repository to your workstation. For example, where `<user>` is your GitHub username:
  
  ```shell
  git clone https://github.com/<user>/ecosystem.git
  ```

3) Submit the JSON for your lease as the proof with the **Participation ID** from [Testnet](https://app.akash.network) as the filename under `akashian/phase3/challenge5` directory.

For example, if your code is `dgbfr0rugcxnyuu`, the file will be `akashian/phase3/challenge5/dgbfr0rugcxnyuu.json`.

Popuate `$CODE` with your **Participation ID** from [Testnet](https://app.akash.network) and run the below:

```sh
akash query market lease get \
  --dseq $DSEQ \
  --gseq $GSEQ \
  --oseq $OSEQ \
  --provider $PROVIDER \
  --owner $ACCOUNT_ADDRESS \
  --node $AKASH_NODE -o json \
  > akashian/phase3/challenge5/$CODE.json
```

See https://github.com/ovrclk/ecosystem/tree/master/akashian/phase3/challenge1/dgbfr0rugcxnyuu.json for example.

## Challenge 3 (Week 2)

**Challenge**:

In the [previous challenge](#challenge-2-week-2), we deployed an RPC node that connected to a
[separate network](https://github.com/ovrclk/net/tree/master/definet).  In this final challenge,
we are going to take it one step further and turn your deployed node into a **validator**.

{% hint style="warning" %}
**DO NOT USE THESE INSTRUCTIONS TO HOST A `MAINNET` VALIDATOR OF ANY KIND**

There are many use-cases for hosting a validator on [Akash](https://github.com/ovrclk/akash),
but using [Akash](https://github.com/ovrclk/akash) to host a _mainnet_ validator is not one of them
(for the time being).
{% endhint %}

**Reward**: 250 AKTs

**Winners**: First 200 submissions — measured by the timestamp of the git commit — that pass the qualification criteria. 

**Instructions**:

{% hint %}

In this challenge you will be deploying an [Akash](https://github.com/ovrclk/akash) node by creating a deployment on the current [edgenet](https://github.com/ovrclk/net/tree/master/edgenet) network.

The node that you deploy will join a [separate network](https://github.com/ovrclk/net/tree/master/definet).

The [SDL](/sdl/README.md) file that is included in this challenge describes how the new node should be deployed,
and you will create this deployment **on the `edgenet` network**.

**YOU DO NOT NEED TO CREATE A NODE FOR, OR INTERACT WITH, THE [SEPARATE NETWORK](https://github.com/ovrclk/net/tree/master/definet) BEYOND WHAT IS DESCRIBED BELOW** 

{% endhint %}

Instructions will be revealed when the challenge starts.

{% comment %}

This final guided challenge will be similar to the [previous challenge](#challenge-2-week-2), but
there are a few workflow changes that are meant to address some of the difficulties we saw during that challenge:

1. We will use a **separate wallet key** for the [secondary network](https://github.com/ovrclk/net/tree/master/definet).
1. We will not send transactions *through* our node, but rather to a separate public RPC node.

**This challenge is going to be _difficult_.**  The purpose of these challenges is to both
test the limits of [Akash](https://github.com/ovrclk/akash) software and to build a community
of proficient users of the system.

It is expected that you will run into problems.  Try to use these setbacks as a learning opportunities.

* _Think_ about what you're doing - don't mindlessly follow instructions verbatim.
* When asking questions on [Discord](https://discord.akash.network), include as much information as
you can - deployment ID, logs, etc...
* Double check your variables - think about whether they make sense for the task you are trying to complete.
* Read through the help pages of `akash` commands (use `--help`).  There are often times commands or options
that are relevant to the issue you are having.  **try them out**.

Finally, thank you for participating in these challenges.  The whole team here at [Akash](https://githubcom/ovrclk/akash)
has been blown away by the level of interest in our testnet and product in general.  We can't thank
you enough for the valuable feedback you're giving us, and we hope that you enjoy the challenges!

### Variables

For the purposes of this guide, you will need some variables defined:

* `SECONDARY_NODE`, which can be defined as follows.

```sh
SECONDARY_NODE="$(curl -s https://raw.githubusercontent.com/ovrclk/net/master/definet/rpc-nodes.txt | head -1)"
```

* `SECONDARY_MONIKER`, which should be set to your **Participation ID** from [Testnet](https://app.akash.network).  As always,
we will use the value `dgbfr0rugcxnyuu` as our example ID.

```sh
SECONDARY_MONIKER=dgbfr0rugcxnyuu
```

* `SECONDARY_KEY_NAME`: an arbitrary key name that is separate from your `$KEY_NAME`.  A reasonable
default is below:

```sh
SECONDARY_KEY_NAME=secondary-key
```

* `SECONDARY_CHAIN_ID`: the chain-id of the secondary network.  It is `akash-edgenet-2`

```sh
SECONDARY_CHAIN_ID=akash-edgenet-2
```

### Deploy Your Node

1) Download [this](deploy-2-3.yaml) SDL file.  Edit the file and set the `AKASH_MONIKER` environment variable for your
node.  You should use the same value as `SECONDARY_MONIKER` from above.

```sh
      - AKASH_MONIKER=dgbfr0rugcxnyuu
```

2) Use the file you just edited with the [deploy instructions](/guides/deploy) to deploy your node.

3) As with [before](#challenge-2-week-2), obtain the endpoint for your node's RPC endpoint

```sh
akash provider lease-status \
  --dseq $DSEQ \
  --gseq $GSEQ \
  --oseq $OSEQ \
  --provider $PROVIDER \
  --owner $ACCOUNT_ADDRESS \
  --node $AKASH_NODE \
  | jq -r '.["forwarded-ports"].akash[] | select(.port==26657)'
```

The above command will produce:

```json
{
  "host": "ext.provider1.akashdev.net",
  "port": 26657,
  "externalPort": 32747,
  "proto": "TCP",
  "available": 1,
  "name": "akash"
}
```

{% hint style="notice" %}
If the `"host"` field is not present in the command above,
please use the following to look up the host:

```sh
akash provider lease-status \
  --dseq $DSEQ \
  --gseq $GSEQ \
  --oseq $OSEQ \
  --provider $PROVIDER \
  --owner $ACCOUNT_ADDRESS \
  --node $AKASH_NODE \
  | jq -r '.services.akash.uris[0]'
```
{% endhint %}

With this information we can construct the RPC endpoint:

```sh
DEPLOY_NODE_RPC=http://ext.provider1.akashdev.net:32747
```

And query its state:

```sh
akash --node "$DEPLOY_NODE_RPC" status
```

When your node first starts, it will attempt to sync with the network by "catching up".  You can see this in the
status:

```sh
akash --node $DEPLOY_NODE_RPC status | jq '.sync_info.latest_block_height,.sync_info.latest_block_time,.sync_info.catching_up'
"38630"
"2020-12-09T13:33:02.741252071Z"
true
```

When the last line of the above command returns `false`, your node is caught up.

Wait for your node to catch up.  **This may take some time**.  Your node is using the new [state-sync](https://docs.tendermint.com/master/tendermint-core/state-sync.html) feature of tendermint, but the peer-to-peer protocol can run into problems
which makes this take longer than we'd like.

[Check your logs](/guides/deploy#view-your-logs) to see how things are going during the process.

{% hint %}
If your node does not "catch up" in a reasonable amount of time, you may still continue
on to the next part of the challenge.
{% endhint %}

### Create Your Provider

If you've made it this far, let's put our node to work: let's turn it into a _validator_.  We will be
creating this validator on the secondary network, `akash-edgenet-2`.

1) Create a new key for this network by following the [wallet guide](/guides/wallet/README.md) and using `$SECONDARY_KEY_NAME`
as a key name.

2) Fund your new address (`$SECONDARY_ACCOUNT`) with the faucet [here](https://akash.vitwit.com/faucet).

3) Your deployed node has an endpoint from which you can download your validator public key.  Use the following
command to get the hostname for your node:

```sh
akash provider lease-status \
  --dseq $DSEQ \
  --gseq $GSEQ \
  --oseq $OSEQ \
  --provider $PROVIDER \
  --owner $ACCOUNT_ADDRESS \
  --node $AKASH_NODE \
  | jq -r '.services.akash.uris[0]'
```

For these instructions, we'll use the value below:

```sh
NODE_ENDPOINT=6veev7chcfmnclgqklegcc.provider4.akashdev.net
```

You can obtain your validator public key with the following:

```sh
curl -s "$NODE_ENDPOINT/validator-pubkey.txt"
```

We'll save it in a variable to be used later:

```sh
VALIDATOR_PUBKEY="$(curl -s "$NODE_ENDPOINT/validator-pubkey.txt")"
```

Finally, let's create the validator.  See the [validator guide](/guides/node/validator.md) for a more
in-depth discussion.

```sh
akash tx staking create-validator \
  --node="$SECONDARY_NODE" \
  --amount=1000000uakt \
  --pubkey="$VALIDATOR_PUBKEY" \
  --moniker="$SECONDARY_MONIKER" \
  --chain-id="$SECONDARY_CHAIN_ID" \
  --commission-rate="0.10" \
  --commission-max-rate="0.20" \
  --commission-max-change-rate="0.01" \
  --min-self-delegation="1" \
  --gas-prices="0.025uakt" \
  --from="$SECONDARY_KEY_NAME"
```

Once that is done, you can see the status of your validator with:

```sh
SECONDARY_VALOPER_ADDRESS="$(akash keys show "$SECONDARY_KEY_NAME" --bech=val -a)"
akash --node "$SECONDARY_NODE" query staking validator "$SECONDARY_VALOPER_ADDRESS"
```

Once your validator is created, you have finished today's challenge and can [submit](#submission) your
participation.

**Note**: Once you have [submitted](#submission) your participation and your validator has signed
a few blocks, please close your deployment.

{% endcomment %}

### Submission

**Scoring Starts**: Dec 9, 2020 9:00 AM PT 

**Scoring End**: Dec 12, 2020 5:00 PM PT

**Instructions**:

1) Fork the [ecosystem repository](https://github.com/ovrclk/ecosystem).

2) Clone the ecosystem repository to your workstation. For example, where `<user>` is your GitHub username:
  
  ```shell
  git clone https://github.com/<user>/ecosystem.git
  ```

3) Submit the JSON for your lease as the proof with the **Participation ID** from [Testnet](https://app.akash.network) as the filename under `akashian/phase3/challenge6` directory.

For example, if your code is `dgbfr0rugcxnyuu`, the file will be `akashian/phase3/challenge6/dgbfr0rugcxnyuu.json`.

Popuate `$CODE` with your **Participation ID** from [Testnet](https://app.akash.network) and run the below:

```sh
akash query market lease get \
  --dseq $DSEQ \
  --gseq $GSEQ \
  --oseq $OSEQ \
  --provider $PROVIDER \
  --owner $ACCOUNT_ADDRESS \
  --node $AKASH_NODE -o json \
  > akashian/phase3/challenge6/$CODE.json
```

See https://github.com/ovrclk/ecosystem/tree/master/akashian/phase3/challenge1/dgbfr0rugcxnyuu.json for example.
