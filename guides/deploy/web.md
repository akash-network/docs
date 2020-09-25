# Deploy A Simple Web App


You can deploy containerized applications using Akash Deploy CLI utility. Akash `deploy` is simple a command line client for deploying applications on the [Akash Network](https://akash.network). It also contains a full demo environment to help users develop their [SDL files](https://docs.akash.network/usage/sdl) for deployment on the live network (test or otherwise).

### Requirements

* Go 1.14+ installed and `$GOPATH` + `$GOBIN` setup
    - [Install Go](https://golang.org/doc/install)


## Install Deploy Tool on Your Workstation

Install the deploy tool on your local workstation by following the below set of instructions:

```sh
mkdir -p $GOPATH/src/github.com/ovrclk
git clone https://github.com/ovrclk/deploy $GOPATH/src/github.com/ovrclk/deploy
cd $GOPATH/src/github.com/ovrclk/deploy
make install
```

## Configure Your Environment

First, generate the configuration file for the testnet by running the below

```sh
deploy init testnet-v4 http://rpc.akashtest.net:26657
```

You should see a response similar to:

```text
config file /Users/gosuri/.akash-deploy/config.yaml doesn't exist
creating config /Users/gosuri/.akash-deploy/config.yaml...
```

Then, generate a private key for your deployment using the below command:

```sh
deploy key-add
```

You should see a response similar to:
```
Private key specified in the config file doesn't exist: /Users/gosuri/.akash-deploy/key.priv
Creating /Users/gosuri/.akash-deploy/key.priv ...
```

To display the address for the key you just created, run the below:

```sh
deploy address
```

Get some Testnet Tokens from the [Akash Testnet Faucet](https://akash.vitwit.com/faucet). When you have tokens, you will see them using the balance command:

```
deploy balance
```

You should see a response similar to:

```json
{
  "type": "cosmos-sdk/Account",
  "value": {
    "address": "akash1u74ah2ek7hku766yqpc5huqdc5fdydrm9glaa9",
    "coins": [
      {
        "denom": "uakt",
        "amount": "1000000"
      }
    ],
    "public_key": "",
    "account_number": 139,
    "sequence": 0
  }
}
```

### Deploying Your First Akash Application

The following commands will deploy your first akash application on the testnet. Once you have some testnet `akash` you can start deploying apps! Try the `sample.yaml` file in the root of the repo:

```sh
deploy create sample.yaml
```

You should see a response similar to:

```
I[2020-09-02|18:47:04.304] tx sent successfully                         hash=754913EA2098EA3E11FF72C62E41D65C925DB0BDB2F487FDDC282D2EAA51B9EE code=0 codespace= action=create-deployment dseq=529443
I[2020-09-02|18:47:04.304] deployment created                           addr=akash1u74ah2ek7hku766yqpc5huqdc5fdydrm9glaa9 dseq=529443
I[2020-09-02|18:47:04.727] order for deployment created                 addr=akash1u74ah2ek7hku766yqpc5huqdc5fdydrm9glaa9 dseq=529443 oseq=1
I[2020-09-02|18:47:09.627] bid for order created                        addr=akash1u74ah2ek7hku766yqpc5huqdc5fdydrm9glaa9 dseq=529443 oseq=1 price=176uakt
I[2020-09-02|18:47:30.807] lease for order created                      addr=akash1u74ah2ek7hku766yqpc5huqdc5fdydrm9glaa9 dseq=529443 oseq=1 price=176uakt
I[2020-09-02|18:47:30.982] sending manifest to provider                 action=send-manifest provider=akash1chyw0u8vetuaynk8q03zv0p62th59z66qfy0vh uri=http://provider.akashdev.net dseq=529443
I[2020-09-02|18:47:34.591] 8qssay4mtokdsucy9y9gyr.provider.akashdev.net name=web available=1
```

The domain name in the last line of the log is where you application is deployed. In the above example, it is hosted at `8qssay4mtokdsucy9y9gyr.provider.akashdev.net`
