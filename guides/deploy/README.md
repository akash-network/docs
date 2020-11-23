# Deploy an Application

In this guide, we'll deploy an application on Akash.

## Before We Begin

You'll need to know information about the network you're connecting your node to.
See [Choosing a Network](/guides/versions.md) for how to obtain any network-related information.

Make sure to have Akash client installed on your workstation, check [install guide](/guides/install.md) for instructions.

You'll need an account with funds to pay for your deployment.  See the [funding guide](/guides/wallet/funding.md) for
creating a key and funding your account.

## Configure your settings

Choose an SDL file frome awesome-akash or similar.

## Depoy your application

```sh
akash tx deployment create deploy.yml --from "$KEY_NAME"
```

## Wait for your lease

```sh
akash query market lease --owner "$(akash keys show "$KEY_NAME" -a)"
```

## Shut down deployment

```sh
akash query market lease --owner "$(akash keys show "$KEY_NAME" -a)"
```
