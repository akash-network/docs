# Deploy an Application Using the Deploy Tool

{% hint style="warn" %}

The Deploy tool is still under developement and may result in errors.  The recommended method for deploying applications on Akash is using the process outlined [here](deploy/README.md).

{% endhint %}

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

Make sure to have Akash client installed on your workstation, check [install guide](/guides/install.md) for instructions.

You'll need an account with funds to pay for your deployment. See the [funding guide](/guides/wallet/funding.md) for
creating a key and funding your account.

### Set up your Environment

We will be using shell variables throughout this guide for convenience and clarity. Ensure you have the below set of variables defined on your shell, you can use `export VARNAME=...`:

|Name|Description|
|---|---|
|`AKASH_NODE`| Akash network configuration base URL. See [here](/guides/version.md#RPC-Node).|
|`AKASH_CHAIN_ID`| Chain ID of the Akash network connecting to. See [here](/guides/version.md#Chain-ID).|
|`AKASH_ACCOUNT_ADDRESS`| The address of your account.  See [here](/guides/wallet/README.md#account-address).|
|`AKASH_KEYRING_BACKEND`| Keyring backend to use for local keys. See [here](/guides/wallet/README.md)|
|`AKASH_KEY_NAME` | The name of the key you will be deploying from. See [here](/guides/wallet/README.md) if you haven't yet setup a key|

Verify you have correct `$AKASH_NODE`, that you have populated while [configuring the connection](/guides/version) using `export AKASH_NODE=$(curl -s "$AKASH_NET/rpc-nodes.txt" | shuf -n 1)`.

```sh
echo $AKASH_NODE $AKASH_CHAIN_ID $AKASH_KEYRING_BACKEND

http://147.75.195.69:26657 edgenet-4 os
```

Your values may differ depending on the network you're connecting to, `http://147.75.195.69:26657` and `edgenet-4` are details for [edgenet](https://github.com/ovrclk/net/tree/master/edgenet).

Verify you have the key set up and your account has sufficient balances, see the [funding guide](/guides/wallet/funding.md) otherwise:

My local key is named `alice`, the below command should return the name you've used:

```sh
echo $AKASH_KEY_NAME 

alice
```

Populate `AKASH_ACCOUNT_ADDRESS` from `AKASH_KEY_NAME` and verify:

```sh
export AKASH_ACCOUNT_ADDRESS="$(akash keys show $AKASH_KEY_NAME -a)"

echo $AKASH_ACCOUNT_ADDRESS

akash1j8s87w3fctz7nlcqtkl5clnc805r240443eksx
```

Check your account has sufficient balance by running:

```sh
akash query bank balances $AKASH_ACCOUNT_ADDRESS
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

Please note the balance indicated is is denominated in uAKT (AKT x 10^-6), in the above example, the account has a balance of *93 AKT*. We're now setup to deploy.

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
akash tx cert create client --chain-id $AKASH_CHAIN_ID --keyring-backend $AKASH_KEYRING_BACKEND --from $AKASH_KEY_NAME --node $AKASH_NODE --fees 5000uakt
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
akash deploy create deploy.yml --from $AKASH_KEY_NAME --fees 5000uakt
```
    
You should see a response similar to:
```json
I[2021-03-10|16:53:46.160] tx sent successfully                         hash=780A5FE292F00057BDD0EFB5333096E328BE3899F219EF52C938286FD28FBF43 code=0 codespace= action=create-deployment dseq=27977
I[2021-03-10|16:53:53.611] deployment created                           addr=akash1vn06ycjjnvsvl639fet9lajjctuturrtx7fvuj dseq=27977
I[2021-03-10|16:53:53.611] order for deployment created                 addr=akash1vn06ycjjnvsvl639fet9lajjctuturrtx7fvuj dseq=27977 oseq=1
I[2021-03-10|16:53:59.600] bid for order created                        addr=akash1vn06ycjjnvsvl639fet9lajjctuturrtx7fvuj dseq=27977 oseq=1 price=100uakt
D[2021-03-10|16:53:59.600] Processing bid                               
D[2021-03-10|16:53:59.600] All groups have at least one bid             
I[2021-03-10|16:54:14.600] Done waiting on bids                         qty=1
I[2021-03-10|16:54:14.601] Winning bid                                  gseq=1 price=100uakt provider=akash1ccktptfkvdc67msasmesuy5m7gpc76z75kukpz
I[2021-03-10|16:54:17.735] All expected leases created                  addr=akash1vn06ycjjnvsvl639fet9lajjctuturrtx7fvuj dseq=27977
I[2021-03-10|16:54:17.735] lease for order created                      addr=akash1vn06ycjjnvsvl639fet9lajjctuturrtx7fvuj dseq=27977 oseq=1 price=100uakt
I[2021-03-10|16:54:17.735] Waiting on leases to be ready                leaseQuantity=1
D[2021-03-10|16:54:17.735] Checking status of lease                     lease=akash1vn06ycjjnvsvl639fet9lajjctuturrtx7fvuj/27977/1/1/akash1ccktptfkvdc67msasmesuy5m7gpc76z75kukpz
I[2021-03-10|16:54:18.235] sending manifest to provider                 action=send-manifest provider=akash1ccktptfkvdc67msasmesuy5m7gpc76z75kukpz dseq=27977
D[2021-03-10|16:54:18.353] Could not get lease status                   lease=akash1vn06ycjjnvsvl639fet9lajjctuturrtx7fvuj/27977/1/1/akash1ccktptfkvdc67msasmesuy5m7gpc76z75kukpz err="remote server returned 404"
I[2021-03-10|16:54:26.299] service ready                                lease=akash1vn06ycjjnvsvl639fet9lajjctuturrtx7fvuj/27977/1/1/akash1ccktptfkvdc67msasmesuy5m7gpc76z75kukpz service=web
I[2021-03-10|16:54:26.299] lease ready                                  leaseID=akash1vn06ycjjnvsvl639fet9lajjctuturrtx7fvuj/27977/1/1/akash1ccktptfkvdc67msasmesuy5m7gpc76z75kukpz
{
 "name": "web",
 "available": 1,
 "total": 1,
 "uris": [
  "5tito0kgehbrjefr7ae9ko1pfs.ingress.ams1p0.mainnet.akashian.io"
 ],
 "observed_generation": 1,
 "replicas": 1,
 "updated_replicas": 1,
 "ready_replicas": 1,
 "available_replicas": 1
}

```

In this step, you post your deployment, and the Akash marketplace matches you with a provider via auction - the URI in the output is randomly generated. To create a deployment use akash deployment. The syntax for the deployment is `akash deploy create <config-path> --from <key-name>`. 

## View your Lease

You can check the status of your lease by running:

```sh
akash query market lease list --owner $AKASH_ACCOUNT_ADDRESS --node $AKASH_NODE --state active
```

You should see a response similar to:

```
leases:
- escrow_payment:
    account_id:
      scope: deployment
      xid: akash1vn06ycjjnvsvl639fet9lajjctuturrtx7fvuj/27977
    balance:
      amount: "0"
      denom: uakt
    owner: akash1ccktptfkvdc67msasmesuy5m7gpc76z75kukpz
    payment_id: 1/1/akash1ccktptfkvdc67msasmesuy5m7gpc76z75kukpz
    rate:
      amount: "100"
      denom: uakt
    state: open
    withdrawn:
      amount: "0"
      denom: uakt
  lease:
    created_at: "27983"
    lease_id:
      dseq: "27977"
      gseq: 1
      oseq: 1
      owner: akash1vn06ycjjnvsvl639fet9lajjctuturrtx7fvuj
      provider: akash1ccktptfkvdc67msasmesuy5m7gpc76z75kukpz
    price:
      amount: "100"
      denom: uakt
    state: active
pagination:
  next_key: null
  total: "0"
```

In the above example, we can see that a lease is created using *100 uakt* or *0.00000100 AKT* per block to execute the container.

For convenience and clarity for future referencing, we can extract the below set of values to shell variables that we will be using to reference the deployment:

| Attribute | Value |
| --- | --- |
| `AKASH_PROVIDER` | `akash1ccktptfkvdc67msasmesuy5m7gpc76z75kukpz` |
| `AKASH_DSEQ` | `27977` |

Verify we have the right values populated by running:

```sh
echo $AKASH_PROVIDER $AKASH_DSEQ

akash1ccktptfkvdc67msasmesuy5m7gpc76z75kukpz 27977 
```

## View Deployment

Once your lease has been created and you have the relevant information above, you can retrieve the access details by running the below:

```sh
akash provider lease-status --log_level=info --dseq $AKASH_DSEQ --from $AKASH_KEY_NAME --home ~/.akash --provider $AKASH_PROVIDER --keyring-backend $AKASH_KEYRING_BACKEND --node $AKASH_NODE
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
        "5tito0kgehbrjefr7ae9ko1pfs.ingress.ams1p0.mainnet.akashian.io"
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

You can access the application by visiting the hostnames mapped to your deployment. In above example, it's http://5tito0kgehbrjefr7ae9ko1pfs.ingress.ams1p0.mainnet.akashian.io

## View your logs

You can view your application logs to debug issues or watch progress like so:

```sh
akash \
  --home "$AKASH_HOME" \
  --node "$AKASH_NODE" \
  provider lease-logs \
  --dseq "$AKASH_DSEQ" \
  --gseq "$AKASH_GSEQ" \
  --oseq "$AKASH_OSEQ" \
  --provider "$AKASH_PROVIDER" \
  --from "$AKASH_KEY_NAME"
```

## Update your deployment

Updating active deployments is a two step process. First, edit your deployment YAML file with the desired changes.

{% hint style="warn" %}

Akash Groups are translated into Kubernetes Deployments, this means that only a few fields from the Akash SDL are mutable. For example image, command, args, env and exposed ports can be modified, but compute resources and placement criteria cannot. 

{% endhint %}

  1. Update your deployment by running:
  ```sh
  akash tx deployment update deploy.yml --dseq $AKASH_DSEQ --from $AKASH_KEY_NAME --chain-id $AKASH_CHAIN_ID --node $AKASH_NODE --fees=5000uakt
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
  akash provider send-manifest deploy.yml --keyring-backend=os --node $AKASH_NODE --from=$AKASH_KEY_NAME --provider=$AKASH_PROVIDER --dseq $AKASH_DSEQ --log_level=info --home ~/.akash
  ```

Between the first and second step, the prior deployment's containers will continue to run until the new manifest file is received, validated, and new container group operational. After health checks on updated group are passing; the prior containers will be terminated - this process may take a couple minutes to complete.

## Add funds to your Deployment

You will eventually need to add funds to the escrow account associated with your deployment to keep it running.  If the account becomes overdrawn due to lack of funds, the deployment will permanently close and require you to complete the deploy process again.  This in turn will also assign a new, random URI for the deployment.

Deposit additional funds to your escrow account by running:

```sh
akash tx deployment deposit --from $AKASH_KEY_NAME --chain-id $AKASH_CHAIN_ID --keyring-backend=$AKASH_KEYRING_BACKEND --node $AKASH_NODE 10000uakt --dseq $AKASH_DSEQ --fees=5000uakt
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
akash tx deployment close --node $AKASH_NODE --chain-id $AKASH_CHAIN_ID --dseq $AKASH_DSEQ  --owner $AKASH_ACCOUNT_ADDRESS --from $AKASH_KEY_NAME --keyring-backend $AKASH_KEYRING_BACKEND -y --fees 5000uakt
```

You should see a response simlar to below as a confirmation your deployment is closed:

```json
{
  "height":"28587",
  "txhash":"8EB6E5E7891F9D650569BDE94E6DD4B03AB76D368D259CED46D3C91130F44B90",
  "codespace":"",
  "code":0,
  "data":"0A120A10636C6F73652D6465706C6F796D656E74",
  "raw_log":"[{\"events\":[{\"type\":\"akash.v1\",\"attributes\":[{\"key\":\"module\",\"value\":\"deployment\"},{\"key\":\"action\",\"value\":\"deployment-closed\"},{\"key\":\"owner\",\"value\":\"akash1vn06ycjjnvsvl639fet9lajjctuturrtx7fvuj\"},{\"key\":\"dseq\",\"value\":\"27977\"},{\"key\":\"module\",\"value\":\"deployment\"},{\"key\":\"action\",\"value\":\"group-closed\"},{\"key\":\"owner\",\"value\":\"akash1vn06ycjjnvsvl639fet9lajjctuturrtx7fvuj\"},{\"key\":\"dseq\",\"value\":\"27977\"},{\"key\":\"gseq\",\"value\":\"1\"},{\"key\":\"module\",\"value\":\"market\"},{\"key\":\"action\",\"value\":\"order-closed\"},{\"key\":\"owner\",\"value\":\"akash1vn06ycjjnvsvl639fet9lajjctuturrtx7fvuj\"},{\"key\":\"dseq\",\"value\":\"27977\"},{\"key\":\"gseq\",\"value\":\"1\"},{\"key\":\"oseq\",\"value\":\"1\"},{\"key\":\"module\",\"value\":\"market\"},{\"key\":\"action\",\"value\":\"bid-closed\"},{\"key\":\"owner\",\"value\":\"akash1vn06ycjjnvsvl639fet9lajjctuturrtx7fvuj\"},{\"key\":\"dseq\",\"value\":\"27977\"},{\"key\":\"gseq\",\"value\":\"1\"},{\"key\":\"oseq\",\"value\":\"1\"},{\"key\":\"provider\",\"value\":\"akash1ccktptfkvdc67msasmesuy5m7gpc76z75kukpz\"},{\"key\":\"price-denom\",\"value\":\"uakt\"},{\"key\":\"price-amount\",\"value\":\"100\"},{\"key\":\"module\",\"value\":\"market\"},{\"key\":\"action\",\"value\":\"lease-closed\"},{\"key\":\"owner\",\"value\":\"akash1vn06ycjjnvsvl639fet9lajjctuturrtx7fvuj\"},{\"key\":\"dseq\",\"value\":\"27977\"},{\"key\":\"gseq\",\"value\":\"1\"},{\"key\":\"oseq\",\"value\":\"1\"},{\"key\":\"provider\",\"value\":\"akash1ccktptfkvdc67msasmesuy5m7gpc76z75kukpz\"},{\"key\":\"price-denom\",\"value\":\"uakt\"},{\"key\":\"price-amount\",\"value\":\"100\"}]},{\"type\":\"message\",\"attributes\":[{\"key\":\"action\",\"value\":\"close-deployment\"},{\"key\":\"sender\",\"value\":\"akash1vn06ycjjnvsvl639fet9lajjctuturrtx7fvuj\"},{\"key\":\"sender\",\"value\":\"akash14pphss726thpwws3yc458hggufynm9x77l4l2u\"},{\"key\":\"sender\",\"value\":\"akash14pphss726thpwws3yc458hggufynm9x77l4l2u\"},{\"key\":\"sender\",\"value\":\"akash14pphss726thpwws3yc458hggufynm9x77l4l2u\"}]},{\"type\":\"transfer\",\"attributes\":[{\"key\":\"recipient\",\"value\":\"akash17xpfvakm2amg962yls6f84z3kell8c5lazw8j8\"},{\"key\":\"sender\",\"value\":\"akash1vn06ycjjnvsvl639fet9lajjctuturrtx7fvuj\"},{\"key\":\"amount\",\"value\":\"5000uakt\"},{\"key\":\"recipient\",\"value\":\"akash1vn06ycjjnvsvl639fet9lajjctuturrtx7fvuj\"},{\"key\":\"sender\",\"value\":\"akash14pphss726thpwws3yc458hggufynm9x77l4l2u\"},{\"key\":\"amount\",\"value\":\"4939600uakt\"},{\"key\":\"recipient\",\"value\":\"akash1ccktptfkvdc67msasmesuy5m7gpc76z75kukpz\"},{\"key\":\"sender\",\"value\":\"akash14pphss726thpwws3yc458hggufynm9x77l4l2u\"},{\"key\":\"amount\",\"value\":\"60400uakt\"},{\"key\":\"recipient\",\"value\":\"akash1ccktptfkvdc67msasmesuy5m7gpc76z75kukpz\"},{\"key\":\"sender\",\"value\":\"akash14pphss726thpwws3yc458hggufynm9x77l4l2u\"},{\"key\":\"amount\",\"value\":\"50000000uakt\"}]}]}]",
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
              "value":"27977"
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
              "value":"27977"
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
              "value":"27977"
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
              "value":"27977"
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
              "value":"akash1ccktptfkvdc67msasmesuy5m7gpc76z75kukpz"
            },
            {
              "key":"price-denom",
              "value":"uakt"
            },
            {
              "key":"price-amount",
              "value":"100"
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
              "value":"27977"
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
              "value":"akash1ccktptfkvdc67msasmesuy5m7gpc76z75kukpz"
            },
            {
              "key":"price-denom",
              "value":"uakt"
            },
            {
              "key":"price-amount",
              "value":"100"
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
              "value":"4939600uakt"
            },
            {
              "key":"recipient",
              "value":"akash1ccktptfkvdc67msasmesuy5m7gpc76z75kukpz"
            },
            {
              "key":"sender",
              "value":"akash14pphss726thpwws3yc458hggufynm9x77l4l2u"
            },
            {
              "key":"amount",
              "value":"60400uakt"
            },
            {
              "key":"recipient",
              "value":"akash1ccktptfkvdc67msasmesuy5m7gpc76z75kukpz"
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
  "gas_used":"184841",
  "tx":null,
  "timestamp":""
}
```
Additionally, you can also query the market to check if your lease is closed:

```
akash query market lease list --owner $AKASH_ACCOUNT_ADDRESS --node $AKASH_NODE --dseq $AKASH_DSEQ 
```

You should see a response similar to:

```
leases:
- escrow_payment:
    account_id:
      scope: deployment
      xid: akash1vn06ycjjnvsvl639fet9lajjctuturrtx7fvuj/27977
    balance:
      amount: "0"
      denom: uakt
    owner: akash1ccktptfkvdc67msasmesuy5m7gpc76z75kukpz
    payment_id: 1/1/akash1ccktptfkvdc67msasmesuy5m7gpc76z75kukpz
    rate:
      amount: "100"
      denom: uakt
    state: closed
    withdrawn:
      amount: "60400"
      denom: uakt
  lease:
    created_at: "27983"
    lease_id:
      dseq: "27977"
      gseq: 1
      oseq: 1
      owner: akash1vn06ycjjnvsvl639fet9lajjctuturrtx7fvuj
      provider: akash1ccktptfkvdc67msasmesuy5m7gpc76z75kukpz
    price:
      amount: "100"
      denom: uakt
    state: closed
pagination:
  next_key: null
  total: "0"
```

As you can notice from the above, you lease will be marked `closed`.
