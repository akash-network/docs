# Features and Design

## Features and Design

The [Akash](https://github.com/ovrclk/akash) DeCloud is comprised of two main components:

1. The **Network**: an on-chain decentralized [marketplace](marketplace.md) for leasing computing resources.
2. The **Platform**: an off-chain deployment platform used for hosting and managing workloads.

The **Network** is built with [cosmos-sdk](https://github.com/cosmos/cosmos-sdk) - it is a [tendermint](https://github.com/tendermint/tendermint)-based blockchain application.

The **Platform** is a set of [cloud management services](./#provider-services) that leverage [Kubernetes](https://kubernetes.io) to run workloads.

The software to run the **Network**, the **Platform**, and the command-line client used to interact with them are all currently distributed in the `akash` application.

### Workflow - Life of a Deployment

Deploying applications onto [Akash](https://github.com/ovrclk/akash) involves two types of users:

1. The **Tenant**: the entity that deploys the application.
2. The **Provider**: the entity that hosts the application.

Given that there are live providers on the network, the lifecycle of a typical application deployment is as follows:

1. The tenant describes their desired deployment in \[SDL\], called a [deployment](marketplace.md#deployment).
2. The tenant submits that definition to the blockchain.
3. Their submission generates an [order](marketplace.md#order) on the marketplace.
4. Providers that would like to fulfill that order [bid](marketplace.md#bid) on it.
5. After some period of time, a winning [bid](marketplace.md#bid) for the [order](marketplace.md#order) is chosen, and a [lease](marketplace.md#lease) is created.
6. Once a [lease](marketplace.md#lease) has been created, the tenant submits a [manifest](../documentation/sdl.md) to the provider.
7. The provider executes workloads as instructed by the [manifest](../documentation/sdl.md).
8. The workload is running - if it is a web application it can be visited, etc...
9. The provider or tenant eventually closes the [lease](marketplace.md#lease), shutting down the workload.

## Features

### Docker

Docker-based deploys

### SDL

Tenants define workloads requirements, as well as regional and pricing parameters, in a manifest file using a declarative language called SDL \(inspired by Docker Compose\). The SDL file is essentially a form to request resources from the Network.

### Networking

Networking - allowing connectivity to and between workloads - can be configured via the [SDL](../documentation/sdl.md) for a deployment.

By default, workloads in a deployment group are isolated - nothing else is allowed to connect to them. This restriction can be relaxed by enabling

### Audited Attributes

Audited attributes allow users deploying applications to be more selective about which providers can run their apps. Anyone on the Akash Network can assign these attributes to Providers via an on-chain transaction.

### Escrow Accounts

[Escrow accounts](escrow.md) are a mechanism that allow for time-based payments from one bank account to another without block-by-block micropayments. They also support holding funds for an account until an arbitrary event occurrs.

Escrow accounts are necessary in akash for two primary reasons:

1. Leases in Akash are priced in blocks - every new block, a payment from the tenant \(deployment owner\) to the provider \(lease holder\) is due. Performance and security considerations prohibit the naive approach of transferring tokens on every block.
2. Bidding on an order should not be free \(for various reasons, including performance and security\). Akash requires a deposit for every bid. The deposit is returned to the bidder when the bid is closed.

### Certificates

It is important for the tenant to send their manifest to the correct provider, and for the provider to ensure only valid owners can access their deployments. This authentication is implemented with [mTLS](mtls.md) and involves each account creating a certificate prior to deploying a workload or starting a provider.

Default certificate lifespan is 365 days from the moment of issuance. This can be customized to be valid up to a certain date, or not valid until a certain date.

