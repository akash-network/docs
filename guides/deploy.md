# Quick Start Guide

This guide will walk you through installing the `akash`application, creating and funding an account on an Akash network, and deploying a single-tier web application on Akash.

The software to run **Akash** and the command-line client used to interact with them are all distributed in the `akash`application. The `akash` command is used to run the Akash Network.

## Part 1. Install Akash

Select a tab below to view instructions for MacOS, Linux, or compiling from source.

{% tabs %}
{% tab title="MacOS" %}
## MacOS

Before you install Akash, you will need to install the **XCode Command Line Tools**, and also we recommend using **Homebrew** to install Akash.

### 1. Install XCode:

You will need to install Apple's XCode Command Line Tools. Run this command in Terminal:

```text
xcode-select --install
```

### 2. Install Homebrew:

If you do not have Homebrew, you can install Homebrew using:

```text
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

### 3. Install Akash:

Install `akash` using homebrew:

```text
brew tap ovrclk/tap
brew install akash
brew link akash --force
```

Once installed, verify the installation by running `akash version`

```text
akash version
```

Congrats!
{% endtab %}

{% tab title="Linux" %}
## Linux

Download the archive for your system from the [release page](https://github.com/ovrclk/akash/releases), extract it, and install the `akash` binary into your path.

#### GoDownloader

Alternatively, install the latest version via [`godownloader`](https://github.com/goreleaser/godownloader) First, configure the version of the Akash Network `AKASH_VERSION`as a shell variable in your terminal:

```bash
# Install Zip utility if not already installed
sudo apt install zip
```

```bash
# configure akash version
AKASH_VERSION="$(curl -s "https://raw.githubusercontent.com/ovrclk/net/master/mainnet/version.txt")"

# install akash 
curl https://raw.githubusercontent.com/ovrclk/akash/master/godownloader.sh | sh -s -- "v$AKASH_VERSION"
```

The final step is to make sure that the akash binaries are available in your shell `PATH`.[This page](https://stackoverflow.com/questions/14637979/how-to-permanently-set-path-on-linux-unix) contains instructions for setting the PATH on Linux.

The downloader will extract the project to .../bin for current path unless otherwise set. Example using debian or Ubuntu: If you are in user home directory when entering the commands above, the example path will be /home/$USER/bin which is where the executable file was downloaded to. To add this to your system path do the following:
```bash
# Add Akash to Path
export PATH=$PATH:/home/$USER/bin
```
You can verify path was added correctly by simply checking with the following command
```bash
echo $PATH
```

{% endtab %}

{% tab title="Source" %}
## Source

Installing Akash suite from source

```text
$ go get -d github.com/ovrclk/akash
$ cd $GOPATH/src/github.com/ovrclk/akash
$ git checkout "v$AKASH_VERSION"
$ make deps-install
$ make install
```

Akash is developed and tested with [golang 1.16+](https://golang.org/). Building requires a working [golang](https://golang.org/) installation, a properly set `GOPATH`, and `$GOPATH/bin` present in `$PATH`.

Once you have the dependencies properly setup, download and build `akash` using `make install`
{% endtab %}
{% endtabs %}

## Part 2. Create an Account

Configure the name of your key. The command below will set the name of your key to `myWallet`, run the below command and replace `myWallet` with a name of your choice:

```bash
AKASH_KEY_NAME=myWallet
```

Verify you have the shell variables set up . The below command should return the name you've used:

```bash
echo $AKASH_KEY_NAME
```

Copy and paste this command into Terminal to create an Akash account:

```bash
akash keys add $AKASH_KEY_NAME
```

Read the output and save your mnemonic phrase is a safe place. Let's set a Shell Variable in Terminal `AKASH_ACCOUNT_ADDRESS` to save your account address for later.

```bash
export AKASH_ACCOUNT_ADDRESS="$(akash keys show $AKASH_KEY_NAME -a)"

echo $AKASH_ACCOUNT_ADDRESS
```

Note that if you close your Terminal window this variable will not bee saved.

## Part 3. Fund your Account



## Apply for Developer Grants

Developers can apply for awards from the  Community Awards program. Please read the article [**Introducing the Akash Developer Grant Program**](https://forum.akash.network/t/how-to-apply-for-developer-grants/) ****and follow the steps.

1. [ ] [Create an account](https://forum.akash.network/login)
2. [ ] [Join the Akash Discord serv](https://discord.gg/uJ7NWdF4hn)
3. [ ] [Connect Github and Discord to your profile](https://forum.akash.network/u/colo/preferences/account)
4. [ ] [Add your Akash Address to your profile](https://forum.akash.network/my/preferences/profile)
5. [ ] [Propose a Project](https://forum.akash.network/c/grants/new/)
6. [ ] [Submit a Grant Application](https://forum.akash.network/c/grants/apply/)

## Part 4.  Connect to the Network

First configure the base URL \(`$AKASH_NET`\) for the Akash Network; copy and paste the command below:

```bash
AKASH_NET="https://raw.githubusercontent.com/ovrclk/net/master/mainnet"
```

#### Version

Next configure the version of the Akash Network `AKASH_VERSION`; copy and paste the command below:

```bash
AKASH_VERSION="$(curl -s "$AKASH_NET/version.txt")"
```

#### Chain ID

The akash CLI will recogonize `AKASH_CHAIN_ID` environment variable when exported to the shell.

```bash
export AKASH_CHAIN_ID="$(curl -s "$AKASH_NET/chain-id.txt")"
```

#### Network Node

You need to select a node on the network to connect to, using an RPC endpoint. To configure the`AKASH_NODE` environment variable use this export command:

```bash
export AKASH_NODE="$(curl -s "$AKASH_NET/rpc-nodes.txt" | head -1)"
```

#### Confirm your network variables are setup

Your values may differ depending on the network you're connecting to.

```bash
echo $AKASH_NODE $AKASH_CHAIN_ID $AKASH_KEYRING_BACKEND
```

You should see something similar to:

`http://135.181.60.250:26657 akashnet-2 os`

### Check your Account Balance

Check your account has sufficient balance by running:

```bash
akash query bank balances --node $AKASH_NODE $AKASH_ACCOUNT_ADDRESS
```

You should see a response similar to:

```text
balances:
- amount: "93000637"
  denom: uakt
pagination:
  next_key: null
  total: "0"
```

If you don't have a balance, please see the [funding guide](https://github.com/ovrclk/docs/tree/b65f668b212ad1976fb976ad84a9104a9af29770/guides/wallet/funding.md). Please note the balance indicated is denominated in uAKT \(AKT x 10^-6\), in the above example, the account has a balance of _93 AKT_. We're now setup to deploy.

{% hint style="info" %}
Your account must have a minimum balance of 5 AKT to create a deployment. This 5 AKT funds the escrow account associated with the deployment and is used to pay the provider for their services. It is recommended you have more than this minimum balance to pay for transaction fees. For more information on escrow accounts, see [here](../decentralized-cloud/escrow.md)
{% endhint %}

## Part 5. Create your Configuration

Create a deployment configuration [deploy.yml](https://github.com/ovrclk/docs/tree/b65f668b212ad1976fb976ad84a9104a9af29770/guides/deploy/deploy.yml) to deploy the `ovrclk/lunie-light` for [Lunie Light](https://github.com/ovrclk/lunie-light) Node app container using [SDL](https://github.com/ovrclk/docs/tree/b65f668b212ad1976fb976ad84a9104a9af29770/sdl/README.md).

You can use cURL to download the file:

```text
curl -s https://raw.githubusercontent.com/ovrclk/docs/master/guides/deploy/deploy.yml > deploy.yml
```

### Modify your Configuration

You may use the sample deployment file as-is or modify it for your own needs as desscribed in our [SDL \(Stack Definition Language\)](https://github.com/ovrclk/docs/tree/b65f668b212ad1976fb976ad84a9104a9af29770/guides/deploy/documentation/sdl/README.md) documentation. A typical modification would be to reference your own image instead of our demo app image.

#### EXAMPLE CONFIGURATION:

```bash
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

## Part 6. Create your Certificate

Before you can create a deployment, a [certificate](../decentralized-cloud/mtls.md) must first be created. **Your certificate needs to be created only once per account** and can be used across all deployments.To do this, run:

```text
akash tx cert create client --chain-id $AKASH_CHAIN_ID --keyring-backend os --from $AKASH_KEY_NAME --node $AKASH_NODE --fees 5000uakt
```

You should see a response similar to:

```javascript
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



## Part 7. Create your Deployment

To deploy on Akash, run:

```bash
akash tx deployment create deploy.yml --from $AKASH_KEY_NAME --node $AKASH_NODE --chain-id $AKASH_CHAIN_ID --fees 5000uakt -y
```

You should see a response similar to:

```javascript
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

### Find your Deployment \#

Find the Deployment Sequence \(DSEQ\) in the deployment you just created. You will need to replace the AKASH\_DSEQ with the number from your deployment to configure a shell variable.

```bash
AKASH_DSEQ=CHANGETHIS
```

Now set the Order Sequence \(OSEQ\) and Group Sequence \(GSEQ\). Note that if this is your first time deploying on Akash, OSEQ and GSEQ will be 1.

```bash
AKASH_OSEQ=1
AKASH_GSEQ=1
```

Verify we have the right values populated by running:

```bash
echo $AKASH_DSEQ $AKASH_OSEQ $AKASH_GSEQ
```

## Part 8. View your Bids

After a short time, you should see bids from providers for this deployment with the following command:

```bash
akash query market bid list --owner=$AKASH_ACCOUNT_ADDRESS --node $AKASH_NODE --dseq $AKASH_DSEQ
```

### Choose a Provider

Note that there are bids from multiple different providers. In this case, both providers happen to be willing to accept a price of _1 uAKT_. This means that the lease can be created using _1 uAKT_ or _0.000001 AKT_ per block to execute the container. You should see a response similar to:

```text
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

For this example, we will choose `akash10cl5rm0cqnpj45knzakpa4cnvn5amzwp4lhcal`. Run this command to set the provider shell variable:

```bash
AKASH_PROVIDER=akash1f6gmtjpx4r8qda9nxjwq26fp5mcjyqmaq5m6j7
```

Verify we have the right value populated by running:

```bash
echo $AKASH_PROVIDER
```

## Part 9. Create a Lease

Create a lease for the bid from the chosen provider above by running:

```bash
akash tx market lease create --chain-id $AKASH_CHAIN_ID --node $AKASH_NODE --owner $AKASH_ACCOUNT_ADDRESS --dseq $AKASH_DSEQ --gseq $AKASH_GSEQ --oseq $AKASH_OSEQ --provider $AKASH_PROVIDER --from $AKASH_KEY_NAME --fees 5000uakt
```

### Confirm the Lease

You can check the status of your lease by running:

```bash
akash query market lease list --owner $AKASH_ACCOUNT_ADDRESS --node $AKASH_NODE --dseq $AKASH_DSEQ
```

You should see a response that ends with:

```text
    state: active
```

{% hint style="info" %}
Please note that once the lease is created, the provider will begin debiting your deployment's escrow account, even if you have not completed the deployment process by uploading the manifest in the following step.
{% endhint %}

## Part 10. Send the Manifest

Upload the manifest using the values from above step:

```bash
akash provider send-manifest deploy.yml --node $AKASH_NODE --dseq $AKASH_DSEQ --provider $AKASH_PROVIDER --home ~/.akash --from $AKASH_KEY_NAME
```

You should expect no output from the above command.

### Confirm the URL

Now that the manifest is uploaded, your image is deployed. You can retrieve the access details by running the below:

```bash
akash provider lease-status --node $AKASH_NODE --home ~/.akash --dseq $AKASH_DSEQ --from $AKASH_KEY_NAME --provider $AKASH_PROVIDER
```

You should see a response similar to:

```javascript
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

You can access the application by visiting the hostnames mapped to your deployment. Look for a URL that is ends in **akashian.io** and copy it to your web browser.

### View your logs

You can view your application logs to debug issues or watch progress like so:

```bash
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

