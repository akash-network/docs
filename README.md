---
description: Akash means "open space" or "sky" in ancient Sanskrit.
---

# Why Akash Network?

## Akash Network is the open source decentralized, self-soverign, secure cloud platform and marketplace for compute that's 2x to 10x cheaper for developers and businesses. 

_AKT is used as the [token](https://akash.network/token) to transact for compute on the Akash.Network. Token rewards are earned by staking which can be used to for compute_

The open source cloud is a decentralized network. Most of the compute capacity is owned by the big three centralized providers, \(Amazon, Google, and Microsoft\). Akash.Network enables compute resources to be owned and operated by _any_ provider and make that available to _any_ developer or business that wants to use them in a simpler, faster, scalable way. This creates an multi-provider resilient and redundant network of compute capacity that is easier, more private and secure for tenants (developers and businesses), while providing additional reveneue for providers to offer their excess compute at reasonable prices. Akash.Network ensures an efficient marketplace where the cost of compute is matched to the demand for running workloads, in real-time, just in time. Just about every business complains about their monthly bill on centralized cloud providers. They have zero negotiating power. Akash decentralizes and democratizes that power so individuals and business are in control (self-soverign). They control the pricing and the terms so monthly bills aren't a surprise, it's predictable.  The providers are available to match the demand in real-time, per workload deployment. In a $370bn market for cloud compute where 85% of capacity from 8.4 million, high quality, reliable data centers, is under utilized, Akash enables supply to match demand, dynamically. As a result, the market becomes highly efficient with optimal pricing and capacity. Today, using the Akash.Newtork markelplace, costs are 2x to 10x chepaer and a fill rate that's 2x of current capacity used from centralized cloud providers. 

The Akash Network consists of **marketplace** (blockchain) and **platform**

{% hint style="info" %}
Want to dive straight in? Start with our [**Quick Start Guide**](guides/deploy.md).
{% endhint %}

## What is the Akash Platform?

The **Akash Platform** enables defining, deploying, and managing [containers](./#what-is-a-container) where users can run _**any**_ applications. Any cloud application that runs on traditional cloud providers can run on Akash along with next generation web3 and DeFi apps. It's a [serverless](https://en.wikipedia.org/wiki/Serverless_computing) platform for any containerized application. The **Akash Platform** is built with a set of cloud management services including [Kubernetes](https://kubernetes.io) to orchestrate and manage containers for stateless and stateful workloads. Any docker, kubernetes, helm chart application running on a centralized cloud provider, can run on the decentralized and open source **Akash Network**.  

* Deploy your application in minutes without having to set up, configure, or manage servers - serverless.
* Package your application in a container and expose any TCP/UDP port you want. 
* Define how much CPU, Memory, and Disk in a single file.
* Set the price for providers bid on, and letting you select the best price and provider.
* Use a platform that is decentralized, resilient, redundant, scalable, secure, self-sovereign, with complete privacy. 

### What is the Akash Marketplace?

The **Akash Marketplace** is the reverse auction marketplace for compute (_Airbnb for Compute_), think Priceline meets Airbnb, where **tenants** (developers and businesses) declare what resources they want and what they want to pay for their workloads, per deployment, and providers bid to run their workloads. The Akash marketplace leverages a public blockchain in a proof of stake network. The [marketplace](decentralized-cloud/marketplace.md) transactions is on-chain for leasing computing resources on the Akash Platform. 

Akash's blockchain is a [tendermint](https://github.com/tendermint/tendermint)-based  application based on the Cosmos SDK \([cosmos-sdk](https://github.com/cosmos/cosmos-sdk)\). Akash uses the blockchain to store records of requests, bids, leases, and settlement payments using the Akash Token \(AKT\).  

### What is an Akash Application? 

The **Akash** **Application** contains everything needed to run the **Akash Platform**, the **Akash Marketplace**, and the [command-line interface](reference/general-commands.md) and is distributed in the [Akash open source GitHub repository](https://github.com/ovrclk/akash). Sample applications are available for you to use [here](https://github.com/ovrclk/awesome-akash)

### What is the cost to use Akash?

The cost is whatever you decide it is. The cost is also predictable so you no longer face sticker shock every month. The cost of hosting your application using Akash is typically about one-third the cost of Amazon AWS, Google Cloud Platform \(GCP\), and Microsoft Azure. Today, costs are 2x to 10x cheaper depending on the types of workloads. You can get a sense today using this community built open source tool, [Akashlytics.com price comparison tool](https://akashlytics.com/price-compare). 

### How can I use Akash? 

If you're new to Akash, start with the [**Getting Started guide**](guides/install.md) and go from there. Akash's community has written several more advanced guides for learning about Akash: a [node operator guide](providers/node/), a [validator guide](providers/validator.md), a [cloud provider guide](providers/provider/), and several [deployment guides](deploy/awesome-akash.md) for running various apps on Akash.

### What makes Akash different from centralized Cloud platforms?

Akash is Airbnb for Compute. Unlike Airbnb, where "hosts" sets the price and terms and "guests" choose, Akash is a reverse auction marketplace that gives consumers of cloud resources - developers and businesses (**tenants**, "guests" in Airbnb) - full control over the price and terms \(we call them attributes\) and **providers** ("hosts"), bid. Akash gives app developers an instant, zero-click command line tool for leasing and deploying apps right from a terminal.  Akash taps into the massive market of underutilized resources sitting idle in the estimated 8.4 million data centers globally. This allows Akash to provide dynamic pricing and variety of compute resources. Any containerized application running on centralized cloud can run faster, scale quickly at lower costs on the Akash decentralized cloud. 

### What makes Akash different from decentralized VM platforms?

Akash is a decentralized cloud platform that hosts containers where users can run _**any**_  Cloud-Native application. There is no need to re-write the entire internet in a new proprietary language, and there is no vendor lock-in to prevent you from switching Cloud providers. The deployment is off-chain and performed over a private peer-to-peer network isolated from the blockchain. Asset transfer occurs off-chain to provide the security and performance required by a mission critical applications running on the Cloud.  

### What is a Container?

A **container** is a standard unit of software that packages up code and all its dependencies so the application runs quickly and reliably from one computing environment to another. A **container** **image** is a lightweight, standalone, executable package of software that includes everything needed to run an application: code, runtime, system tools, system libraries and settings.

**Container images** become **containers** at runtime. Available for both Linux and Windows-based applications, containerized software will always run the same, regardless of the infrastructure. Containers isolate software from its environment and ensure that it works uniformly despite differences for instance between development and staging.

### What is this Stack Definition Language \(SDL\)?

Customers / tenants define the deployment services, datacenters, requirements, and pricing parameters, in a "manifest" file \(deploy.yml\). The file is written in a declarative language called [Software Definition Language \(SDL\)](reference/sdl.md). SDL is a human friendly data standard for declaring deployment attributes. The SDL file is a "form" to request resources from the Network. SDL is compatible with the YAML standard and similar to Docker Compose files.

### How do I configure Networking for my container?

Networking - allowing connectivity to and between workloads - can be configured via the Stack Definition Language \([SDL](reference/sdl.md)\) file for a deployment. By default, workloads in a deployment group are isolated - nothing else is allowed to connect to them. This restriction can be relaxed.

## How does the Marketplace work?

The Akash Marketplace revolves around [Deployments](decentralized-cloud/marketplace.md#deployment), which fully describe the resources that a tenant is requesting from the network. [Deployments](decentralized-cloud/marketplace.md#deployment) contain [Groups](decentralized-cloud/marketplace.md#group), which is a grouping of resources that are meant to be leased together from a single provider.

Deploying applications onto [Akash](https://github.com/ovrclk/akash) involves two types of users:

1. The **Tenant**: the entity that deploys the application.
2. The **Provider**: the entity that hosts the application.

### What is a Reverse Auction?

Akash uses a [reverse auction](https://en.wikipedia.org/wiki/Reverse_auction). Tenants set the price and terms of their deployment, and the Cloud providers bid on the deployments.  

In a very simple reverse auction:

1. A tenant creates orders.
2. Providers bid on orders.
3. Tenants choose winning bids and create leases.

A typical application deployment on Akash will follow this flow:

1. The tenant describes their desired deployment in \[SDL\], called a [deployment](decentralized-cloud/marketplace.md#deployment).
2. The tenant submits that definition to the blockchain.
3. Their submission generates an [order](decentralized-cloud/marketplace.md#order) on the marketplace.
4. Providers that would like to fulfill that order [bid](decentralized-cloud/marketplace.md#bid) on it. Happens automatically.
5. After some period of time, a winning [bid](decentralized-cloud/marketplace.md#bid) for the [order](decentralized-cloud/marketplace.md#order) is chosen, and a [lease](decentralized-cloud/marketplace.md#lease) is created.
6. Once a [lease](decentralized-cloud/marketplace.md#lease) has been created, the tenant submits a [manifest](reference/sdl.md) to the provider.
7. The provider executes workloads as instructed by the [manifest](reference/sdl.md).
8. The workload is running - if it is a web application it can be visited
9. The provider or tenant eventually closes the [lease](decentralized-cloud/marketplace.md#lease), shutting down the workload.

## How does **Security** work on Akash?

With Akash, you decide **who** you want to trust. 

### How does Akash authenticate users?

It is important for the tenant to send their manifest to the correct provider, and for the provider to ensure only valid owners can access their deployments. This authentication is implemented with [mTLS](decentralized-cloud/mtls.md) and involves each account creating a certificate prior to deploying a workload or starting a provider.

Default certificate lifespan is 365 days from the moment of issuance. This can be customized to be valid up to a certain date, or not valid until a certain date.

### **What are Audited Attributes?**

Akash has a feature designed to allow you to _control_ your trust settings called **Audited Attributes**.

Akash's Stack Definition Language \(SDL\) allows you to define attributes such as the type of provider, region, CPU, Memory, Storage, and which auditors you want to trust. When you deploy on Akash, you can configure any attribute that restricts bids to only providers that meet your criteria.

Auditors on the Akash Network review cloud providers and digitally sign the provider on chain with their certificate. If you only accept bids from audited providers this means you are trusting the Auditor/Provider not just a Provider.

### **How do I limit my trust to Audited Providers?**

Follow the getting started guide, and you will see the [instructions for audited attributes](https://docs.akash.network/guides/deploy#audited-attributes) suggest using only servers signed by Akash Network. If you deploy today, you will see bids by Equinix servers that audited and signed by Akash Network. By doing this you are trusting [Equinix’s Security Standards and Compliance](https://www.equinix.com/data-centers/design/standards-compliance) and you are trusting Overclock Labs as the auditor to only sign servers that meet those standards.

