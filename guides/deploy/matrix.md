# Deploying a private matrix chat server

In this tutorial, we’ll learn how to deploy a secure chat server on Akash. Akash is a permissionless and censorship-resistant cloud network that guarantees sovereignty over your data and your applications. With Akash, you’re in complete control of all aspects of the life cycle of an application with no middleman.

In this guide, we’ll set up an end-to-end encrypted private chat server using matrix and riot web client. Matrix is an open network for secure, decentralized communication. Riot is a glossy Matrix client with an emphasis on performance and usability.
Before we begin

## Before we begin

This is a technical guide, best suited to a reader with basic Linux command line knowledge. The audience for this guide is intended for includes:

- Application developers with little or no systems administration experience, wanting to deploy applications on the decentralized cloud.
- System administrators with little or no experience with infrastructure automation, wanting to learn more.
- Infrastructure automation engineers that want to explore decentralized cloud.
- Anyone who wants to get a feel for the current state of the decentralized cloud ecosystem.

## Receive AKT tokens from the Testnet

You can pay for hosting on Akash using AKT tokens. Request AKT tokens by registering on the Testnet [here](http://akash.network/testnet)

## Setup you workstation

### Akash Client

You will be interacting with the network using the Akash client. Check out this guide to install Akash on your workstation.

Keybase: We’ll use keybase to share sensitive information, such as private keys, between your workstation and the network. Check out this guide (https://keybase.io/download) to set up keybase on your workstation.

Docker: Docker is a software tool that uses OS-level virtualization to deliver software in packages called containers. Containers are isolated from one another and bundle their software, libraries, and configuration files. You can find instructions to install docker here (https://docs.docker.com/docker-for-mac/install/)



Install Matrix Server
