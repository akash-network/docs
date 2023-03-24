---
description: >-
  Akash means “open space” or “sky” in ancient Sanskrit. The sky is where the
  clouds meet.
---

# Intro to Akash

Akash is an open network that lets users buy and sell computing resources securely and efficiently. Purpose-built for public utility.

## Common Questions

### How to use Akash?

You can get started right from the [**command-line**](https://docs.akash.network/guides/cli) or use the [**web app**](guides/deploy/)\*\*\*\*

* Define your Docker image, CPU, Memory, and Storage in a [**deploy.yaml**](readme/stack-definition-language.md) file.
* Set your price, receive bids from providers in seconds, and select the lowest price.
* Deploy your application without having to set up, configure, or manage servers.
* Scale your application from a single container to hundreds of deployments.

### What is the Akash Deployment Marketplace?

The [**Akash Marketplace**](other-resources/marketplace.md) is where users lease computing resources from Cloud providers before deploying a Docker container on the Akash Container Platform. The marketplace stores on-chain records of requests, bids, leases, and settlement payments using the Akash Token (AKT). Akash's blockchain is a [**Tendermint**](https://github.com/tendermint/tendermint) based application based on the [**Cosmos SDK**](https://github.com/cosmos/cosmos-sdk).

### What is the Akash Container Platform?

The [**Akash Container Platform**](other-resources/platform.md) is a deployment platform for hosting and managing [**containers**](other-resources/platform.md#containers) where users can run _**any**_ Cloud-Native application. Akash is built with a set of cloud management services including [**Kubernetes**](https://kubernetes.io) to orchestrate and manage containers.

### What is the cost to use Akash?

The cost of hosting your application using Akash is about one-third the cost of Amazon AWS, Google Cloud Platform (GCP), and Microsoft Azure. You can check the prices live using the [**Cloudmos.io price comparison tool**](https://cloudmos.io/price-compare).

### How do I use Akash?

If you're new to Akash, start with our [**deployment guides**](guides/) and go from there. Akash's community has written several more advanced guides for learning about Akash: a [**node operator guide**](akash-nodes/), a [**validator guide**](validating/validator.md), a [**cloud provider guide**](broken-reference), and several [**deployment guides**](guides/) for running various apps on Akash.

### Why is Akash different than other Cloud platforms?

The decentralized cloud is a shift from computing resources being owned and operated by the three large Cloud companies (Amazon, Google, and Microsoft) to a decentralized network of Cloud providers running **open source** **software** developed by a community and creating competition in an **open** **marketplace** with more providers.

Like Airbnb for server hosting, Akash is a marketplace that gives you control over the price you pay and the amenities included (we call them attributes). Akash gives app developers a command-line tool for leasing and deploying apps right from a terminal. Akash taps into the massive market of underutilized resources sitting idle in the estimated 8.4 million data centers globally. Any cloud-native and containerized applications running on the centralized cloud can run faster and at a lower cost on the Akash decentralized cloud.

### Why is Akash different than other decentralized platforms?

Akash hosts [**containers**](other-resources/platform.md) where users can run _**any**_ Cloud-Native application. There is no need to re-write the entire internet in a new proprietary language, and there is no vendor lock-in to prevent you from switching Cloud providers. The deployment file is transferred over a private peer-to-peer network isolated from the blockchain. Asset transfer occurs off-chain over mTLS to provide the security and performance required by mission-critical applications running on the Cloud.

### What is the Stack Definition Language (SDL)?

You can define the deployment services, datacenters, requirements, and pricing parameters, in a "manifest" file (deploy.yaml). The file is written in a declarative language called [**Stack Definition Language (SDL)**](readme/stack-definition-language.md). SDL is a human friendly data standard for declaring deployment attributes. The SDL file is a "form" to request resources from the Network. SDL is compatible with the YAML standard and similar to Docker Compose files.

### How do I configure Networking for my container?

Networking - allowing connectivity to and between workloads - can be configured via the Stack Definition Language ([**SDL**](readme/stack-definition-language.md)) file for a deployment. By default, workloads in a deployment group are isolated - nothing else is allowed to connect to them. This restriction can be relaxed.

**Do I need to close and re-create my deployment if I want to update the deployment?**

No. You can update your deployment. However, only some fields in the Akash stack definition file are mutable. The **image**, **command**, **args**, **env** and **exposed ports** can be modified, but compute resources and placement criteria cannot.
