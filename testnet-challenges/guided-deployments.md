# Guided Deployments

In Week 1, challenges will focus on deploying stand-alone applications, from website deployments to single-node blockchain networks.

**Qualification Criteria**:

Although we do not limit anyone from participating, to claim AKT rewards:

* You must not be a resident of any of the OFAC sanctioned countries.
* You must pass KYC/AML verification when collecting the reward. The details for which will be posted at a later time.

{% hint %}
Each of these challenges will ask you to follow the [deployment guide](/guides/deploy) to deploy a specific [SDL](/sdl) file.
{% endhint %}

* [Challenge 1 (Week 1)](#challenge-1-week-1)
* [Challenge 2 (Week 1)](#challenge-2-week-1)
* [Challenge 3 (Week 1)](#challenge-3-week-1)
* [Challenge 1 (Week 2)](#challenge-1-week-2)
* [Challenge 2 (Week 2)](#challenge-2-week-2)

## Challenge 1 (Week 1)

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

The [SDL](/sdl) file that is included in this challenge describes how the new node should be deployed,
and you will create this deployment **on the `edgenet` network**.

**YOU DO NOT NEED TO CREATE A NODE FOR, OR INTERACT WITH, THE [SEPARATE NETWORK](https://github.com/ovrclk/net/tree/master/definet) BEYOND WHAT IS DESCRIBED BELOW** 

{% endhint %}

**Reward**: 200 AKTs

**Winners**: First 200 submissions — measured by the timestamp of the git commit — that pass the qualification criteria. 

**Instructions**:

Instructions will be revealed when the challenge starts.

{% comment %}
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
  | jq '.["forwarded-ports"].akash[] | select(.port==26657)'
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

If you run into problems, [check your logs](/guides/deploy#view-your-logs) to see if you can remedy the problem.

To complete this challenge, we will send a transaction *to your new node*.

1) Follow the steps for using the faucet in [Funding your Account](/guides/wallet/funding.md).  The faucet is currently
configured to send your address tokens **on both networks**.

2) Send 1 AKT to the following address **through the node you created in this challenge**: `akash1vl3gun7p8y4ttzajrtyevdy5sa2tjz3a29zuah`.  Include your **Participation ID** (`$CODE`) from [Testnet](https://app.akash.network) in the memo field of the transaction:

```sh
akash \
  --node "$TESTNET_NODE" \
  --chain-id edgenet-2 \
  --keyring-backend "$KEYRING_BACKEND" \
  --memo "$CODE" \
  tx send "$KEY_NAME" akash1vl3gun7p8y4ttzajrtyevdy5sa2tjz3a29zuah 1000000uakt
```

Once your transaction is complete, you have finished today's challenge and can [submit](#submission) your
participation.

**Note**: Once you have [submitted](#submission) your participation, you should close your lease.

{% endcomment %}

### Submission

**Scoring Starts**: Dec 8, 2020 9:00 AM PT 

**Scoring End**: Dec 11, 2020 5:00 PM PT

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
