# Deploy an Application

In this guide, we'll deploy a single-tier web application on Akash. Akash is a permissionless and censorship-resistant cloud network that guarantees sovereignty over your data and your applications. With Akash, you’re in complete control of all aspects of the life cycle of an application with no middleman.

In this guide, we'll setup [Lunie Light](https://github.com/ovrclk/lunie-light), a non-custodial, web wallet for Akash on Akash. Lunie Light is a staking interface for proof-of-stake blockchains in the Cosmos ecosystem — built for speed, simplicity, and ease-of-use.

## Before We Begin

This is a technical guide, best suited to a reader with basic Linux command line knowledge. The audience for this guide is intended for includes:

* Application developers with little or no systems administration experience, wanting to deploy applications on the decentralized cloud.
* System administrators with little or no experience with infrastructure automation, wanting to learn more.
* Infrastructure automation engineers that want to explore decentralized cloud.
* Anyone who wants to get a feel for the current state of the decentralized cloud ecosystem.

We encourage to take a look at [Variables guide](../variables.md) to understand usage of environment variables as well cli flags.

You'll need to know information about the network you're connecting your node to. See [Choosing a Network](/guides/version.md) for how to obtain any network-related information.

Make sure to have Akash client installed on your workstation, check [install guide](../install.md) for instructions.

You'll need an account with funds to pay for your deployment. See the [funding guide](../wallet/funding.md) for creating a key and funding your account.

### Set up your Environment

We will be using shell variables throughout this guide for convenience and clarity. Ensure you have the below set of variables defined on your shell, you can use `export VARNAME=...`:

|Name|Description|
|---|---|
|`AKASH_NODE`| Akash network configuration base URL. See [here](../version.md#RPC-Node).|
|`AKASH_CHAIN_ID`| Chain ID of the Akash network connecting to. See [here](../version.md#Chain-ID).|
|`ACCOUNT_ADDRESS`| The address of your account.  See [here](../wallet/README.md#account-address).|
|`AKASH_KEYRING_BACKEND`| Keyring backend to use for local keys. See [here](../wallet/README.md)|
|`KEY_NAME` | The name of the key you will be deploying from. See [here](../wallet/README.md) if you haven't yet setup a key|

Verify you have correct `$AKASH_NODE`, that you have populated while [configuring the connection](../version.md) using `export AKASH_NODE=$(curl -s "$AKASH_NET/rpc-nodes.txt" | shuf -n 1)`.

```sh
echo $AKASH_NODE $AKASH_CHAIN_ID $AKASH_KEYRING_BACKEND

http://147.75.195.69:26657 edgenet-4 os
```

Your values may differ depending on the network you're connecting to, `http://147.75.195.69:26657` and `edgenet-4` are details for [edgenet](https://github.com/ovrclk/net/tree/master/edgenet).

Verify you have the key set up and your account has sufficient balances, see the [funding guide](../wallet/funding.md) otherwise:

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

Please note the balance indicated is denominated in uAKT (AKT x 10^-6), in the above example, the account has a balance of *93 AKT*. We're now setup to deploy.

{% hint style="warn" %}

Your account must have a minimum balance of 5 AKT to create a deployment. This 5 AKT funds the escrow account associated with the deployment and is used to pay the provider for their services. It is recommended you have more than this minimum balance to pay for transaction fees. For more information on escrow accounts, see [here](/design/escrow.md)

{% endhint %}

## Create The Deployment Configuration 

Create a deployment configuration [deploy.yml](deploy.yml) to deploy the `ovrclk/lunie-light` for [Lunie Light](https://github.com/ovrclk/lunie-light) Node app container using [SDL](/sdl/README.md):

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
        host: akash
      signedBy:
        anyOf:
          - "akash1365yvmc4s7awdyj3n2sav7xfx76adc6dnmlx63"
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

### Mainnet - Audited Attributes

On the `akashnet-2` network, to ensure tenants have smooth and reliable service from their provider, it is recommended to use the following audited attributes in their deployment:

```sh
      attributes:
        host: akash
      signedBy:
       anyOf:
        - "akash1365yvmc4s7awdyj3n2sav7xfx76adc6dnmlx63"
```
--or--

```sh
      attributes:
        datacenter: equinix-metal-ewr1
      signedBy:
       anyOf:
        - "akash1365yvmc4s7awdyj3n2sav7xfx76adc6dnmlx63"
```

Please note that all of the following can be substituted in the `datacenter` field above and should be chosen based on your needs:

|Datacenter|Location|
|---|---|
|`equinix-metal-ewr1`| New Jersey, United States|
|`equinix-metal-sjc1`| California, United States|


## Create the Deployment

To create a deployment, a [certificate](/design/mtls.md) must first be created. To do this, run:

```
akash tx cert create client --chain-id $AKASH_CHAIN_ID --keyring-backend $AKASH_KEYRING_BACKEND --from $KEY_NAME --node $AKASH_NODE --fees 5000uakt
```

You should see a response similar to:
```json
{
  "body": {
    "messages": [
      {
        "@type": "/akash.cert.v1beta1.MsgCreateCertificate",
        "owner": "akash1vns5ka3x69ekm3ecp8my8d5zfu8j23p5qew0w3",
        "cert": "LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSUJ3RENDQVdXZ0F3SUJBZ0lJRm1pcUJWcWZDVmt3Q2dZSUtvWkl6ajBFQXdJd1NqRTFNRE1HQTFVRUF4TXMKWVd0aGMyZ3hkbTV6Tld0aE0zZzJPV1ZyYlRObFkzQTRiWGs0WkRWNlpuVTRhakl6Y0RWeFpYY3dkek14RVRBUApCZ1ZuZ1FVQ0JoTUdkakF1TUM0eE1CNFhEVEl4TURNd01qSXpNak15TmxvWERUSXlNRE13TWpJek1qTXlObG93ClNqRTFNRE1HQTFVRUF4TXNZV3RoYzJneGRtNXpOV3RoTTNnMk9XVnJiVE5sWTNBNGJYazRaRFY2Wm5VNGFqSXoKY0RWeFpYY3dkek14RVRBUEJnVm5nUVVDQmhNR2RqQXVNQzR4TUZrd0V3WUhLb1pJemowQ0FRWUlLb1pJemowRApBUWNEUWdBRUtaSTlmWGVPVzRCYXRwcU1mb1VTekx2b01lWGlpbEZTMnJhZlhKdUNObUlMVjJMaWhIZW5JdjJTCjV5Uzh1Zkh5QmNMSUI5aFE1VE81THRHSUpPdzIvYU0xTURNd0RnWURWUjBQQVFIL0JBUURBZ1F3TUJNR0ExVWQKSlFRTU1Bb0dDQ3NHQVFVRkJ3TUNNQXdHQTFVZEV3RUIvd1FDTUFBd0NnWUlLb1pJemowRUF3SURTUUF3UmdJaApBSjJzQ3ZodGNzWkRXUkQ2MU03ZkVCRUk5eEt5Z0UzRkd3K2tIYVhZYXl0TUFpRUE4cUZtb3FEc1Z0ZzhPSHc1Ck5iOEljd0hiNHVkc0RpTzRxaWhoL0owNWZKaz0KLS0tLS1FTkQgQ0VSVElGSUNBVEUtLS0tLQo=",
        "pubkey": "LS0tLS1CRUdJTiBFQyBQVUJMSUMgS0VZLS0tLS0KTUZrd0V3WUhLb1pJemowQ0FRWUlLb1pJemowREFRY0RRZ0FFS1pJOWZYZU9XNEJhdHBxTWZvVVN6THZvTWVYaQppbEZTMnJhZlhKdUNObUlMVjJMaWhIZW5JdjJTNXlTOHVmSHlCY0xJQjloUTVUTzVMdEdJSk93Mi9RPT0KLS0tLS1FTkQgRUMgUFVCTElDIEtFWS0tLS0tCg=="
      }
    ],
    "memo": "",
    "timeout_height": "0",
    "extension_options": [],
    "non_critical_extension_options": []
  },
  "auth_info": {
    "signer_infos": [],
    "fee": {
      "amount": [],
      "gas_limit": "200000",
      "payer": "",
      "granter": ""
    }
  },
  "signatures": []
}
```

:warning: **certificate needs to be created only once per account** and can be used across all deployments.   

To deploy on Akash, run:

```sh
akash tx deployment create deploy.yml --from $KEY_NAME --node $AKASH_NODE --chain-id $AKASH_CHAIN_ID --fees 5000uakt -y
```
    
You should see a response similar to:
```json
{
  "height":"140325",
  "txhash":"2AF4A01B9C3DE12CC4094A95E9D0474875DFE24FD088BB443238AC06E36D98EA",
  "codespace":"",
  "code":0,
  "data":"0A130A116372656174652D6465706C6F796D656E74",
  "raw_log":"[{\"events\":[{\"type\":\"akash.v1\",\"attributes\":[{\"key\":\"module\",\"value\":\"deployment\"},{\"key\":\"action\",\"value\":\"deployment-created\"},{\"key\":\"version\",\"value\":\"2b86f778de8cc9df415490efa162c58e7a0c297fbac9cdb8d6c6600eda56f17e\"},{\"key\":\"owner\",\"value\":\"akash1vn06ycjjnvsvl639fet9lajjctuturrtx7fvuj\"},{\"key\":\"dseq\",\"value\":\"140324\"},{\"key\":\"module\",\"value\":\"market\"},{\"key\":\"action\",\"value\":\"order-created\"},{\"key\":\"owner\",\"value\":\"akash1vn06ycjjnvsvl639fet9lajjctuturrtx7fvuj\"},{\"key\":\"dseq\",\"value\":\"140324\"},{\"key\":\"gseq\",\"value\":\"1\"},{\"key\":\"oseq\",\"value\":\"1\"}]},{\"type\":\"message\",\"attributes\":[{\"key\":\"action\",\"value\":\"create-deployment\"},{\"key\":\"sender\",\"value\":\"akash1vn06ycjjnvsvl639fet9lajjctuturrtx7fvuj\"},{\"key\":\"sender\",\"value\":\"akash1vn06ycjjnvsvl639fet9lajjctuturrtx7fvuj\"}]},{\"type\":\"transfer\",\"attributes\":[{\"key\":\"recipient\",\"value\":\"akash17xpfvakm2amg962yls6f84z3kell8c5lazw8j8\"},{\"key\":\"sender\",\"value\":\"akash1vn06ycjjnvsvl639fet9lajjctuturrtx7fvuj\"},{\"key\":\"amount\",\"value\":\"5000uakt\"},{\"key\":\"recipient\",\"value\":\"akash14pphss726thpwws3yc458hggufynm9x77l4l2u\"},{\"key\":\"sender\",\"value\":\"akash1vn06ycjjnvsvl639fet9lajjctuturrtx7fvuj\"},{\"key\":\"amount\",\"value\":\"5000000uakt\"}]}]}]",
  "logs":[
    {
      "msg_index":0,
      "log":"",
      "events":[
        {
          "type":"akash.v1",
          "attributes":[
            {
              "key":"module",
              "value":"deployment"
            },
            {
              "key":"action",
              "value":"deployment-created"
            },
            {
              "key":"version",
              "value":"2b86f778de8cc9df415490efa162c58e7a0c297fbac9cdb8d6c6600eda56f17e"
            },
            {
              "key":"owner",
              "value":"akash1vn06ycjjnvsvl639fet9lajjctuturrtx7fvuj"
            },
            {
              "key":"dseq",
              "value":"140324"
            },
            {
              "key":"module",
              "value":"market"
            },
            {
              "key":"action",
              "value":"order-created"
            },
            {
              "key":"owner",
              "value":"akash1vn06ycjjnvsvl639fet9lajjctuturrtx7fvuj"
            },
            {
              "key":"dseq",
              "value":"140324"
            },
            {
              "key":"gseq",
              "value":"1"
            },
            {
              "key":"oseq",
              "value":"1"
            }
          ]
        },
        {
          "type":"message",
          "attributes":[
            {
              "key":"action",
              "value":"create-deployment"
            },
            {
              "key":"sender",
              "value":"akash1vn06ycjjnvsvl639fet9lajjctuturrtx7fvuj"
            },
            {
              "key":"sender",
              "value":"akash1vn06ycjjnvsvl639fet9lajjctuturrtx7fvuj"
            }
          ]
        },
        {
          "type":"transfer",
          "attributes":[
            {
              "key":"recipient",
              "value":"akash17xpfvakm2amg962yls6f84z3kell8c5lazw8j8"
            },
            {
              "key":"sender",
              "value":"akash1vn06ycjjnvsvl639fet9lajjctuturrtx7fvuj"
            },
            {
              "key":"amount",
              "value":"5000uakt"
            },
            {
              "key":"recipient",
              "value":"akash14pphss726thpwws3yc458hggufynm9x77l4l2u"
            },
            {
              "key":"sender",
              "value":"akash1vn06ycjjnvsvl639fet9lajjctuturrtx7fvuj"
            },
            {
              "key":"amount",
              "value":"5000000uakt"
            }
          ]
        }
      ]
    }
  ],
  "info":"",
  "gas_wanted":"200000",
  "gas_used":"94653",
  "tx":null,
  "timestamp":""
}
```
For convenience and clarity for future referencing, we can extract the below set of values to shell variables that we will be using to reference the deployment:

| Attribute | Value |
| --- | --- |
| `DSEQ` | `140324` |
| `OSEQ` | `1` |
| `GSEQ` | `1` |

Verify we have the right values populated by running:

```sh
echo $DSEQ $OSEQ $GSEQ

140324 1 1 
```

In this step, you post your deployment, the Akash marketplace matches you with a provider via auction. To create a deployment use akash deployment. The syntax for the deployment is `akash tx deployment create <config-path> --from <key-name>`.

## Verify Deployment Creation

Check that the deployment was created by running:

```sh
akash query deployment get --owner $ACCOUNT_ADDRESS --node $AKASH_NODE --dseq $DSEQ
```
You should see a response similar to:
```sh
deployment:
  created_at: "140325"
  deployment_id:
    dseq: "140324"
    owner: akash1vn06ycjjnvsvl639fet9lajjctuturrtx7fvuj
  state: active
  version: K4b3eN6Myd9BVJDvoWLFjnoMKX+6yc241sZgDtpW8X4=
escrow_account:
  balance:
    amount: "5000000"
    denom: uakt
  id:
    scope: deployment
    xid: akash1vn06ycjjnvsvl639fet9lajjctuturrtx7fvuj/140324
  owner: akash1vn06ycjjnvsvl639fet9lajjctuturrtx7fvuj
  settled_at: "140325"
  state: open
  transferred:
    amount: "0"
    denom: uakt
groups:
- created_at: "140325"
  group_id:
    dseq: "140324"
    gseq: 1
    owner: akash1vn06ycjjnvsvl639fet9lajjctuturrtx7fvuj
  group_spec:
    name: westcoast
    requirements:
      attributes:
      - key: host
        value: akash
      signed_by:
        all_of: []
        any_of:
        - akash1365yvmc4s7awdyj3n2sav7xfx76adc6dnmlx63
    resources:
    - count: 1
      price:
        amount: "1000"
        denom: uakt
      resources:
        cpu:
          attributes: []
          units:
            val: "100"
        endpoints:
        - kind: SHARED_HTTP
        memory:
          attributes: []
          quantity:
            val: "536870912"
        storage:
          attributes: []
          quantity:
            val: "536870912"
  state: open
```

## Verify Order Creation

After a short time, you should see an order created for this deployment with the following command:

```sh
akash query market order get --node $AKASH_NODE --owner $ACCOUNT_ADDRESS --dseq $DSEQ --oseq $OSEQ --gseq $GSEQ
```

You should see a response similar to:

```
created_at: "140325"
order_id:
  dseq: "140324"
  gseq: 1
  oseq: 1
  owner: akash1vn06ycjjnvsvl639fet9lajjctuturrtx7fvuj
spec:
  name: westcoast
  requirements:
    attributes:
    - key: host
      value: akash
    signed_by:
      all_of: []
      any_of:
      - akash1365yvmc4s7awdyj3n2sav7xfx76adc6dnmlx63
  resources:
  - count: 1
    price:
      amount: "1000"
      denom: uakt
    resources:
      cpu:
        attributes: []
        units:
          val: "100"
      endpoints:
      - kind: SHARED_HTTP
      memory:
        attributes: []
        quantity:
          val: "536870912"
      storage:
        attributes: []
        quantity:
          val: "536870912"
state: open
```

## View your Bids

After a short time, you should see bids from providers for this deployment with the following command:

```sh
akash query market bid list --owner=$ACCOUNT_ADDRESS --node $AKASH_NODE --dseq $DSEQ
```

You should see a response similar to:

```
bids:
- bid:
    bid_id:
      dseq: "140324"
      gseq: 1
      oseq: 1
      owner: akash1vn06ycjjnvsvl639fet9lajjctuturrtx7fvuj
      provider: akash10cl5rm0cqnpj45knzakpa4cnvn5amzwp4lhcal
    created_at: "140326"
    price:
      amount: "1"
      denom: uakt
    state: open
  escrow_account:
    balance:
      amount: "50000000"
      denom: uakt
    id:
      scope: bid
      xid: akash1vn06ycjjnvsvl639fet9lajjctuturrtx7fvuj/140324/1/1/akash10cl5rm0cqnpj45knzakpa4cnvn5amzwp4lhcal
    owner: akash10cl5rm0cqnpj45knzakpa4cnvn5amzwp4lhcal
    settled_at: "140326"
    state: open
    transferred:
      amount: "0"
      denom: uakt
- bid:
    bid_id:
      dseq: "140324"
      gseq: 1
      oseq: 1
      owner: akash1vn06ycjjnvsvl639fet9lajjctuturrtx7fvuj
      provider: akash1f6gmtjpx4r8qda9nxjwq26fp5mcjyqmaq5m6j7
    created_at: "140326"
    price:
      amount: "1"
      denom: uakt
    state: open
  escrow_account:
    balance:
      amount: "50000000"
      denom: uakt
    id:
      scope: bid
      xid: akash1vn06ycjjnvsvl639fet9lajjctuturrtx7fvuj/140324/1/1/akash1f6gmtjpx4r8qda9nxjwq26fp5mcjyqmaq5m6j7
    owner: akash1f6gmtjpx4r8qda9nxjwq26fp5mcjyqmaq5m6j7
    settled_at: "140326"
    state: open
    transferred:
      amount: "0"
      denom: uakt

```

Note that there are bids from multiple different providers.  In this case, both providers happen to be willing to accept a price of *1 uAKT*. This means that the lease can be created using *1 uAKT* or *0.000001 AKT* per block to execute the container.

For this example, we will choose `akash1f6gmtjpx4r8qda9nxjwq26fp5mcjyqmaq5m6j7`.

For convenience and clarity for future referencing, we can extract the below value to a shell variable that we will be using to reference the deployment:

| Attribute | Value |
| --- | --- |
| `PROVIDER` | `akash1f6gmtjpx4r8qda9nxjwq26fp5mcjyqmaq5m6j7` |

Verify we have the right value populated by running:

```sh
echo $PROVIDER

akash1f6gmtjpx4r8qda9nxjwq26fp5mcjyqmaq5m6j7 
```

## Create your Lease

Create a lease for the bid from the chosen provider above by running:

```sh
akash tx market lease create --chain-id $AKASH_CHAIN_ID --node $AKASH_NODE --owner $ACCOUNT_ADDRESS --dseq $DSEQ --gseq $GSEQ --oseq $OSEQ --provider $PROVIDER --from $KEY_NAME --fees 5000uakt
```

After confirming your transaction, you should see a response similar to:

```json
              "key":"sender",
              "value":"akash1vn06ycjjnvsvl639fet9lajjctuturrtx7fvuj"
            },
            {
              "key":"sender",
              "value":"akash14pphss726thpwws3yc458hggufynm9x77l4l2u"
            }
          ]
        },
        {
          "type":"transfer",
          "attributes":[
            {
              "key":"recipient",
              "value":"akash17xpfvakm2amg962yls6f84z3kell8c5lazw8j8"
            },
            {
              "key":"sender",
              "value":"akash1vn06ycjjnvsvl639fet9lajjctuturrtx7fvuj"
            },
            {
              "key":"amount",
              "value":"5000uakt"
            },
            {
              "key":"recipient",
              "value":"akash10cl5rm0cqnpj45knzakpa4cnvn5amzwp4lhcal"
            },
            {
              "key":"sender",
              "value":"akash14pphss726thpwws3yc458hggufynm9x77l4l2u"
            },
            {
              "key":"amount",
              "value":"50000000uakt"
            }
          ]
        }
      ]
    }
  ],
  "info":"",
  "gas_wanted":"200000",
  "gas_used":"131168",
  "tx":null,
  "timestamp":""
}
```

## Wait for your Lease

You can check the status of your lease by running:

```sh
akash query market lease list --owner $ACCOUNT_ADDRESS --node $AKASH_NODE --dseq $DSEQ
```

You should see a response similar to:

```
leases:
- escrow_payment:
    account_id:
      scope: deployment
      xid: akash1vn06ycjjnvsvl639fet9lajjctuturrtx7fvuj/140324
    balance:
      amount: "0"
      denom: uakt
    owner: akash1f6gmtjpx4r8qda9nxjwq26fp5mcjyqmaq5m6j7
    payment_id: 1/1/akash1f6gmtjpx4r8qda9nxjwq26fp5mcjyqmaq5m6j7
    rate:
      amount: "1"
      denom: uakt
    state: open
    withdrawn:
      amount: "0"
      denom: uakt
  lease:
    created_at: "141415"
    lease_id:
      dseq: "140324"
      gseq: 1
      oseq: 1
      owner: akash1vn06ycjjnvsvl639fet9lajjctuturrtx7fvuj
      provider: akash1f6gmtjpx4r8qda9nxjwq26fp5mcjyqmaq5m6j7
    price:
      amount: "1"
      denom: uakt
    state: active
```

{% hint style="warn" %}

Please note that once the lease is created, the provider will begin debiting your deployment's escrow account, even if you have not completed the deployment process by uploading the manifest in the following step. 

{% endhint %}

## Upload Manifest

Upload the manifest using the values from above step:

```sh
akash provider send-manifest deploy.yml --node $AKASH_NODE --dseq $DSEQ --provider $PROVIDER --home ~/.akash --from $KEY_NAME 
```

You should expect no output from the above command.

Now that the manifest is uploaded, your image is deployed. You can retrieve the access details by running the below:

```sh
akash provider lease-status --node $AKASH_NODE --home ~/.akash --dseq $DSEQ --from $KEY_NAME --provider $PROVIDER
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
        "rga3h05jetf9h3p6dbk62m19ck.ingress.ewr1p0.mainnet.akashian.io"
      ],
      "observed_generation": 1,
      "replicas": 1,
      "updated_replicas": 1,
      "ready_replicas": 1,
      "available_replicas": 1
    }
  },
  "forwarded_ports": {}
}
```

You can access the application by visiting the hostnames mapped to your deployment. In above example, its http://rga3h05jetf9h3p6dbk62m19ck.ingress.ewr1p0.mainnet.akashian.io

## Update your deployment

Updating active deployments is a two-step process. First, edit your deployment YAML file with the desired changes.

{% hint style="warn" %}

Akash Groups are translated into Kubernetes Deployments, this means that only a few fields from the Akash SDL are mutable. For example image, command, args, env and exposed ports can be modified, but compute resources and placement criteria cannot. 

{% endhint %}

  1. Update your deployment by running:
  ```sh
  akash tx deployment update deploy.yml --dseq $DSEQ --from $KEY_NAME --chain-id $AKASH_CHAIN_ID --node $AKASH_NODE --fees=5000uakt
  ```
  After confirming your transaction, you should see a response similar to this:
  ```json
  {
  "height":"98503",
  "txhash":"94FEF5ACB39145BB41ECB1FC224480ED5C80414D0757FC07C844B16EC246D304",
  "codespace":"",
  "code":0,
  "data":"0A130A117570646174652D6465706C6F796D656E74",
  "raw_log":"[{\"events\":[{\"type\":\"akash.v1\",\"attributes\":[{\"key\":\"module\",\"value\":\"deployment\"},{\"key\":\"action\",\"value\":\"deployment-updated\"},{\"key\":\"version\",\"value\":\"2b86f778de8cc9df415490efa162c58e7a0c297fbac9cdb8d6c6600eda56f17e\"},{\"key\":\"owner\",\"value\":\"akash1vn06ycjjnvsvl639fet9lajjctuturrtx7fvuj\"},{\"key\":\"dseq\",\"value\":\"98199\"}]},{\"type\":\"message\",\"attributes\":[{\"key\":\"action\",\"value\":\"update-deployment\"},{\"key\":\"sender\",\"value\":\"akash1vn06ycjjnvsvl639fet9lajjctuturrtx7fvuj\"}]},{\"type\":\"transfer\",\"attributes\":[{\"key\":\"recipient\",\"value\":\"akash17xpfvakm2amg962yls6f84z3kell8c5lazw8j8\"},{\"key\":\"sender\",\"value\":\"akash1vn06ycjjnvsvl639fet9lajjctuturrtx7fvuj\"},{\"key\":\"amount\",\"value\":\"5000uakt\"}]}]}]",
  "logs":[
    {
      "msg_index":0,
      "log":"",
      "events":[
        {
          "type":"akash.v1",
          "attributes":[
            {
              "key":"module",
              "value":"deployment"
            },
            {
              "key":"action",
              "value":"deployment-updated"
            },
            {
              "key":"version",
              "value":"2b86f778de8cc9df415490efa162c58e7a0c297fbac9cdb8d6c6600eda56f17e"
            },
            {
              "key":"owner",
              "value":"akash1vn06ycjjnvsvl639fet9lajjctuturrtx7fvuj"
            },
            {
              "key":"dseq",
              "value":"98199"
            }
          ]
        },
        {
          "type":"message",
          "attributes":[
            {
              "key":"action",
              "value":"update-deployment"
            },
            {
              "key":"sender",
              "value":"akash1vn06ycjjnvsvl639fet9lajjctuturrtx7fvuj"
            }
          ]
        },
        {
          "type":"transfer",
          "attributes":[
            {
              "key":"recipient",
              "value":"akash17xpfvakm2amg962yls6f84z3kell8c5lazw8j8"
            },
            {
              "key":"sender",
              "value":"akash1vn06ycjjnvsvl639fet9lajjctuturrtx7fvuj"
            },
            {
              "key":"amount",
              "value":"5000uakt"
            }
          ]
        }
      ]
    }
  ],
  "info":"",
  "gas_wanted":"200000",
  "gas_used":"58833",
  "tx":null,
  "timestamp":""
}
  ```

  Note the `code: 0` shown in the successful deployment update output above.


  2. Send the updated manifest by running:
  ```sh
  akash provider send-manifest deploy.yml --keyring-backend=$AKASH_KEYRING_BACKEND --node $AKASH_NODE --from=$KEY_NAME --provider=$PROVIDER --dseq $DSEQ --log_level=info --home ~/.akash
  ```

Between the first and second step, the prior deployment's containers will continue to run until the new manifest file is received, validated, and new container group operational. After health checks on updated group are passing; the prior containers will be terminated - this process may take a couple minutes to complete.

## Add funds to your Deployment

You will eventually need to add funds to the escrow account associated with your deployment to keep it running.  If the account becomes overdrawn due to lack of funds, the deployment will permanently close and require you to complete the deploy process again.  This in turn will also assign a new, random URI for the deployment.

Deposit additional funds to your escrow account by running:

```sh
akash tx deployment deposit --from $KEY_NAME --chain-id $CHAIN_ID --keyring-backend=$AKASH_KEYRING_BACKEND --node $AKASH_NODE 10000uakt --dseq $DSEQ --fees=5000uakt
```

After confirming the transaction, you should see a response similar to:

```json
{
  "height":"141905",
  "txhash":"DBB5AE97701172506B46B59C46095BC17CF4474E07AABF912D43DC36F57B1E69",
  "codespace":"",
  "code":0,
  "data":"0A140A126465706F7369742D6465706C6F796D656E74",
  "raw_log":"[{\"events\":[{\"type\":\"message\",\"attributes\":[{\"key\":\"action\",\"value\":\"deposit-deployment\"},{\"key\":\"sender\",\"value\":\"akash1vn06ycjjnvsvl639fet9lajjctuturrtx7fvuj\"},{\"key\":\"sender\",\"value\":\"akash1vn06ycjjnvsvl639fet9lajjctuturrtx7fvuj\"}]},{\"type\":\"transfer\",\"attributes\":[{\"key\":\"recipient\",\"value\":\"akash17xpfvakm2amg962yls6f84z3kell8c5lazw8j8\"},{\"key\":\"sender\",\"value\":\"akash1vn06ycjjnvsvl639fet9lajjctuturrtx7fvuj\"},{\"key\":\"amount\",\"value\":\"5000uakt\"},{\"key\":\"recipient\",\"value\":\"akash14pphss726thpwws3yc458hggufynm9x77l4l2u\"},{\"key\":\"sender\",\"value\":\"akash1vn06ycjjnvsvl639fet9lajjctuturrtx7fvuj\"},{\"key\":\"amount\",\"value\":\"10000uakt\"}]}]}]",
  "logs":[
    {
      "msg_index":0,
      "log":"",
      "events":[
        {
          "type":"message",
          "attributes":[
            {
              "key":"action",
              "value":"deposit-deployment"
            },
            {
              "key":"sender",
              "value":"akash1vn06ycjjnvsvl639fet9lajjctuturrtx7fvuj"
            },
            {
              "key":"sender",
              "value":"akash1vn06ycjjnvsvl639fet9lajjctuturrtx7fvuj"
            }
          ]
        },
        {
          "type":"transfer",
          "attributes":[
            {
              "key":"recipient",
              "value":"akash17xpfvakm2amg962yls6f84z3kell8c5lazw8j8"
            },
            {
              "key":"sender",
              "value":"akash1vn06ycjjnvsvl639fet9lajjctuturrtx7fvuj"
            },
            {
              "key":"amount",
              "value":"5000uakt"
            },
            {
              "key":"recipient",
              "value":"akash14pphss726thpwws3yc458hggufynm9x77l4l2u"
            },
            {
              "key":"sender",
              "value":"akash1vn06ycjjnvsvl639fet9lajjctuturrtx7fvuj"
            },
            {
              "key":"amount",
              "value":"10000uakt"
            }
          ]
        }
      ]
    }
  ],
  "info":"",
  "gas_wanted":"200000",
  "gas_used":"71665",
  "tx":null,
  "timestamp":""
}
```

## Close your deployment

When you are done with your application, close the deployment. This will deprovision your container and stop the token transfer. This is a critical step to conserve both your tokens and testnet server capacity.

Close deployment using deployment by creating a `deployment-close` transaction:

```
akash tx deployment close --node $AKASH_NODE --chain-id $AKASH_CHAIN_ID --dseq $DSEQ  --owner $ACCOUNT_ADDRESS --from $KEY_NAME --keyring-backend $AKASH_KEYRING_BACKEND -y --fees 5000uakt
```

You should see a response simlar to below as a confirmation your deployment is closed:

```json
{
  "height":"141928",
  "txhash":"406B359910E4AD0944DA3C00D66B79179849B1A894C73A8CAA3CA0D93E44A1AA",
  "codespace":"",
  "code":0,
  "data":"0A120A10636C6F73652D6465706C6F796D656E74",
  "raw_log":"[{\"events\":[{\"type\":\"akash.v1\",\"attributes\":[{\"key\":\"module\",\"value\":\"deployment\"},{\"key\":\"action\",\"value\":\"deployment-closed\"},{\"key\":\"owner\",\"value\":\"akash1vn06ycjjnvsvl639fet9lajjctuturrtx7fvuj\"},{\"key\":\"dseq\",\"value\":\"140324\"},{\"key\":\"module\",\"value\":\"deployment\"},{\"key\":\"action\",\"value\":\"group-closed\"},{\"key\":\"owner\",\"value\":\"akash1vn06ycjjnvsvl639fet9lajjctuturrtx7fvuj\"},{\"key\":\"dseq\",\"value\":\"140324\"},{\"key\":\"gseq\",\"value\":\"1\"},{\"key\":\"module\",\"value\":\"market\"},{\"key\":\"action\",\"value\":\"order-closed\"},{\"key\":\"owner\",\"value\":\"akash1vn06ycjjnvsvl639fet9lajjctuturrtx7fvuj\"},{\"key\":\"dseq\",\"value\":\"140324\"},{\"key\":\"gseq\",\"value\":\"1\"},{\"key\":\"oseq\",\"value\":\"1\"},{\"key\":\"module\",\"value\":\"market\"},{\"key\":\"action\",\"value\":\"bid-closed\"},{\"key\":\"owner\",\"value\":\"akash1vn06ycjjnvsvl639fet9lajjctuturrtx7fvuj\"},{\"key\":\"dseq\",\"value\":\"140324\"},{\"key\":\"gseq\",\"value\":\"1\"},{\"key\":\"oseq\",\"value\":\"1\"},{\"key\":\"provider\",\"value\":\"akash1f6gmtjpx4r8qda9nxjwq26fp5mcjyqmaq5m6j7\"},{\"key\":\"price-denom\",\"value\":\"uakt\"},{\"key\":\"price-amount\",\"value\":\"1\"},{\"key\":\"module\",\"value\":\"market\"},{\"key\":\"action\",\"value\":\"lease-closed\"},{\"key\":\"owner\",\"value\":\"akash1vn06ycjjnvsvl639fet9lajjctuturrtx7fvuj\"},{\"key\":\"dseq\",\"value\":\"140324\"},{\"key\":\"gseq\",\"value\":\"1\"},{\"key\":\"oseq\",\"value\":\"1\"},{\"key\":\"provider\",\"value\":\"akash1f6gmtjpx4r8qda9nxjwq26fp5mcjyqmaq5m6j7\"},{\"key\":\"price-denom\",\"value\":\"uakt\"},{\"key\":\"price-amount\",\"value\":\"1\"}]},{\"type\":\"message\",\"attributes\":[{\"key\":\"action\",\"value\":\"close-deployment\"},{\"key\":\"sender\",\"value\":\"akash1vn06ycjjnvsvl639fet9lajjctuturrtx7fvuj\"},{\"key\":\"sender\",\"value\":\"akash14pphss726thpwws3yc458hggufynm9x77l4l2u\"},{\"key\":\"sender\",\"value\":\"akash14pphss726thpwws3yc458hggufynm9x77l4l2u\"},{\"key\":\"sender\",\"value\":\"akash14pphss726thpwws3yc458hggufynm9x77l4l2u\"}]},{\"type\":\"transfer\",\"attributes\":[{\"key\":\"recipient\",\"value\":\"akash17xpfvakm2amg962yls6f84z3kell8c5lazw8j8\"},{\"key\":\"sender\",\"value\":\"akash1vn06ycjjnvsvl639fet9lajjctuturrtx7fvuj\"},{\"key\":\"amount\",\"value\":\"5000uakt\"},{\"key\":\"recipient\",\"value\":\"akash1vn06ycjjnvsvl639fet9lajjctuturrtx7fvuj\"},{\"key\":\"sender\",\"value\":\"akash14pphss726thpwws3yc458hggufynm9x77l4l2u\"},{\"key\":\"amount\",\"value\":\"5009487uakt\"},{\"key\":\"recipient\",\"value\":\"akash1f6gmtjpx4r8qda9nxjwq26fp5mcjyqmaq5m6j7\"},{\"key\":\"sender\",\"value\":\"akash14pphss726thpwws3yc458hggufynm9x77l4l2u\"},{\"key\":\"amount\",\"value\":\"513uakt\"},{\"key\":\"recipient\",\"value\":\"akash1f6gmtjpx4r8qda9nxjwq26fp5mcjyqmaq5m6j7\"},{\"key\":\"sender\",\"value\":\"akash14pphss726thpwws3yc458hggufynm9x77l4l2u\"},{\"key\":\"amount\",\"value\":\"50000000uakt\"}]}]}]",
  "logs":[
    {
      "msg_index":0,
      "log":"",
      "events":[
        {
          "type":"akash.v1",
          "attributes":[
            {
              "key":"module",
              "value":"deployment"
            },
            {
              "key":"action",
              "value":"deployment-closed"
            },
            {
              "key":"owner",
              "value":"akash1vn06ycjjnvsvl639fet9lajjctuturrtx7fvuj"
            },
            {
              "key":"dseq",
              "value":"140324"
            },
            {
              "key":"module",
              "value":"deployment"
            },
            {
              "key":"action",
              "value":"group-closed"
            },
            {
              "key":"owner",
              "value":"akash1vn06ycjjnvsvl639fet9lajjctuturrtx7fvuj"
            },
            {
              "key":"dseq",
              "value":"140324"
            },
            {
              "key":"gseq",
              "value":"1"
            },
            {
              "key":"module",
              "value":"market"
            },
            {
              "key":"action",
              "value":"order-closed"
            },
            {
              "key":"owner",
              "value":"akash1vn06ycjjnvsvl639fet9lajjctuturrtx7fvuj"
            },
            {
              "key":"dseq",
              "value":"140324"
            },
            {
              "key":"gseq",
              "value":"1"
            },
            {
              "key":"oseq",
              "value":"1"
            },
            {
              "key":"module",
              "value":"market"
            },
            {
              "key":"action",
              "value":"bid-closed"
            },
            {
              "key":"owner",
              "value":"akash1vn06ycjjnvsvl639fet9lajjctuturrtx7fvuj"
            },
            {
              "key":"dseq",
              "value":"140324"
            },
            {
              "key":"gseq",
              "value":"1"
            },
            {
              "key":"oseq",
              "value":"1"
            },
            {
              "key":"provider",
              "value":"akash1f6gmtjpx4r8qda9nxjwq26fp5mcjyqmaq5m6j7"
            },
            {
              "key":"price-denom",
              "value":"uakt"
            },
            {
              "key":"price-amount",
              "value":"1"
            },
            {
              "key":"module",
              "value":"market"
            },
            {
              "key":"action",
              "value":"lease-closed"
            },
            {
              "key":"owner",
              "value":"akash1vn06ycjjnvsvl639fet9lajjctuturrtx7fvuj"
            },
            {
              "key":"dseq",
              "value":"140324"
            },
            {
              "key":"gseq",
              "value":"1"
            },
            {
              "key":"oseq",
              "value":"1"
            },
            {
              "key":"provider",
              "value":"akash1f6gmtjpx4r8qda9nxjwq26fp5mcjyqmaq5m6j7"
            },
            {
              "key":"price-denom",
              "value":"uakt"
            },
            {
              "key":"price-amount",
              "value":"1"
            }
          ]
        },
        {
          "type":"message",
          "attributes":[
            {
              "key":"action",
              "value":"close-deployment"
            },
            {
              "key":"sender",
              "value":"akash1vn06ycjjnvsvl639fet9lajjctuturrtx7fvuj"
            },
            {
              "key":"sender",
              "value":"akash14pphss726thpwws3yc458hggufynm9x77l4l2u"
            },
            {
              "key":"sender",
              "value":"akash14pphss726thpwws3yc458hggufynm9x77l4l2u"
            },
            {
              "key":"sender",
              "value":"akash14pphss726thpwws3yc458hggufynm9x77l4l2u"
            }
          ]
        },
        {
          "type":"transfer",
          "attributes":[
            {
              "key":"recipient",
              "value":"akash17xpfvakm2amg962yls6f84z3kell8c5lazw8j8"
            },
            {
              "key":"sender",
              "value":"akash1vn06ycjjnvsvl639fet9lajjctuturrtx7fvuj"
            },
            {
              "key":"amount",
              "value":"5000uakt"
            },
            {
              "key":"recipient",
              "value":"akash1vn06ycjjnvsvl639fet9lajjctuturrtx7fvuj"
            },
            {
              "key":"sender",
              "value":"akash14pphss726thpwws3yc458hggufynm9x77l4l2u"
            },
            {
              "key":"amount",
              "value":"5009487uakt"
            },
            {
              "key":"recipient",
              "value":"akash1f6gmtjpx4r8qda9nxjwq26fp5mcjyqmaq5m6j7"
            },
            {
              "key":"sender",
              "value":"akash14pphss726thpwws3yc458hggufynm9x77l4l2u"
            },
            {
              "key":"amount",
              "value":"513uakt"
            },
            {
              "key":"recipient",
              "value":"akash1f6gmtjpx4r8qda9nxjwq26fp5mcjyqmaq5m6j7"
            },
            {
              "key":"sender",
              "value":"akash14pphss726thpwws3yc458hggufynm9x77l4l2u"
            },
            {
              "key":"amount",
              "value":"50000000uakt"
            }
          ]
        }
      ]
    }
  ],
  "info":"",
  "gas_wanted":"200000",
  "gas_used":"184707",
  "tx":null,
  "timestamp":""
}
```
Additionally, you can also query the market to check if your lease is closed:

```
akash query market lease list --owner $ACCOUNT_ADDRESS --node $AKASH_NODE --dseq $DSEQ 
```

You should see a response similar to:

```
leases:
- escrow_payment:
    account_id:
      scope: deployment
      xid: akash1vn06ycjjnvsvl639fet9lajjctuturrtx7fvuj/140324
    balance:
      amount: "0"
      denom: uakt
    owner: akash1f6gmtjpx4r8qda9nxjwq26fp5mcjyqmaq5m6j7
    payment_id: 1/1/akash1f6gmtjpx4r8qda9nxjwq26fp5mcjyqmaq5m6j7
    rate:
      amount: "1"
      denom: uakt
    state: closed
    withdrawn:
      amount: "513"
      denom: uakt
  lease:
    created_at: "141415"
    lease_id:
      dseq: "140324"
      gseq: 1
      oseq: 1
      owner: akash1vn06ycjjnvsvl639fet9lajjctuturrtx7fvuj
      provider: akash1f6gmtjpx4r8qda9nxjwq26fp5mcjyqmaq5m6j7
    price:
      amount: "1"
      denom: uakt
    state: closed
pagination:
  next_key: null
  total: "0"
```

As you can notice from the above, you lease will be marked `closed`.

## View your logs

You can view your application logs to debug issues or watch progress like so:

```sh
akash \
  --home "$AKASH_HOME" \
  --node "$AKASH_NODE" \
  provider service-logs \
  --service $SERVICE_NAME \
  --owner "$ACCOUNT_ADDRESS" \
  --dseq "$DSEQ" \
  --gseq "$DSEQ" \
  --oseq $OSEQ \
  --provider "$PROVIDER"
```

where `$SERVICE_NAME` is the name of a service defined in your [SDL](/sdl).