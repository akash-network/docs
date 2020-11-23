# Overview

The [Akash] DeCloud is comprised of two main components:

1. The **Network**: an on-chain decentralized [marketplace] (DEX) for leasing computing resources.
1. The **Platform**: an off-chain deployment platform used for hosting and managing workloads.

The **Network** is built with [cosmos-sdk] - it is a [tendermint]-based blockchain application.

The **Platform** is a set of [cloud management services](#provider-services) that leverage [Kubernetes] to run workloads.

The software to run the **Network**, the **Platform**, and the command-line client used to interact with them are all
currently distributed in the `akash` application.

## Workflow - Life of a Deployment

Deploying applications onto [Akash] involves two types of users:

1. The **Tenant**: the entity that deploys the application.
1. The **Provider**: the entity that hosts the application.

Given that there are live providers on the network, the lifecycle of a typical application deployment is as follows:

1. The tenant describes their desired deployment in [SDL], called a [deployment].
1. The tenant submits that definition to the blockchain.
1. Their submission generates an [order] on the [marketplace].
1. Providers that would like to fulfill that [order] [bid] on it.
1. After some period of time, a winning [bid] for the [order] is chosen, and a [lease] is created.
1. Once a [lease] has been created, the tenant submits a [manifest] to the provider.
1. The provider executes workloads as instructed by the [manifest].
1. The workload is running - if it is a web application it can be visited, etc...
1. The provider or tenant eventually closes the [lease], shutting down the workload.


* [Features](features.md)
{% comment %}
* Design
  * [Marketplace](marketplace.md)
  * [Provider Services](provider-services.md)
{% endcomment %}

[deployment]: marketplace.md#deployment
[group]:      marketplace.md#group
[order]:      marketplace.md#order
[bid]:        marketplace.md#bid
[lease]:      marketplace.md#lease
[manifest]:   provider-services.md#manifest

[akash]:      https://github.com/ovrclk/akash
[cosmos-sdk]: https://github.com/cosmos/cosmos-sdk
[tendermint]: https://github.com/tendermint/tendermint
[kubernetes]: https://kubernetes.io
