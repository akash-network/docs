---
description: Akash means "open space" or "sky" in ancient Sanskrit.
---

# What is Akash?

## The Akash Mission

Akash is an [**open source** ](https://github.com/ovrclk/akash)Cloud platform that lets you quickly deploy a Docker container to the Cloud provider of your choice for less than the cost of AWS, right from the [**command-line**](https://docs.akash.network/guides/cli).

* Define your Docker image, CPU, Memory, and Storage in a **deploy.yaml** file.
* Set your price, receive bids from providers in seconds, and select the lowest price.
* Deploy your application without having to set up, configure, or manage servers.
* Scale your application from a single container to hundreds of deployments.

### What is the Akash Deployment Marketplace?

The [Akash Marketplace](glossary/marketplace.md) is where users lease computing resources from Cloud providers before deploying a Docker container on the Akash Container Platform. The marketplace stores on-chain records of requests, bids, leases, and settlement payments using the Akash Token (AKT). Akash's blockchain is a [tendermint](https://github.com/tendermint/tendermint)-based application based on the [Cosmos SDK](https://github.com/cosmos/cosmos-sdk).

### What is the Akash Container Platform?

The [Akash Container Platform](glossary/platform.md) is a deployment platform for hosting and managing [containers](glossary/platform.md#containers) where users can run _**any**_ Cloud-Native application. Akash is built with a set of cloud management services including [Kubernetes](https://kubernetes.io) to orchestrate and manage containers.

### What is the cost to use Akash?

The cost of hosting your application using Akash is about one-third the cost of Amazon AWS, Google Cloud Platform (GCP), and Microsoft Azure. You can check the prices live using the [Akashlytics.com price comparison tool](https://akashlytics.com/price-compare).

### Why is Akash cheaper than Amazon?

We are seeding the market with top-tier data center providers and negotiating lower than market rates with data centers to lease their underutilized server resources. Most data centers have unused capacity sitting idle. Akash's software helps the data centers lease out their compute resources for Docker containers.

### How do I use Akash?

If you're new to Akash, start with the [**Getting Started guide**](cli/install.md) and go from there. Akash's community has written several more advanced guides for learning about Akash: a [node operator guide](broken-reference), a [validator guide](operations/validator.md), a [cloud provider guide](providers/build-a-cloud-provider/), and several [deployment guides](deployments/) for running various apps on Akash.

### Why is Akash different than other Cloud platforms?

The decentralized cloud is a shift from computing resources being owned and operated by the three large Cloud companies (Amazon, Google, and Microsoft) to a decentralized network of Cloud providers running **open source** **software** developed by a community and creating competition in an **open** **marketplace** with more providers.

Like Airbnb for server hosting, Akash is a marketplace that gives you control over the price you pay and the amenities included (we call them attributes). Akash gives app developers a command-line tool for leasing and deploying apps right from a terminal. Akash taps into the massive market of underutilized resources sitting idle in the estimated 8.4 million data centers globally. Any cloud-native and containerized applications running on the centralized cloud can run faster and at a lower cost on the Akash decentralized cloud.

### Why is Akash different than other decentralized platforms?

Akash hosts [containers](<README (1).md#what-is-a-container>) where users can run _**any**_ Cloud-Native application. There is no need to re-write the entire internet in a new proprietary language, and there is no vendor lock-in to prevent you from switching Cloud providers. The deployment file is transferred over a private peer-to-peer network isolated from the blockchain. Asset transfer occurs off-chain over mTLS to provide the security and performance required by mission-critical applications running on the Cloud.

### What is the Stack Definition Language (SDL)?

You can define the deployment services, datacenters, requirements, and pricing parameters, in a "manifest" file (deploy.yaml). The file is written in a declarative language called [Software Definition Language (SDL)](stack-definition-language.md). SDL is a human friendly data standard for declaring deployment attributes. The SDL file is a "form" to request resources from the Network. SDL is compatible with the YAML standard and similar to Docker Compose files.

#### How do I configure Networking for my container?

Networking - allowing connectivity to and between workloads - can be configured via the Stack Definition Language ([SDL](stack-definition-language.md)) file for a deployment. By default, workloads in a deployment group are isolated - nothing else is allowed to connect to them. This restriction can be relaxed.

**Do I need to close and re-create my deployment if I want to update the deployment?**

No. You can update your deployment. However, only some fields in the Akash stack definition file are mutable. The **image**, **command**, **args**, **env** and **exposed ports** can be modified, but compute resources and placement criteria cannot.

## Is there an Akash Testnet?

Yes, but currently it does not have providers. We encourage developers to use Mainnet and provide tokens to do that. To request tokens, please follow the [Activation Funding](token/funding.md#activation-funding) guide.
