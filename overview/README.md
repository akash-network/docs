# Akash Intro

## Overview

The Akash Network is a secure, transparent, and decentralized cloud computing marketplace that connects those who need computing resources \(tenants\) with those that have computing capacity to lease \(providers\).

Akash acts as a _super cloud_ platform - providing a unified layer above all providers on the marketplace so as to present clients with a single cloud platform, regardless of which particular provider they may be using.

Clients use Akash because of its cost advantage, usability, and flexibility to move between cloud providers, and the performance benefits of global deployments. Providers use Akash because it allows them to earn revenue from either dedicated or temporarily-unused capacity.

The foundational design objective of the Akash Network is to maintain a low barrier to entry for providers while at the same time ensuring that clients can trust the resources that the platform offers them. To achieve this, the system requires a publicly-verifiable record of transactions within the network. To that end, the Akash Network is implemented using blockchain technologies as a means of achieving consensus on the veracity of a distributed database.

Akash is, first and foremost, a platform that allows clients to procure resources from providers. This is enabled by a blockchain-powered distributed exchange where clients post their desired resources for providers to bid on. The currency of this marketplace is a digital token, the [AKT](http://akash.network/l/econ-paper), whose ledger is stored on a blockchain.

Akash is a cloud platform for real-world applications. The requirements of such applications include:

* Many workloads deployed across any number of datacenters.
* Connectivity restrictions which prevent unwanted access to workloads.
* Self-managed so that operators do not need to constantly tend to deployments.

To support running workloads on procured resources, Akash includes a peer-to-peer protocol for distributing workloads and deployment configuration to and between a client's providers.

Workloads in Akash are defined as Docker containers. Docker containers allow for highly-isolated and configurable execution environments, and are already part of many cloud-based deployments today.

![Illustration of on-chain and off-chain interactions amongst various participants in the Akash network](../.gitbook/assets/overview%20%282%29.svg)

### Actors

* Tenant: _tenant_ hosting an application on the Akash network.
* Provider: Each _provider_ will host an agent which is a mediator between the Akash Network and the datacenter-local infrastructure. The datacenter agent is responsible for:
  * Bidding on orders fulfillable by the datacenter.
  * Managing the provided active leases.
* Validator: An Akash node that is elected to be a _validator_ in the _DPoS_ consensus scheme.

## Akash Market

### Protocol

1. Tenants define desired infrastructure, workloads to run on infrastructure and how workloads can connect to one another. Desired lifetime of resources is expressed via collateral requirements.
2. Orders are generated from the tenant's definition.
3. Datacenters bid on open orders.
4. The bid with lowest price gets matched with order to create a lease.
5. Once a lease is reached, workloads and topology are delivered to datacenter.
6. Datacenter deploys workloads and allows connectivity as specified by the tenant.
7. If a datacenter fails to maintain a lease, collateral is transferred to the tenant and a new order is created for the desired resources.
8. A tenant can close any active deployment at any time

![Summary of procurement from Marketplace. \(1\) User&apos;s deployment order is posted to the orderbook \(2\) Datacenters posts eligible fulfillment orders for the deployment order \(3\) The best fulfillment order is matched with the deployment order, creating a new lease. ](../.gitbook/assets/marketplace.svg)

Infrastructure procurement --- the process through which clients lease infrastructure from providers --- on Akash it is implemented through a decentralized exchange \(_marketplace_\).

The marketplace consists of a public order book and a matching algorithm. Clients place _deployment_ orders, which contain a specification of the client's service needs, and datacenters place _fulfillment_ orders to bid on deployment orders. Deployment orders include the maximum amount the client is willing to pay for a fixed number of computing units \(as measured by memory, cpu, storage, and bandwidth\) for a specific amount of time; fulfillment orders declare the price that the provider will provide the resources for.

Deployment orders are _open_ for a client-defined length of time, as measured to the second. While the deployment order is open, providers may post fulfillment orders to bid on it.

A fulfilment order is eligible to match with a deployment order if the fulfillment order satisfies all minimum specifications of the deployment order. Given a deployment order and a set of eligible fulfilment orders, the fulfilment order offering the lowest price will be matched with the deployment order. If multiple fulfilment orders are eligible for a match and offer the same price, the fulfilment order placed first will be matched with the deployment order.

Businesses and individual consumers will want and need to protect how they are publicly displaying their use of compute power. To guard against competitor data mining and other attack vectors, a homomorphic encryption layer is added.

A _lease_ is created when a match occurs between a deployment and fulfillment order. The lease contains references to the deployment and fulfilment orders. Leases will be the binding agent in fulfilling a deployment.

## DCS: Decentralized Cloud Standards 

Visit [DCS](https://dcs.akash.network) to learn about Akash system design. Decentralized Cloud Standards (DCSs) describe standards for the Akash Decentralized Cloud platform, including core protocol specifications, client APIs, and SDL standards. 

## AKT: The Akash Network Token

The primary functions of AKT are in staking \(which provides security to the network\) and in acting as a unit of measure for pricing all currencies supported by the marketplace. AKT is expected to have very low liquidity because of the high earning potential of staking rewards. Although AKT can be used for settling transactions in the marketplace, it is not intended to be used to pay a fee or to be used as a currency, because of its highly illiquid nature. However, transaction fees and block rewards are denominated in AKT. The income stakers earn is proportional to the tokens staked and length of staking commitment. That said, AKT performs three main functions: Resolve, Reward, and Reserve.

### Resolve

Akash relies on a blockchain where a set of validators vote on proposals. Each proposal is weighed by the proposer’s voting power, which is the total tokens they staked and the tokens bonded to them \(stakers can delegate voting power to validators\).

### Reward

Providers on Akash stake tokens to subsidize operating and capital expenditures. Stakers are rewarded proportional to the number of tokens staked, the length of lockup time, and the overall tokens staked in the system. Lock up times can vary anywhere from one month to one year. Flexibility in lockup encourages stakers that stake for shorter periods \(bear markets\), in a self-adjusting inflationary system that is designed to optimize for lower price pressure during bear markets.

### Reserve

Fees on Akash can be settled using a multitude of currencies, however, the market order book uses Akash Token \(_AKT_\) as the reserve currency of the ecosystem. AKT provides a novel settlement option to lock in an exchange rate between AKT and the settlement currency. This way, providers and tenants are protected from the price volatility of AKT expected to result from its low liquidity. In this section, we also present a mechanism “Transaction Ordering using Consensus Weighted Median” to establish exchange rates without the need for an oracle.
