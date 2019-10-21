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

You can skip this section if your workstation is configured with the necessary software

### Akash Client

You will be interacting with the network using the Akash client. Check out this [guide](../install.md) to install Akash on your workstation. Once you successfully installed, confirm you setup using:

```shell
akash status
```

The above should display a response similar to:

```text
Status
======

Node Version:        	0.31.5                                                          
Latest Block Height: 	101758                                                          
Latest Block Hash:   	4927f09fda01863bd762cae4cb5f0ec8ccc9fb3d40af93cc2208dce1a1df5670
Last Block Created:  	2 seconds ago                                                   
```

### Keybase

Keybase offers an end-to-end and cloud storage system that lets us to share sensitive information (such as private keys) between your workstation and the network. Check out this guide (https://keybase.io/download) to set up keybase on your workstation. To confirm keybase is setup properly, run the below:

```shell
keybase id
```

The above should return a response similar to:

```
▶ INFO Identifying kn0tch
✔ public key fingerprint: F731 6454 2118 DB51 44A1 655C 3CF6 8C6B 14A1 03D5
🚀  Stellar GAIYPV7OIZST7WXCYVLYO3FBJPCHAXI3Y4S6FQ64KC7CWN4R2OQO6B5L (kn0tch*keybase.io)
✔ "gregosuri" on twitter: https://twitter.com/gregosuri/status/1179220421465518082 [cached ...
✔ "gosuri" on github: https://gist.github.com/9818622 [cached ...
✔ "gosuri" on hackernews: https://news.ycombinator.com/user?id=gosuri [cached ...
✔ admin of DNS zone gregosuri.com: found TXT entry keybase-site-verification=AAP3mKWHM8sATAPK....
```

### Docker

Docker is a software tool that uses OS-level virtualization to deliver software in packages called containers. Containers are isolated from one another and bundle their software, libraries, and configuration files. You can find instructions to install docker here (https://docs.docker.com/docker-for-mac/install/)

To confirm Docker is setup properly, run:

```shell
docker info
```

You should see a response similar to :

```
Client:
 Debug Mode: false

Server:
 Containers: 26
  Running: 2
  Paused: 0
  Stopped: 24
 Images: 105
 Server Version: 19.03.2
 ...
```

## Deploying Matrix Server
### Generate configuration
### Deploy to Akash
