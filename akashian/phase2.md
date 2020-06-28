### **Week 1: Capture the Orders**

The Akashian Challenge team will be creating orders continuously. This challenge asks users to explore how to operate as a provider by finding and bidding on leases. This can be accomplished by running the [provider daemon](https://github.com/ovrclk/akash/tree/master/provider), using `akashctl` and some `bash` scripting, or by building custom tooling. Contestants will be rewarded points during Week 1 for the following items:

- Teams whose `Providers` have won the most number of `Orders`, then converted to `Leases`, put out by the Akash team
- Teams whose `Providers` have placed the most number of `Bids` on `Orders`.
- Bonus Category: Blog post detailing how winning provider bids works in the Akash system and some custom code to do so.
- Bonus Category: Documentation or blog post detailing how the provider daemon works and how to operate it.

### Creation of Provider

In order to participate in the Akash network as a Provider of compute users will need to register with the network and point to where their services are running (`host`) as well as providing additional metadata (`attributes`). This metadata can be things like the region or area the computers are running in as well as additional information about what that Provider is actually providing. To start creating your provider on the testnet, create a `provider.yaml` file that contains at least the fields below:

```yaml
host: http://localhost:8080
attributes:
  - key: challenge
    value: phase2
  - key: team-name
    value: your-team-name-here
```

Next you need to send this SDL file via a `akashctl tx provider create` command to the network. The key you sign and send this message with will be the key that you will need to use for all provider operations including capturing bids, so make sure this key has sufficent funds. The exact command looks like the following:

> NOTE: Ensure that you have configured your node to talk to a valid RPC endpoint using `akashctl config node`

```bash
$ akashctl tx provider create "provider.yaml" --from mykey
```

You can check to ensure your provider has been created successfully by running the following query:

```bash
$ akashctl q provider get $(akashctl keys show mykey -a)
```

### Looking for Orders to Bid on

During the competition the Akash team will be submitting `Deployments` periodically. Those deployment requests will create `Orders` on the chain. They will be originating from the following addresses:

```
akash1n76p2ata9ek5gphs2lj9v9z64xlrx0sgqr72yw
akash1ejhr8hqndl5jwmvjttepr4yh39vttnmzex0sjk
akash1kd5vw9vwa4zqcehzz6qxkg8m0kh5l850ksek8s
akash1xg806jz0ex69nnue36jaq4lyvp43yx60cm2chc
akash18rnq7f3z7dxx2p5x5mvfml7c8rm726e5u659gc
akash1qtryq2gk7mgj3zl0nn9mffrt3zzhzmf26lepuu
akash19a7urn4lpftrlc4a5qadfmdu0erntsaga2kwaz
akash1uaamq2yk53y0pkykp9h8dq2u3sa2y5g5ec8242
akash1dmd577v86eggwmfj0g2plxewphgv3ccm9vgg08
akash1c76e7z8l0uaa77kcrvnhnn24h8n0vvytgugkkj
akash1fd7sc4h3z6nw8rkx3mhtvswazdg0gqjuu944vp
```

You can query for outstanding orders in the DEX using the following CLI command:

```bash
$ akashctl query market order list --state open
```


The `id` field in the `Order` object returned above contains the information necessary to query the individual order. You can query the individual order as follows:

```bash
$ akashctl query market order get \
    --owner {id.owner} \
    --dseq {id.dseq} \
    --gseq {id.gseq} \
    --oseq {id.oseq}
```

The state of the order is encoded as an integer in the `state` field of this return. The following is a mapping from that `order-state` to what that state singifies:

```
// This order is open to recieve bids
OrderOpen    = 1

// This order has been matched by the DEX
OrderMatched = 2

// This order has been closed by the user who submitted the deployment
OrderClosed  = 3
```

### Placing Bids on an Order

Once you have identified an `Order` from one of the Akash addresses above then you should submit a bid on that order. To bid on an order use the following command:

```bash
$ akashctl tx market bid-create \
    --owner {id.owner} \
    --dseq {id.dseq} \
    --gseq {id.gseq} \
    --oseq {id.oseq} \
    --price 10akash \
    --from mykey
```

The bids will be matched with orders by the on chain dex. If you want to see your bids status you can query it as follows:

```bash
$ akashctl query market bid get \
    --owner {id.owner} \
    --dseq {id.dseq} \
    --gseq {id.gseq} \
    --oseq {id.oseq} \
    --provider $(akashctl keys show mykey -a)
```

The state of the bid is encoded as an integer in the `state` field of this return. The following is a mapping from that `bid-state` what that state signifies:

```
// The bid is open an has not been won by any providers yet
BidOpen    = 1

// The bid has won the order for you provider
BidMatched = 2 

// Your bid lost the order for your provider
BidLost    = 3

// The bid was closed by the provider
BidClosed  = 4
```

### Running and configuring the provider services 

There is also a piece of infrastructure provided by the `Akash` team that will automate the process of bidding for your provider. This is called the Provider Services daemon. The Provider Services daemon listens via websocket on the tendermint RPC port for events coming from the chain. Any new orders that it hears will be automatically bid on. The easiest way to participate in Phase 2 is to run a properly configured provider daemon. Users are encoraged to make modifications to their provider daemon code in order to gain an advantage over other teams using this strategy. To run the provider daemon requires the following command:

> NOTE: Ensure that you run this command with the same key you created the provider with, in addition ensure that the `akashctl config` has a reachable `node` configured.

```
$ akashctl provider run --from mykey
```
