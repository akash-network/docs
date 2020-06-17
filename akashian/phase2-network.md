# Akashian Phase 2 Network Configuration

The network for phase 2 of the akashian challenge will not be a decentralized launch and validator set like phase 1. After having proven the ability of the validator set to launch and maintain the network in a decentralized fashion in Phase 1, we are moving on to testing the actual funcationality of the network in phases 2 and 3. This configuration will make it possible for the Akash team to ship bug fixes and features to the network w/o having to require all network participants to upgrade independently. This should make for a smoother testnet where participants can focus on learning and testing the core functionality of the akash network. With that in mind the network topology for phase two is as follows:

### Network Topology

#### Validators

The akash network development team will be running the validator set in a VPC that is not connected to the open internet. Users will be able to access the validator set through the sentry nodes. 

#### Sentries

The akash team will be running a number of sentries. These sentries will be available at the following addresses for p2p communication:

> NOTE: If you would like to run a full and connect to the network via p2p please follow [this guide](./join-the-testnet.md).

```bash
"persistent_peers" = `
    {node-id}@{sentry1}:26656,
    {node-id}@{sentry1}:26656,
    {node-id}@{sentry1}:26656
`
```

If you would just like to use the provided RPC endpoints to send transactions and query the network the following endpoints will be maintained throughout Phase 2:

```
tcp://sentry1.akash.whatever:26657
tcp://sentry2.akash.whatever:26657
tcp://sentry3.akash.whatever:26657
```

You can use one of the above addresses to configure your `akashctl` to use it: `akashctl config node {{node-addr}}`

#### Seeds

The akash team will be maintaining a number of sentry nodes to facilitate p2p network connections. These instances are [`tenderseed`](https://gitlab.com/polychainlabs/tenderseed/) instances. They are available at the following addresses:

```bash
"seeds" = `
    {node-id}@{sentry1}:26656,
    {node-id}@{sentry1}:26656,
    {node-id}@{sentry1}:26656
`
```

#### Faucet

The Akash team is also maintaining a faucet that will enable users who weren't in the genesis file to join the testnet. That faucet is available at `faucet.akash.whatever` and has instructions for usage there. 