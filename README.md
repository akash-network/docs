---
description: >-
  Welcome to Akash! We want you to understand what Akash is, how you can use it,
  and how you can contribute to the project. Let's build a better internet
  together.
---

# What is Akash?

## Akash is the open source cloud. 

The open source cloud is a shift from computing resources being owned and operated by the three large Cloud companies \(Amazon, Google, and Microsoft\) to a decentralized network __of Cloud providers running an _**open**_ _**platform**_ developed by the open source community creating competition in an _**open**_ _**marketplace**_ with more providers and lower costs.

{% hint style="info" %}
Want to dive straight in? Start with our [**Quick Start Guide**](guides/deploy.md).
{% endhint %}

## What is the Akash Platform?

The **Akash Platform** is a deployment platform for hosting and managing [containers](./#what-is-a-container) where users can run _**any**_  Cloud-Native application.  The **Akash Platform** is built with a set of cloud management services including [Kubernetes](https://kubernetes.io) to orchestrate and manage containers.

* Deploy your application in minutes without having to set up, configure, or manage servers.
* Package your application in a container and expose any TCP/UDP port you want. 
* Define how much CPU, Memory, and Disk in a single file.
* Set the price for providers bid on, and letting you select the best price and provider.
* Use a platform that is censorship-resistant, permissionless, and self-sovereign. 

### What is the Akash Marketplace?

The **Akash Marketplace** is the mechanism by which users acquire resources on the Akash Platform. The Akash marketplace is an on-chain decentralized [marketplace](decentralized-cloud/marketplace.md) for leasing computing resources on the Akash Platform. 

Akash's blockchain is a [tendermint](https://github.com/tendermint/tendermint)-based  application based on the Cosmos SDK \([cosmos-sdk](https://github.com/cosmos/cosmos-sdk)\). Akash uses the blockchain to store records of requests, bids, leases, and settlement payments using the Akash Token \(AKT\).  

### What is the Akash Application? 

The **Akash** **Application** contains everything needed to run the **Akash Platform**, the **Akash Marketplace** and the [command-line interface](reference/general-commands.md) and is distributed in the [Akash open source GitHub repository](https://github.com/ovrclk/akash). 

### What is the cost to use Akash?

The cost of hosting your application using Akash is about one-third the cost of Amazon AWS, Google Cloud Platform \(GCP\), and Microsoft Azure. You can check the prices live using the [Akashlytics.com price comparison tool](https://akashlytics.com/price-compare). 

### How can I use Akash? 

If you're new to Akash, start with the [**Getting Started guide**](start/install.md) and go from there. Akash's community has written several more advanced guides for learning about Akash: a [node operator guide](providers/node/), a [validator guide](providers/validator.md), a [cloud provider guide](providers/provider/), and several [deployment guides](guides/awesome-akash.md) for running various apps on Akash.

### What makes Akash different from centralized Cloud platforms?

Like AirBNB for server hosting, Akash is a marketplace that gives you control over the price you pay and the amenities included \(we call them attributes\). Akash gives app developers an instant, zero-click command line tool  for leasing and deploying apps right from a terminal.  Akash taps into the massive market of underutilized resources sitting idle in the estimated 8.4 million data centers globally. This allows Akash to provide more variety and better pricing. Any cloud-native and containerized applications running on centralized cloud can run faster and at lower cost on the Akash decentralized cloud. 

### What makes Akash different from decentralized VM platforms?

Akash is a decentralized cloud platform that hosts containers where users can run _**any**_  Cloud-Native application. There is no need to re-write the entire internet in a new proprietary language, and there is no vendor lock-in to prevent you from switching Cloud providers. The deployment is off-chain and performed over a private peer-to-peer network isolated from the blockchain. Asset transfer occurs off-chain to provide the security and performance required by a mission critical applications running on the Cloud.  

### What is a Container?

A **container** is a standard unit of software that packages up code and all its dependencies so the application runs quickly and reliably from one computing environment to another. A **container** **image** is a lightweight, standalone, executable package of software that includes everything needed to run an application: code, runtime, system tools, system libraries and settings.

**Container images** become **containers** at runtime. Available for both Linux and Windows-based applications, containerized software will always run the same, regardless of the infrastructure. Containers isolate software from its environment and ensure that it works uniformly despite differences for instance between development and staging.

### What is this Stack Definition Language \(SDL\)?

Customers / tenants define the deployment services, datacenters, requirements, and pricing parameters, in a "manifest" file \(deploy.yml\). The file is written in a declarative language called [Software Definition Language \(SDL\)](reference/sdl.md). SDL is a human friendly data standard for declaring deployment attributes. The SDL file is a "form" to request resources from the Network. SDL is compatible with the YAML standard and similar to Docker Compose files.

#### How do I configure Networking for my container?

Networking - allowing connectivity to and between workloads - can be configured via the Stack Definition Language \([SDL](reference/sdl.md)\) file for a deployment. By default, workloads in a deployment group are isolated - nothing else is allowed to connect to them. This restriction can be relaxed.

## How does the Marketplace work?

The Akash Marketplace revolves around [Deployments](decentralized-cloud/marketplace.md#deployment), which fully describe the resources that a tenant is requesting from the network. [Deployments](decentralized-cloud/marketplace.md#deployment) contain [Groups](decentralized-cloud/marketplace.md#group), which is a grouping of resources that are meant to be leased together from a single provider.

Deploying applications onto [Akash](https://github.com/ovrclk/akash) involves two types of users:

1. The **Tenant**: the entity that deploys the application.
2. The **Provider**: the entity that hosts the application.

### What is a Reverse Auction?

Akash uses a reverse auction . Tenants set the price and terms of their deployment, and the Cloud providers bid on the deployments.  

In a very simple reverse auction:

1. A tenant creates orders.
2. Providers bid on orders.
3. Tenants choose winning bids and create leases.

A typical application deployment on Akash will follow this flow:

1. The tenant describes their desired deployment in \[SDL\], called a [deployment](decentralized-cloud/marketplace.md#deployment).
2. The tenant submits that definition to the blockchain.
3. Their submission generates an [order](decentralized-cloud/marketplace.md#order) on the marketplace.
4. Providers that would like to fulfill that order [bid](decentralized-cloud/marketplace.md#bid) on it.
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

