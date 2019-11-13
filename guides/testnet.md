# Akash Testnet

The Akash testnet is a fully-functioning decentralized cloud, with support for requesting, deploying, and paying for cloud deployments. Server capacity is being kindly provided by Packet, the world's leading bare-metal provider. Access is **free** for registered users. As a free service, capacity is tightly managed, so please treat testnet capacity as the scarce community resource it is. In other words, please play nicely in our sandbox.

We want your feedback! Please message us [on chat](https://akash.network/chat) with any and all of your feedback. We're putting our in-progess platform out there so that we can get real-world feedback, so don't be shy!

### Intended users

The Akash testnet is a deployment platform with a CLI and intended for relatively sophisticated users. If you are comfortable managing instances via the AWS API and can build and deploy a Docker container, you will find the Akash testnet easy to use. If not, please feel free to give it a shot, but you might find it confusing.

### Getting help

First of course, [RTFM](../usage/cli), then please feel free to ask questions in our [chat](http://akash.network/chat).

### Uptime and availability

The Akash testnet is at an alpha-level stage of development and so **not intended for production use.** New functionality and capacity is being added constantly, but is always presented to you as-is, so use at your own risk. Use is at our discretion and we reserve the right to bring down deployments or to re-initialize the chain at any time for any reason.

The Akash testnet is at an alpha-level stage of development and so **not intended for production use.** New functionality and capacity is being added constantly, but is always presented to you as-is, so use at your own risk. Use is at our discretion and we reserve the right to bring down deployments or to re-initialize the chain at any time for any reason.

## Before We Begin

Make sure to have Akash client installed on your workstation, check [install guide](/guides/install.md) for instructions.

## Get Started

To request tokens, please create an account on you local machine and ping us on our [matrix chat room](http://akash.network/chat) with your public key. 

To create a key, please make sure you installed Akash client on your workstation and run the below:

```
akash key create
```

You should see a response, similar to:

```
Key Name (required): bob
(info)  [key] key created

Create Key
==========

Name:           	bob
Public Key:     	44fc42cfff72666bbb02fc3a08545e89b35ea1ff
Recovery Codes: 	main nerve normal hill analyst iron weapon ordinary evoke sniff kitchen pyramid address apple direct inform skirt ozone stage market clown home fit height

(warn)  [Important] Write these Recovery codes in a safe place. It is the only way to recover your account.
```

## Request Tokens

The public key address in the above example is `44fc42cfff72666bbb02fc3a08545e89b35ea1ff`

Now, login to our [developer chat](https://akash.network/chat) and send a message with the format:

```text
i want disco! <amount> <address>
```

For example:

```text
i want disco! 5000 44fc42cfff72666bbb02fc3a08545e89b35ea1ff
```
