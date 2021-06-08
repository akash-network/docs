---
description: >-
  Welcome to the support documentation and user guides for Akash, the
  decentralized cloud platform.
---

# Akash Overview

### What is Akash?

Akash -- "open space, sky" in ancient Sanskrit -- is the world’s first distributed peer-to-peer open cloud computing marketplace; our goal is to build an open source permissionless cloud as boundless as the sky.

### What makes Akash different?

Akash provides a serverless platform that hosts containers where users can run _**any**_ application currently running on the cloud. The deployment is off-chain and performed over a private peer-to-peer network isolated from the blockchain, and asset transfer occurs off-chain to protect and performance that we need for a mission critical application running on the Cloud. Unlike centralized providers, in Akash, _the users (tenants) sets the price and the terms, the provider bids for their workloads_. 

### Why use a blockchain?

Akash leverages blockchain for provisioning and settlement but deployment happens off-chain. This limits Akash’s users from running verifiable smart contracts as the scalability envelope is not designed for on-chain execution.

### Decentralized Cloud

The [Akash](https://github.com/ovrclk/akash) Decentralized Cloud \(DeCloud\) is comprised of two main components, the network, and the cloud platform.

The **Akash Marketplace** is an reverse auction for compute resources. It is the mechanism by which users acquire resources on the Akash Platform. The Akash marketplace is an on-chain decentralized [marketplace](decentralized-cloud/marketplace.md) for leasing computing resources. The marketplace is built with [cosmos-sdk](https://github.com/cosmos/cosmos-sdk) - it is a [tendermint](https://github.com/tendermint/tendermint)-based blockchain application.

The **Akash Platform** is an off-chain deployment platform used for hosting and managing workloads. The platform is built with a set of cloud management services including  [Kubernetes](https://kubernetes.io) to run workloads.

The **Akash** **Application** contains everything needed to run the Network, the Platform, and the [command-line interface](reference/general-commands.md) and is distributed in the [Akash open source GitHub repository](https://github.com/ovrclk/akash). The Akash Marketplace is an auction for compute resources. It is the mechanism by which users acquire resources on the Akash Platform.

### Containers

A  **container** is a standard unit of software that packages up code and all its dependencies so the application runs quickly and reliably from one computing environment to another. A  **container** **image** is a lightweight, standalone, executable package of software that includes everything needed to run an application: code, runtime, system tools, system libraries and settings.

**Container images** become **containers** at runtime. Available for both Linux and Windows-based applications, containerized software will always run the same, regardless of the infrastructure. Containers isolate software from its environment and ensure that it works uniformly despite differences for instance between development and staging.

### Stack Definition Language \(SDL\) 

Customers / tenants define the deployment services, datacenters, requirements, and pricing parameters, in a "manifest" file \(deploy.yml\). The file is written in a declarative language called [Software Definition Language \(SDL\)](reference/sdl.md). SDL is a human friendly data  standard for declaring deployment attributes.  The SDL file is a "form" to request resources from the Network. SDL is compatible with the YAML standard and similar to Docker Compose files.

#### Networking

Networking - allowing connectivity to and between workloads - can be configured via the Stack Definition Language \([SDL](reference/sdl.md)\) file for a deployment. By default, workloads in a deployment group are isolated - nothing else is allowed to connect to them. This restriction can be relaxed.

## Certificates

It is important for the tenant to send their manifest to the correct provider, and for the provider to ensure only valid owners can access their deployments. This authentication is implemented with [mTLS](decentralized-cloud/mtls.md) and involves each account creating a certificate prior to deploying a workload or starting a provider.

Default certificate lifespan is 365 days from the moment of issuance. This can be customized to be valid up to a certain date, or not valid until a certain date.

