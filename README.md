---
description: >-
  Welcome to Akash! We want you to understand what Akash is, how you can use it,
  and how you can contribute to the project. Let's build a better internet
  together.
---

# Akash Overview

## Akash means 'open space' or 'sky' in Sanskrit.

Akash Network is the world’s first open source cloud.  Any cloud-native and containerized applications running on centralized cloud can run faster and at lower cost on Akash’s DeCloud - the decentralized cloud.

{% hint style="info" %}
Want to dive straight in? Start with our [**Getting Started**](start/install.md) section.
{% endhint %}

### Why does Akash matter?

Akash Network envisions a world where cloud computing is permissionless, sovereign, and open, where builders of the internet have greater freedom. Akash is a live working product that allows you to:

* Deploy your application in minutes without having to set up, configure, or manage servers.
* Package your application in a container and expose any TCP/UDP port you want. 
* Define how much CPU, Memory, and Disk in a single file.
* Set the price for providers bid on, and letting you select the best price and provider.
* Use a platform that is censorship-resistant, permissionless, and self-sovereign. 

### How can I use Akash? 

We have written several guides for learning about Akash: a [getting started guide](start/install.md), a [node operator guide](providers/node/), a [validator guide](providers/validator.md), a [cloud provider guide](providers/provider/), and several [deployment guides](guides/awesome-akash.md) for running various apps on Akash.

If you're new to Akash, start with the [**Getting Started guide**](start/install.md) and go from there. We suggest developers and providers  read through the entirety of the Getting Started article before working through more specific documentation. 

### What makes Akash different from other decentralized platforms?

Akash a server-less Cloud platform that hosts containers where users can run _**any**_  Cloud-Native application. The deployment is off-chain and performed over a private peer-to-peer network isolated from the blockchain. Asset transfer occurs off-chain to provide the security and performance required by a mission critical applications running on the Cloud. 

### Why does Akash use a blockchain?

Akash leverages blockchain for provisioning and settlement using the Akash Token \(AKT\), while deployment happens off-chain. This limits Akash’s users from running verifiable smart contracts as the scalability envelope is not designed for on-chain execution.

### What is the Akash DeCloud? 

The [Akash](https://github.com/ovrclk/akash) DeCloud - or Decentralized Cloud - is comprised of two main components, the marketplace and the cloud platform.

The **Akash Marketplace** is the mechanism by which users acquire resources on the Akash Platform. The Akash marketplace is an on-chain decentralized [marketplace](decentralized-cloud/marketplace.md) for leasing computing resources. The marketplace is built with [cosmos-sdk](https://github.com/cosmos/cosmos-sdk) - it is a [tendermint](https://github.com/tendermint/tendermint)-based blockchain application.

The **Akash Platform** is an off-chain deployment platform used for hosting and managing containers. The platform is built with a set of cloud management services including [Kubernetes](https://kubernetes.io) to orchestrate and manage containers.

The **Akash** **Application** contains everything needed to run the Network, the Platform, and the [command-line interface](reference/general-commands.md) and is distributed in the [Akash open source GitHub repository](https://github.com/ovrclk/akash). The Akash Marketplace is an auction for compute resources. It is the mechanism by which users acquire resources on the Akash Platform.

### What is a Container?

A **container** is a standard unit of software that packages up code and all its dependencies so the application runs quickly and reliably from one computing environment to another. A **container** **image** is a lightweight, standalone, executable package of software that includes everything needed to run an application: code, runtime, system tools, system libraries and settings.

**Container images** become **containers** at runtime. Available for both Linux and Windows-based applications, containerized software will always run the same, regardless of the infrastructure. Containers isolate software from its environment and ensure that it works uniformly despite differences for instance between development and staging.

### What is Stack Definition Language \(SDL\)?

Customers / tenants define the deployment services, datacenters, requirements, and pricing parameters, in a "manifest" file \(deploy.yml\). The file is written in a declarative language called [Software Definition Language \(SDL\)](reference/sdl.md). SDL is a human friendly data standard for declaring deployment attributes. The SDL file is a "form" to request resources from the Network. SDL is compatible with the YAML standard and similar to Docker Compose files.

#### How do I configure Networking for my container?

Networking - allowing connectivity to and between workloads - can be configured via the Stack Definition Language \([SDL](reference/sdl.md)\) file for a deployment. By default, workloads in a deployment group are isolated - nothing else is allowed to connect to them. This restriction can be relaxed.

### How does the Marketplace work?

The Akash Marketplace revolves around [Deployments](decentralized-cloud/marketplace.md#deployment), which fully describe the resources that a tenant is requesting from the network. [Deployments](decentralized-cloud/marketplace.md#deployment) contain [Groups](decentralized-cloud/marketplace.md#group), which is a grouping of resources that are meant to be leased together from a single provider.

Deploying applications onto [Akash](https://github.com/ovrclk/akash) involves two types of users:

1. The **Tenant**: the entity that deploys the application.
2. The **Provider**: the entity that hosts the application.

### What is a Reverse Auction?

Akash uses a reverse auction . Tenants set the price and terms of their deployment, and the Cloud providers bid on the deployments.  In a reverse auction:

1. A tenant creates orders.
2. Providers bid on orders.
3. Tenants choose winning bids and create leases.

### Lifecycle of a Deployment

The lifecycle of a typical application deployment is as follows:

1. The tenant describes their desired deployment in \[SDL\], called a [deployment](decentralized-cloud/marketplace.md#deployment).
2. The tenant submits that definition to the blockchain.
3. Their submission generates an [order](decentralized-cloud/marketplace.md#order) on the marketplace.
4. Providers that would like to fulfill that order [bid](decentralized-cloud/marketplace.md#bid) on it.
5. After some period of time, a winning [bid](decentralized-cloud/marketplace.md#bid) for the [order](decentralized-cloud/marketplace.md#order) is chosen, and a [lease](decentralized-cloud/marketplace.md#lease) is created.
6. Once a [lease](decentralized-cloud/marketplace.md#lease) has been created, the tenant submits a [manifest](reference/sdl.md) to the provider.
7. The provider executes workloads as instructed by the [manifest](reference/sdl.md).
8. The workload is running - if it is a web application it can be visited
9. The provider or tenant eventually closes the [lease](decentralized-cloud/marketplace.md#lease), shutting down the workload.

## Certificates

It is important for the tenant to send their manifest to the correct provider, and for the provider to ensure only valid owners can access their deployments. This authentication is implemented with [mTLS](decentralized-cloud/mtls.md) and involves each account creating a certificate prior to deploying a workload or starting a provider.

Default certificate lifespan is 365 days from the moment of issuance. This can be customized to be valid up to a certain date, or not valid until a certain date.

