---
description: >-
  Welcome to the support documentation and user guides for Akash, the
  decentralized cloud platform.
---

# Akash Overview

Akash -- "open space, sky" in ancient Sanskrit -- is the world’s first distributed peer-to-peer open cloud computing marketplace; our goal is to build an open source permissionless cloud as boundless as the sky.

### What makes Akash different from other decentralized cloud platforms?

Akash provides a serverless platform that hosts containers where users can run _**any**_ application currently running on the cloud. The deployment is off-chain and performed over a private peer-to-peer network isolated from the blockchain, and asset transfer occurs off-chain to protect and performance that we need for a mission critical application running on the Cloud. A critical component of Akash are 

### Why Blockchain?

Akash leverages blockchain for provisioning and settlement but deployment happens off-chain. This limits Akash’s users from running verifiable smart contracts as the scalability envelope is not designed for on-chain execution.

For details about what [Akash](https://github.com/ovrclk/akash) can do and what makes it tick, see [Features and Design](decentralized-cloud/design.md).

### Decentralized Cloud

The [Akash](https://github.com/ovrclk/akash) Decentralized Cloud \(DeCloud\) is comprised of two main components:

1. The **Network**: an on-chain decentralized [marketplace](decentralized-cloud/marketplace.md) for leasing computing resources.
2. The **Platform**: an off-chain deployment platform used for hosting and managing workloads.

The **Network** is built with [cosmos-sdk](https://github.com/cosmos/cosmos-sdk) - it is a [tendermint](https://github.com/tendermint/tendermint)-based blockchain application.

The **Platform** is a set of [cloud management services](decentralized-cloud/design.md#provider-services) that leverage [Kubernetes](https://kubernetes.io) to run workloads.

The software to run the **Network**, the **Platform**, and the [command-line client](reference/general-commands.md) used to interact with them are all currently distributed in the `akash` application.The Akash Marketplace is an auction for compute resources. It is the mechanism by which users acquire resources on the Akash Platform.

