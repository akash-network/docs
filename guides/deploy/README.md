# Deploy an Application

In this guide, we'll deploy an application on Akash.

## Before We Begin

You'll need to know information about the network you're connecting your node to. See [Choosing a Network](/guides/versions.md) for how to obtain any network-related information.

Make sure to have Akash client installed on your workstation, check [install guide](/guides/install.md) for instructions.

You'll need an account with funds to pay for your deployment. See the [funding guide](/guides/wallet/funding.md) for
creating a key and funding your account.

### Shell Variables Required

We will be using shell variables throughout this guide for convenience and clarity.  Ensure you have the below set of variables defined on your shell, you can use `export VARNAME=...`:

|Name|Description|
|---|---|
|`AKASH_NODE`| Akash network configuration base URL. See [here](/guides/version.md).|
|`AKASH_CHAIN_ID`| Chain ID of the Akash network connecting to. See [here](/guides/version.md).|
|`ACCOUNT_ADDRESS`| The address of your account.  See [here](/guides/wallet/README.md#account-address).|
|`KEY_NAME` | The name of the key you will be deploying from. See [here](/guides/wallet/README.md) if you haven't yet setup a key|
|`KEYRING_BACKEND`| Keyring backend to use for local keys. See [here](/guides/wallet/README.md)|

Verify you have correct `$AKASH_NODE` that you have populated while [configuring the connection](/guides/version) using `export AKASH_NODE=$(curl -s "$AKASH_NET/rpc-nodes.txt" | shuf -n 1)`.

```sh
echo $AKASH_NODE
tcp://rpc-edgenet.akashdev.net:2665

echo $AKASH_CHAIN_ID
akash-edgenet-1
```

Your value may differ depending on the network you're connecting to, `tcp://rpc-edgenet.akashdev.net:2665` and `akash-edgenet-1` are details for edgenet.

Verify you have the key set up and your account has sufficient balances, see the [funding guide](/guides/wallet/funding.md) otherwise:

My local key is named `alice`, the below command should return the name you've used
```sh
echo $KEY_NAME 
alice
```

Populate `ACCOUNT_ADDRESS` from `KEY_NAME` and verify:

```sh
export ACCOUNT_ADDRESS=$(akash keys show $KEY_NAME -a)

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

Please note the balance indicated is is denominated in uAKT (AKT * 10^-6), in the above example, the account has a balance of 93 AKT.

We're now setup to deploy.

## Create the deployment configuration and modify it if desired

Create a deployment configuration [deploy.yml](deploy.yml) to deploy the `quay.io/ovrclk/demo-app` container:

```sh
cat > deploy.yml <<EOF
---
version: "2.0"

services:
  web:
    image: quay.io/ovrclk/demo-app
    expose:
      - port: 80
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
          size: 16Mi
        storage:
          size: 128Mi
  placement:
    westcoast:
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
curl -s https://raw.githubusercontent.com/ovrclk/docs/edgenet/guides/deploy/deploy.yml > deploy.yml
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
akash query market lease list --owner $ACCOUNT_ADDRESS --node $AKASH_NODE
```

You should see a response similar to:

```
- lease_id:
    dseq: "19553"
    gseq: 1
    oseq: 1
    owner: akash1j8s87w3fctz7nlcqtkl5clnc805r240443eksx
    provider: akash15ql9ycjkkxhpc2nxtnf78qqjguwzz8gc4ue7wakash15ql9ycjkkxhpc2nxtnf78qqjguwzz8gc4ue7wll
  price:
    amount: "186"
    denom: uakt
  state: active
pagination:
  next_key: null
  total: "0"
```

In the above example, we can see that a lease is created using the below set of values that we will be using to reference the deployment:

| Attribute | Value |
| --- | --- |
| provider | akash15ql9ycjkkxhpc2nxtnf78qqjguwzz8gc4ue7wl |
| owner | akash1j8s87w3fctz7nlcqtkl5clnc805r240443eksx |
| dseq | 19553 |
| oseq | 1 |
| gseq | 1 |


## Upload Manifest

Upload the manifest using the values from above step:

```
akash provider send-manifest --node $AKASH_NODE --dseq 19553 --oseq 1 --gseq 1 --owner $ACCOUNT_ADDRESS --provider akash15ql9ycjkkxhpc2nxtnf78qqjguwzz8gc4ue7wl deploy.yml
```

Your image is deployed, once you uploaded the manifest. You can retrieve the access details by running the below:

```
akash provider lease-status --node $AKASH_NODE --dseq 19553 --oseq 1 --gseq 1 --provider akash15ql9ycjkkxhpc2nxtnf78qqjguwzz8gc4ue7wl --owner $ACCOUNT_ADDRESS
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


## Shut down deployment

```sh
akash query market lease --owner $ACCOUNT_ADDRESS
```