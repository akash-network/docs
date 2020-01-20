
# Introduction

Cloud infrastructure is a $32.4 billion industry[@gartner] and is predicted to reach $210 billion by 2022[@marketsandmarkets].

By 2021, 94% of all internet applications and compute instances are expected to be processed by *Cloud Service Providers* (CSP) with only 6% processed by traditional data centers[@cisco]. The primary driver for this growth is poor utilization rates of IT resources provisioned in traditional data centers as no more than 6% of their maximum computing output is delivered on average over the course of the year [@mckinsey], and up to 30% of servers are comatose[@comatose] – using electricity but delivering no useful information services.

With 8.4 million data centers globally, an estimated 96% of server capacity underutilized, and accelerated global demand for cloud computing, the three leading cloud service providers — Amazon Web Services (AWS), Google Cloud, and Microsoft Azure — dominate the cloud computing market with 71% market share[@gartner] and this figure is expected to increase. These providers are complicated, inflexible, restrictive, and come at a high recurring cost with vendor lock-in agreements[@nytimes]. Increased cloud usage has made cloud cost optimization the top priority of cloud service users for three consecutive years[@rightscale].

Outside of the large incumbent providers, organizations do not have many options for cloud computing. Akash aims to create efficiencies in the cloud hosting market by repurposing compute resources that go to waste in the current market.

By leveraging a blockchain, Akash introduces decentralization and transparency into an industry currently controlled by monopolies. The result is that cloud computing becomes a commodity, fueled by competitive free market, available and accessible anywhere in the world, at a fraction of current costs.

Akash is the world’s first and only *Supercloud* for *serverless* computing, enabling anyone with a computer to become a cloud provider by offering their unused compute cycles in a safe and frictionless marketplace.

In this paper, we present an economic system that uses Akash Network's native currency, AKT, to achieve economic sovereignty in our decentralized computing ecosystem. We also propose an inflation design for mitigating inherent adoption challenges that face an early market economy — lack of sufficient demand from the tenants (consumers of computing), which negatively impacts demand due to lack of supply. We also present a mechanism for a stable medium of exchange by solving for token volatility, a major challenge for adoption of decentralized ecosystems.

**Note:** This whitepaper represents a continuous work in progress. We will endeavor to keep this document current with the latest development progress. As a result of the ongoing and iterative nature of the Akash development process, the resulting code and implementation will likely differ from what this paper represents.

We invite the interested reader to peruse the Akash GitHub repo at https://github.com/ovrclk as we continue to open-source various components of the system over time.


## Definitions

Akash Token (AKT)

:  AKT is the native token of the Akash Network. The core utility of AKT acts as a staking mechanism to secure the network and normalize compute prices for the marketplace auction. The amount of AKTs staked towards a validator defines the frequency by which the validator may propose a new block and its weight in votes to commit a block. In return for bonding (staking) to a validator, an AKT holder becomes eligible for block rewards (paid in AKT) as well as a proportion of transaction fees and service fees (paid in any of the whitelisted tokens).

Validator

:   Validators secure the Akash network by validating and relaying transactions, proposing, verifying and finalizing blocks. There will be a limited set of validators, initially 64, required to maintain a high standard of automated signing infrastructure. Validators charge *delegators* a commission fee in AKT.

Delegator

:   Delegators are holders of the AKT and use some or all of their tokens to secure the Akash chain. In return, delegators earn a proportion of the transaction fee as well as block rewards.

Provider

:  Providers offer computing cycles (usually unused) on the Akash network and earn a fee for their contributions. Providers are required to maintain a stake in AKT as collateral, proportional to the hourly income earned; hence, every provider is a delegator and/or a validator.

Tenant

:   Tenants lease computing cycles offered by providers for a market-driven price set using a reverse auction process (described in section below).

## Marketplace Overview

A unit of computing (*CPU, Memory, Disk*) is leased as a container on Akash. A container [@container] is a standard unit of software that packages up code and all its dependencies, so the application runs quickly and reliably from one computing environment to another. A container image is a lightweight, standalone, executable package of software that includes everything needed to run an application: code, runtime, system tools, system libraries, and settings.

Any one with a physical machine (ie, computer, server) can divide the machine's resources into containers using a process called virtualization. Docker is a company that provides widely adopted container virtualization technology, and it is common to refer to containers as "docker images." The relation between a physical computer and a container is illustrated in [@fig:containers]).

All marketplace transactions are on the Akash blockchain. To lease a container, the *tenant* (developer) requests a deployment by specifying the type(s) of unit(s), and the quantity of each type of unit. To specify a type of unit, the tenant specifies attributes to match, such as region (e.g. US) or privacy features (e.g. Intel SGX). The tenant also specifies the maximum price they are willing to pay for each type of unit.

An *order* is created in the order book (upon acceptance by a validator).

The *provider(s)* that match all the requirements of the order then place a *bid* by competing on price. The provider that bids the lowest amount on the order wins, upon which a *lease* is created between the tenant and the provider for the order. For every successful lease, a portion of the lease amount (*Take Fee*) is paid to the stakers as describe in [@sec:take-fee].

![A simple illustration of containerized applications in relation to the physical servers](figures/containers.svg){#fig:containers}
