# Frequently Asked Questions \(FAQ\)

If there is something you'd like to see in here that isn't already, please reach out in our [Developer Chat](http://discord.akash.network)  or the [Community Forum](http://forum.akash.network) and we'll get it added!

### Table of Contents

[General](faq.md#General)  
[Product](faq.md#Product)  
[Supermini](faq.md#Supermini)

## General

**How are gas fees calculated on Akash?**

Akash uses the basic Cosmos gas calculations for all fees.  Cosmos documentation on gas can be found [here](https://docs.cosmos.network/master/basics/gas-fees.html). 

**How does the Akash Network compete against the AWS spot instances in terms of price?**

Spot Instances are exactly the same as On-Demand Instances. However, Spot does not guarantee that you can keep your running instances long enough to finish your workloads. Spot also does not guarantee that you can get immediate availability of the instances that you are looking for, or that you can always get the aggregate capacity that you requested. Moreover, Spot Instance interruptions and capacity can change over time because Spot Instance availability varies based on supply and demand, and past performance isn’t a guarantee of future results.

Spot Instances are not suitable for workloads that are inflexible, stateful, fault-intolerant, or tightly coupled between instance nodes. It's not recommended for workloads that are intolerant of occasional periods when the target capacity is not completely available.

Generally, it is cheaper to run on Akash and will be for the foreseeable future, especially, when we introduce fractional uAKT. However, pricing is on a continuum. It's variable, and dynamic at any given time. In Airbnb terms - a hut to a luxury villa.

## Product

**Can Akash provide Name Server Services?**

One issue with using name servers is that DNS will be exposed on a random ephemeral port instead of 53. We have plans to add IP addresses as a resource of the lease but it is not available yet.

**Do I need to redeploy if I want to update the deployment?**

It depends what you'd like to update. Akash Groups are translated into Kubernetes Deployments, this means that only a few fields from the Akash SDL are mutable. For example image, command, args, env and exposed ports can be modified, but compute resources and placement criteria cannot.

**How can I \(someone wanting to deploy an application on Akash\) be sure that the provider won't/didn't try to modify my application?**

At this time we don't have secure enclave support. There are some technical limitations to TEE and the like. Our audited attributes system is meant to approach the problem from a different angle. Why would you trust digital ocean, or AWS, or any other cloud provider in the first place? some metric of trust. The audited attributes feature allows you to deploy only to providers that have been "signed off" on by an entity that you have confidence in.

**Is there also a way to decentralize docker registry? So it would not be a single point of failure, if selected one \(centralized\) goes down?**

Yes, this is something we've talked about for a long time but haven't had a chance to dig into much. It could be a bittorrent-style thing or it could be on IPFS, etc... We intend to explore all of this but we're focusing on getting people onto the platform with the assumption that their docker containers are more or less reachable for the time being.

**Are there plans to add support for persistent volumes?**

Yes. All storage is ephemeral for now, but we will work on persistent storage in the future.

**Is there GPU support?**

It is on the roadmap, however, GPU workloads aren't supported just yet - there are some technical limitations related to GPU sharing and security with our current Kubernetes backend. We are actively working on it.

**Can Akash be used with private images or do they have to be public?**

Images need to be publicly accessible at this time.

## Supermini

**When can I get the Supermini and can it be shipped outside the US?**

Currently there is no further information about the [supermini](https://akash.network/supermini), its availability in the US and Europe, or dates of availability for subsequent orders.

**How much money can the Supermini make me?**

The yield from running a Supermini as a provider on the Akash Network will be a function of demand/network usage - meaning it will depend on how many applications are being deployed on the network. We are focused on on building this demand over the coming months.

