# Deploy an Application

In this guide, we'll deploy a single-tier web application on Akash. Akash is a permissionless and censorship-resistant cloud network that guarantees sovereignty over your data and your applications. With Akash, you’re in complete control of all aspects of the life cycle of an application with no middleman.

In this guide, we'll setup [Lunie Light](https://github.com/ovrclk/lunie-light), a non-custodial, web wallet for Akash on Akash. Lunie Light is a staking interface for proof-of-stake blockchains in the Cosmos ecosystem — built for speed, simplicity, and ease-of-use.

## Before We Begin

This is a technical guide, best suited to a reader with basic Linux command line knowledge. The audience for this guide is intended for includes:

* Application developers with little or no systems administration experience, wanting to deploy applications on the decentralized cloud.
* System administrators with little or no experience with infrastructure automation, wanting to learn more.
* Infrastructure automation engineers that want to explore decentralized cloud.
* Anyone who wants to get a feel for the current state of the decentralized cloud ecosystem.

You'll need to know information about the network you're connecting your node to. See [Choosing a Network](/guides/version.md) for how to obtain any network-related information.

Make sure to have Akash client installed on your workstation, check [install guide](/guides/install.md) for instructions.

You'll need an account with funds to pay for your deployment. See the [funding guide](/guides/wallet/funding.md) for
creating a key and funding your account.

### Set up your Environment

We will be using shell variables throughout this guide for convenience and clarity.  Ensure you have the below set of variables defined on your shell, you can use `export VARNAME=...`:

|Name|Description|
|---|---|
|`AKASH_NODE`| Akash network configuration base URL. See [here](/guides/version.md).|
|`AKASH_CHAIN_ID`| Chain ID of the Akash network connecting to. See [here](/guides/version.md).|
|`ACCOUNT_ADDRESS`| The address of your account.  See [here](/guides/wallet/README.md#account-address).|
|`KEY_NAME` | The name of the key you will be deploying from. See [here](/guides/wallet/README.md) if you haven't yet setup a key|
|`KEYRING_BACKEND`| Keyring backend to use for local keys. See [here](/guides/wallet/README.md)|

Verify you have correct `$AKASH_NODE`, that you have populated while [configuring the connection](/guides/version) using `export AKASH_NODE=$(curl -s "$AKASH_NET/rpc-nodes.txt" | shuf -n 1)`.

```sh
echo $AKASH_NODE $AKASH_CHAIN_ID

tcp://rpc-edgenet.akashdev.net:2665 akash-edgenet-1
```

Your values may differ depending on the network you're connecting to, `tcp://rpc-edgenet.akashdev.net:2665` and `akash-edgenet-1` are details for [edgenet](https://github.com/ovrclk/net/tree/master/edgenet).

Verify you have the key set up and your account has sufficient balances, see the [funding guide](/guides/wallet/funding.md) otherwise:

My local key is named `alice`, the below command should return the name you've used:

```sh
echo $KEY_NAME 

alice
```

Populate `ACCOUNT_ADDRESS` from `KEY_NAME` and verify:

```sh
export ACCOUNT_ADDRESS="$(akash keys show $KEY_NAME -a)"

echo $ACCOUNT_ADDRESS

akash1j8s87w3fctz7nlcqtkl5clnc805r240443eksx
```

Check your account has sufficient balance by running:

```sh
akash query bank balances --node $AKASH_NODE $ACCOUNT_ADDRESS
```

You should see a response similar to:

```
balances:
- amount: "93000637"
  denom: uakt
pagination:
  next_key: null
  total: "0"
```

Please note the balance indicated is is denominated in uAKT (AKT * 10^-6), in the above example, the account has a balance of *93 AKT*. We're now setup to deploy.

## Create The Deployment Configuration 

Create a deployment configuration [deploy.yml](deploy.yml) to deploy the `quay.io/ovrclk/lunie-light` container using [SDL](/sdl/README.md) :

```sh
cat > deploy.yml <<EOF
---
version: "2.0"

services:
  web:
    image: ovrclk/lunie-light
    expose:
      - port: 3000
        as: 80
        to:
          - global: true

profiles:
  compute:
    web:
      resources:
        cpu:
          units: 0.1
        memory:
          size: 512Mi
        storage:
          size: 512Mi
  placement:
    westcoast:
      attributes:
        organization: ovrclk.com
      signedBy:
        anyOf:
          - "akash1vz375dkt0c60annyp6mkzeejfq0qpyevhseu05"
      pricing:
        web: 
          denom: uakt
          amount: 1000

deployment:
  web:
    westcoast:
      profile: web
      count: 1

EOF
```

Alternatively, you can use cURL to download:

```
curl -s https://raw.githubusercontent.com/ovrclk/docs/master/guides/deploy/deploy.yml > deploy.yml
```

You may use the sample deployment file as-is or modify it for your own needs as desscribed in our [SDL (Stack Definition Language)](documentation/sdl) documentation. A typical modification would be to reference your own image instead of our demo app image. 

{% hint style="warn" %}

Please note if you are running on the testnet, you are limited in the amount of testnet resources you may request. 

{% endhint %}

## Create the Deployment

To deploy on Akash, run:

```sh
akash tx deployment create deploy.yml --from $KEY_NAME --node $AKASH_NODE --chain-id $AKASH_CHAIN_ID -y
```
    
You should see a response similar to:
```json
{
  "height": "19555",
  "txhash": "FC58F52F49E91808A4751E5A5603C34489B253F59E40F7058E1CC5E70F036CA1",
  "codespace": "",
  "code": 0,
  "data": "0A130A116372656174652D6465706C6F796D656E74",
  "raw_log": "[{\"events\":[{\"type\":\"akash.v1\",\"attributes\":[{\"key\":\"module\",\"value\":\"deployment\"},{\"key\":\"action\",\"value\":\"deployment-created\"},{\"key\":\"version\",\"value\":\"f2b5e760ca93c53548737d76494db89b08d811f7e9b533aa07fd934bf51d6707\"},{\"key\":\"owner\",\"value\":\"akash1j8s87w3fctz7nlcqtkl5clnc805r240443eksx\"},{\"key\":\"dseq\",\"value\":\"19553\"}]},{\"type\":\"message\",\"attributes\":[{\"key\":\"action\",\"value\":\"create-deployment\"}]}]}]",
  "logs": [
    {
      "msg_index": 0,
      "log": "",
      "events": [
        {
          "type": "akash.v1",
          "attributes": [
            {
              "key": "module",
              "value": "deployment"
            },
            {
              "key": "action",
              "value": "deployment-created"
            },
            {
              "key": "version",
              "value": "f2b5e760ca93c53548737d76494db89b08d811f7e9b533aa07fd934bf51d6707"
            },
            {
              "key": "owner",
              "value": "akash1j8s87w3fctz7nlcqtkl5clnc805r240443eksx"
            },
            {
              "key": "dseq",
              "value": "19553"
            }
          ]
        },
        {
          "type": "message",
          "attributes": [
            {
              "key": "action",
              "value": "create-deployment"
            }
          ]
        }
      ]
    }
  ],
  "info": "",
  "gas_wanted": "200000",
  "gas_used": "53806",
  "tx": null,
  "timestamp": ""
}
```

In this step, you post your deployment, the Akash marketplace matches you with a provider via auction. To create a deployment use akash deployment. The syntax for the deployment is `akash tx deployment create <config-path> --from <key-name>`. 

## Wait for your Lease

You can check the status of your lease by running:

```sh
akash query market lease list --owner $ACCOUNT_ADDRESS --node $AKASH_NODE --state active
```

You should see a response similar to:

```
- lease_id:
    dseq: "19553"
    gseq: 1
    oseq: 1
    owner: akash1j8s87w3fctz7nlcqtkl5clnc805r240443eksx
    provider: akash15ql9ycjkkxhpc2nxtnf78qqjguwzz8gc4ue7wl
  price:
    amount: "186"
    denom: uakt
  state: active
pagination:
  next_key: null
  total: "0"
```

In the above example, we can see that a lease is created using for *186 uakt* or *0.00000186 AKT* per block to execute the container.

For convenience and clarity for future referencing, we can extract the below set of values to shell variables that we will be using to reference the deployment:

| Attribute | Value |
| --- | --- |
| `PROVIDER` | `akash15ql9ycjkkxhpc2nxtnf78qqjguwzz8gc4ue7wl` |
| `DSEQ` | `19553` |
| `OSEQ` | `1` |
| `GSEQ` | `1` |

Verify we have the right values populated by running:

```sh
echo $PROVIDER $DSEQ $OSEQ $GSEQ

akash1ds82uk3pzawavlasc2qd88luewzye2qrcwky7t 19553 1 1
```

## Upload Manifest

Upload the manifest using the values from above step:

```sh
akash provider send-manifest deploy.yml --node $AKASH_NODE --dseq $DSEQ --oseq $OSEQ --gseq $GSEQ --owner $ACCOUNT_ADDRESS --provider $PROVIDER 
```

Your image is deployed, once you uploaded the manifest. You can retrieve the access details by running the below:

```sh
akash provider lease-status --node $AKASH_NODE --dseq $DSEQ --oseq $OSEQ --gseq $GSEQ --provider $PROVIDER --owner $ACCOUNT_ADDRESS
```

You should see a response similar to:

```json
{
  "services": {
    "web": {
      "name": "web",
      "available": 1,
      "total": 1,
      "uris": [
        "6veev7chcfmnclgqklegcc.provider4.akashdev.net"
      ],
      "observed-generation": 0,
      "replicas": 0,
      "updated-replicas": 0,
      "ready-replicas": 0,
      "available-replicas": 0
    }
  },
  "forwarded-ports": {}
}
```

You can access the application by visiting the hostnames mapped to your deployment. In above example, its http://6veev7chcfmnclgqklegcc.provider4.akashdev.net


## Close your deployment

When you are done with your application, close the deployment. This will deprovision your container and stop the token transfer. This is a critical step to conserve both your tokens and testnet server capacity.

Close deployment using deployment by creating a `deployment-close` transaction:

```
akash tx deployment close --node $AKASH_NODE --chain-id $AKASH_CHAIN_ID --dseq $DSEQ --owner $ACCOUNT_ADDRESS --from $KEY_NAME -y
```

You should see a response simlar to below as a confirmation your deployment is closed:

```json
{
  "height": "19913",
  "txhash": "C75A7043C002AA5C6BC5562A8330461B57D6C718EB9FD8BCF916F8D50A8AB1EA",
  "codespace": "",
  "code": 0,
  "data": "0A120A10636C6F73652D6465706C6F796D656E74",
  "raw_log": "[{\"events\":[{\"type\":\"akash.v1\",\"attributes\":[{\"key\":\"module\",\"value\":\"deployment\"},{\"key\":\"action\",\"value\":\"deployment-updated\"},{\"key\":\"version\",\"value\":\"f2b5e760ca93c53548737d76494db89b08d811f7e9b533aa07fd934bf51d6707\"},{\"key\":\"owner\",\"value\":\"akash1j8s87w3fctz7nlcqtkl5clnc805r240443eksx\"},{\"key\":\"dseq\",\"value\":\"19553\"},{\"key\":\"module\",\"value\":\"deployment\"},{\"key\":\"action\",\"value\":\"deployment-closed\"},{\"key\":\"owner\",\"value\":\"akash1j8s87w3fctz7nlcqtkl5clnc805r240443eksx\"},{\"key\":\"dseq\",\"value\":\"19553\"},{\"key\":\"module\",\"value\":\"market\"},{\"key\":\"action\",\"value\":\"order-closed\"},{\"key\":\"owner\",\"value\":\"akash1j8s87w3fctz7nlcqtkl5clnc805r240443eksx\"},{\"key\":\"dseq\",\"value\":\"19553\"},{\"key\":\"gseq\",\"value\":\"1\"},{\"key\":\"oseq\",\"value\":\"1\"},{\"key\":\"module\",\"value\":\"market\"},{\"key\":\"action\",\"value\":\"bid-closed\"},{\"key\":\"owner\",\"value\":\"akash1j8s87w3fctz7nlcqtkl5clnc805r240443eksx\"},{\"key\":\"dseq\",\"value\":\"19553\"},{\"key\":\"gseq\",\"value\":\"1\"},{\"key\":\"oseq\",\"value\":\"1\"},{\"key\":\"provider\",\"value\":\"akash15ql9ycjkkxhpc2nxtnf78qqjguwzz8gc4ue7wl\"},{\"key\":\"price-denom\",\"value\":\"uakt\"},{\"key\":\"price-amount\",\"value\":\"186\"},{\"key\":\"module\",\"value\":\"market\"},{\"key\":\"action\",\"value\":\"lease-closed\"},{\"key\":\"owner\",\"value\":\"akash1j8s87w3fctz7nlcqtkl5clnc805r240443eksx\"},{\"key\":\"dseq\",\"value\":\"19553\"},{\"key\":\"gseq\",\"value\":\"1\"},{\"key\":\"oseq\",\"value\":\"1\"},{\"key\":\"provider\",\"value\":\"akash15ql9ycjkkxhpc2nxtnf78qqjguwzz8gc4ue7wl\"},{\"key\":\"price-denom\",\"value\":\"uakt\"},{\"key\":\"price-amount\",\"value\":\"186\"}]},{\"type\":\"message\",\"attributes\":[{\"key\":\"action\",\"value\":\"close-deployment\"}]}]}]",
  "logs": [
    {
      "msg_index": 0,
      "log": "",
      "events": [
        {
          "type": "akash.v1",
          "attributes": [
            {
              "key": "module",
              "value": "deployment"
            },
            {
              "key": "action",
              "value": "deployment-updated"
            },
            {
              "key": "version",
              "value": "f2b5e760ca93c53548737d76494db89b08d811f7e9b533aa07fd934bf51d6707"
            },
            {
              "key": "owner",
              "value": "akash1j8s87w3fctz7nlcqtkl5clnc805r240443eksx"
            },
            {
              "key": "dseq",
              "value": "19553"
            },
            {
              "key": "module",
              "value": "deployment"
            },
            {
              "key": "action",
              "value": "deployment-closed"
            },
            {
              "key": "owner",
              "value": "akash1j8s87w3fctz7nlcqtkl5clnc805r240443eksx"
            },
            {
              "key": "dseq",
              "value": "19553"
            },
            {
              "key": "module",
              "value": "market"
            },
            {
              "key": "action",
              "value": "order-closed"
            },
            {
              "key": "owner",
              "value": "akash1j8s87w3fctz7nlcqtkl5clnc805r240443eksx"
            },
            {
              "key": "dseq",
              "value": "19553"
            },
            {
              "key": "gseq",
              "value": "1"
            },
            {
              "key": "oseq",
              "value": "1"
            },
            {
              "key": "module",
              "value": "market"
            },
            {
              "key": "action",
              "value": "bid-closed"
            },
            {
              "key": "owner",
              "value": "akash1j8s87w3fctz7nlcqtkl5clnc805r240443eksx"
            },
            {
              "key": "dseq",
              "value": "19553"
            },
            {
              "key": "gseq",
              "value": "1"
            },
            {
              "key": "oseq",
              "value": "1"
            },
            {
              "key": "provider",
              "value": "akash15ql9ycjkkxhpc2nxtnf78qqjguwzz8gc4ue7wl"
            },
            {
              "key": "price-denom",
              "value": "uakt"
            },
            {
              "key": "price-amount",
              "value": "186"
            },
            {
              "key": "module",
              "value": "market"
            },
            {
              "key": "action",
              "value": "lease-closed"
            },
            {
              "key": "owner",
              "value": "akash1j8s87w3fctz7nlcqtkl5clnc805r240443eksx"
            },
            {
              "key": "dseq",
              "value": "19553"
            },
            {
              "key": "gseq",
              "value": "1"
            },
            {
              "key": "oseq",
              "value": "1"
            },
            {
              "key": "provider",
              "value": "akash15ql9ycjkkxhpc2nxtnf78qqjguwzz8gc4ue7wl"
            },
            {
              "key": "price-denom",
              "value": "uakt"
            },
            {
              "key": "price-amount",
              "value": "186"
            }
          ]
        },
        {
          "type": "message",
          "attributes": [
            {
              "key": "action",
              "value": "close-deployment"
            }
          ]
        }
      ]
    }
  ],
  "info": "",
  "gas_wanted": "200000",
  "gas_used": "82675",
  "tx": null,
  "timestamp": ""
}
```
Additionally, you can also query the market to check if your lease is closed:

```
akash query market lease list --owner $ACCOUNT_ADDRESS --node $AKASH_NODE 
```

You should see a response similar to:

```
leases:
- lease_id:
    dseq: "19553"
    gseq: 1
    oseq: 1
    owner: akash1j8s87w3fctz7nlcqtkl5clnc805r240443eksx
    provider: akash15ql9ycjkkxhpc2nxtnf78qqjguwzz8gc4ue7wl
  price:
    amount: "186"
    denom: uakt
  state: closed
pagination:
  next_key: null
  total: "0"
```

As you can notice from the above, you lease will be marked `closed`.
