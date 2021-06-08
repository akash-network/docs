---
description: >-
  Welcome to the support documentation and user guides for Akash, the
  decentralized cloud platform.
---

# Akash Overview

### What is Akash?

Akash -- "open space, sky" in ancient Sanskrit -- is the world’s first distributed peer-to-peer open cloud computing marketplace; our goal is to build an open source permissionless cloud as boundless as the sky.

### What makes Akash different from other decentralized cloud platforms?

Akash provides a serverless platform that hosts containers where users can run _**any**_ application currently running on the cloud. The deployment is off-chain and performed over a private peer-to-peer network isolated from the blockchain, and asset transfer occurs off-chain to protect and performance that we need for a mission critical application running on the Cloud. 

### Why Blockchain?

Akash leverages blockchain for provisioning and settlement but deployment happens off-chain. This limits Akash’s users from running verifiable smart contracts as the scalability envelope is not designed for on-chain execution.

### Decentralized Cloud

The [Akash](https://github.com/ovrclk/akash) Decentralized Cloud \(DeCloud\) is comprised of two main components:

1. The **Network**: an on-chain decentralized [marketplace](decentralized-cloud/marketplace.md) for leasing computing resources.
2. The **Platform**: an off-chain deployment platform used for hosting and managing workloads.

The **Network** is built with [cosmos-sdk](https://github.com/cosmos/cosmos-sdk) - it is a [tendermint](https://github.com/tendermint/tendermint)-based blockchain application.

The **Platform** is a set of [cloud management services]() that leverage [Kubernetes](https://kubernetes.io) to run workloads.

The software to run the **Network**, the **Platform**, and the [command-line client](reference/general-commands.md) used to interact with them are all currently distributed in the `akash` application.The Akash Marketplace is an auction for compute resources. It is the mechanism by which users acquire resources on the Akash Platform.

### Containers

A  **container** is a standard unit of software that packages up code and all its dependencies so the application runs quickly and reliably from one computing environment to another. A  **container** **image** is a lightweight, standalone, executable package of software that includes everything needed to run an application: code, runtime, system tools, system libraries and settings.

**Container images** become **containers** at runtime. Available for both Linux and Windows-based applications, containerized software will always run the same, regardless of the infrastructure. Containers isolate software from its environment and ensure that it works uniformly despite differences for instance between development and staging.

### Stack Definition Language \(SDL\) 

Tenants define workloads requirements, as well as regional and pricing parameters, in a manifest file \(deploy.yml\) using a declarative language called Software Definition Language \(SDL\). Akash's SDL follows the YAML format. YAML is a human friendly data serialization standard for all programming languages. The SDL file is a "form" to request resources from the Network. SDL is similar to and inspired by the Docker Compose language. 

### Networking

Networking - allowing connectivity to and between workloads - can be configured via the [SDL](reference/sdl.md) for a deployment.

By default, workloads in a deployment group are isolated - nothing else is allowed to connect to them. This restriction can be relaxed by enabling

### Audited Attributes

Audited attributes allow users deploying applications to be more selective about which providers can run their apps. Anyone on the Akash Network can assign these attributes to Providers via an on-chain transaction.

### Escrow Accounts

[Escrow accounts](decentralized-cloud/escrow.md) are a mechanism that allow for time-based payments from one bank account to another without block-by-block micropayments. They also support holding funds for an account until an arbitrary event occurrs.

Escrow accounts are necessary in akash for two primary reasons:

1. Leases in Akash are priced in blocks - every new block, a payment from the tenant \(deployment owner\) to the provider \(lease holder\) is due. Performance and security considerations prohibit the naive approach of transferring tokens on every block.
2. Bidding on an order should not be free \(for various reasons, including performance and security\). Akash requires a deposit for every bid. The deposit is returned to the bidder when the bid is closed.

### Certificates

It is important for the tenant to send their manifest to the correct provider, and for the provider to ensure only valid owners can access their deployments. This authentication is implemented with [mTLS](decentralized-cloud/mtls.md) and involves each account creating a certificate prior to deploying a workload or starting a provider.

Default certificate lifespan is 365 days from the moment of issuance. This can be customized to be valid up to a certain date, or not valid until a certain date.

