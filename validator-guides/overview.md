# Validators Overview

The Akash Blockchain based on [Tendermint](https://docs.tendermint.com/master/introduction/what-is-tendermint.html) relies on a set of [validators](https://hub.cosmos.network/master/validators/validator-faq.html) to secure the network. The validators' role is to run a full-node and participate in consensus by broadcasting votes that contain cryptographic signatures signed by their private key. Validators commit new blocks in the blockchain and receive revenue in exchange for their work. They must also participate in governance by voting on proposals. Validators are weighted according to their total stake.

Validators running Akash Full nodes on the Mainnet are visible on Block Explorers and Wallets:

* [Big Dipper](https://akash.bigdipper.live/validators)
* [Aneka](https://akash.aneka.io/validators)
* [Lunie](https://app.lunie.io/akash/validators)

## Set up a Website

Set up a dedicated validator's website and signal your intention to become a validator on our [forum](https://forum.akash.network). This is important since delegators will want to have information about the entity they are delegating their AKT to.

## Hardware Requirements

There currently exists no appropriate cloud solution for validator key management. This may change in the future when cloud SGX becomes more widely available. For this reason, validators must set up a physical operation secured with restricted access. A right starting place, for example, would be co-locating in secure data centers.

Validators should expect to equip their datacenter location with redundant power, connectivity, and storage backups. Expect to have redundant networking boxes for fiber, firewall, and switching and then small servers with redundant hard drive and failover. Hardware can be on the low end of datacenter gear to start out with.

We anticipate that network requirements will be low initially. The current testnet requires minimal resources. Then bandwidth, CPU, and memory requirements will rise as the network grows. Large hard drives are recommended for storing years of blockchain history.

## Software Requirements

In addition to running a Akash node, validators should develop monitoring, alerting and management solutions.

## Bandwidth Requirements

The Akash Blockchain has the capacity for very high throughput relative to chains like Ethereum or Bitcoin.

We recommend that the data center nodes only connect to trusted full-nodes in the cloud or other validators that know each other socially. This relieves the data center node from the burden of mitigating denial-of-service attacks.

Ultimately, as the network becomes more heavily used, multi-gigabyte per day bandwidth is very realistic.

## Key Management

Validators should expect to run an HSM that supports ed25519 keys. Here are potential options:

* YubiHSM 2
* Ledger Nano S
* Ledger BOLOS SGX enclave
* Thales nShield support

The Akash team does not recommend one solution above the other. The community is encouraged to bolster the effort to improve HSMs and the security of key management.

## Operational Requirements

Running effective operation is the key to avoiding unexpectedly unbonding or being slashed. This includes being able to respond to attacks, outages, as well as to maintain security and isolation in your data center.

Validators should expect to perform regular software updates to accommodate upgrades and bug fixes. There will inevitably be issues with the network early in its bootstrapping phase that will require substantial vigilance.

## Protecting Against Denial-of-Service Attacks

Denial-of-service attacks occur when an attacker sends a flood of internet traffic to an IP address to prevent the server at the IP address from connecting to the internet.

An attacker scans the network, tries to learn the IP address of various validator nodes and disconnect them from communication by flooding them with traffic.

One recommended way to mitigate these risks is for validators to carefully structure their network topology in a so-called sentry node architecture.

Validator nodes should only connect to full-nodes they trust because they operate them themselves or are run by other validators they know socially. A validator node will typically run in a data center. Most data centers provide direct links the networks of major cloud providers. The validator can use those links to connect to sentry nodes in the cloud. This shifts the burden of denial-of-service from the validator's node directly to its sentry nodes, and may require new sentry nodes be spun up or activated to mitigate attacks on existing ones.

Sentry nodes can be quickly spun up or change their IP addresses. Because the links to the sentry nodes are in private IP space, an internet based attacked cannot disturb them directly. This will ensure validator block proposals and votes always make it to the rest of the network.

It is expected that good operating procedures on that part of validators will completely mitigate these threats.

For more on sentry node architecture, see [this](https://forum.cosmos.network/t/sentry-node-architecture-overview/454).

