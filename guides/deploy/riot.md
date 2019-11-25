## Before we begin

In this step, you actually use the testnet to deploy a simple web app, paying with your testnet ATK tokens. Check out the [testnet guide](../testnet.md) to request tokens.

Make sure to have Akash client installed on your workstation, check [install guide](/guides/install.md) for instructions.

## 1. Check your balance

To list your keys, run:

```shell
akash key list
```

To check your balance, run:

```shell
akash query account  
```

For, example:

```
(warn) please note, the token balance is denominated in uAKT (AKT * 10^-6)

Account Query
=============

Public Key Address: 	d09cd624066cd36be651107daf6879ef49086491
Balance:            	5,000,000,000                           
Nonce:              	0                                       
```

List your keys using `akash key list` command and query your balance using `akash query account <public-key>` command.

## 2. Create the deployment configuration and modify it if desired.

Create a deployment configuration [riot.yml](riot.yml) to deploy the `bubuntux/riot-web` container:

```shell
cat > riot.yml <<EOF
---
version: "1.0"

services:
  web:
    image: bubuntux/riot-web
    expose:
      - port: 80
        to:
          - global: true

profiles:
  compute:
    web:
      cpu: "0.25"
      memory: "512Mi"
      disk: "1G"

  placement:
    global:
      pricing:
        web: 500u

deployment:
  web:
    global:
      profile: web
      count: 1
EOF
```

Alternatively, you can use cURL to download:

```shell
curl -s https://raw.githubusercontent.com/ovrclk/docs/master/guides/deploy/riot.yml > riot.yml
```

The sample deployment file specifies a small webapp container running a simple demo site we created.

You may use the sample deployment file as-is or modify it for your own needs as desscribed in our [SDL \(Stack Definition Language\) documentation](../../sdl/README.md). A typical modification would be to reference your own image instead of our demo app image. Note that you are limited in the amount of testnet resources you may request. Please see the [constraints section](../testnet.md).

## 3. Create the deployment

To deploy on Akash, run:

```shell
akash deployment create riot.yml
```

You should a response, similar to this:

```text
(wait)  [deploy] begin deployment from config: (...)
(wait)  [broadcast] request deployment for group(s): global
(done)  [broadcast] request accepted, deployment created with id: e7f1117820510fa781435c2e3aca80f6d7c08c49d7e2411f1148ba7b0b85d161
(wait)  [auction] waiting to create buy orders(s) for 1 deployment groups(s)
(wait)  [auction] buy order (1) created with id: e7f1117820510fa781435c2e3aca80f6d7c08c49d7e2411f1148ba7b0b85d161/1/2
(wait)  [auction] waiting on fulfillment(s)
(wait)  [auction] received fulfillment (1/1) with id:
        e7f1117820510fa781435c2e3aca80f6d7c08c49d7e2411f1148ba7b0b85d161/1/2/da810802cc13c032c0793657e47acc9bda313a76fa2ea3c0bc486e8de612b667
(wait)  [lease] waiting on lease(s)
(wait)  [auction] received fulfillment (2/1) with id:
        e7f1117820510fa781435c2e3aca80f6d7c08c49d7e2411f1148ba7b0b85d161/1/2/43781206bcc5f8b676ada3eb56234b48568c22bbb4936d85cb5d5569d737a9c9
(done)  [auction] complete; received 2 fulfillment(s) for 1 order(s)
(wait)  [lease] received lease (1) for group (1/1) [price 17] [id
        e7f1117820510fa781435c2e3aca80f6d7c08c49d7e2411f1148ba7b0b85d161/1/2/43781206bcc5f8b676ada3eb56234b48568c22bbb4936d85cb5d5569d737a9c9]
(wait)  [lease] send manifest to provider at http://roy.akashtest.net
(done)  [lease] manifest accepted by provider at http://roy.akashtest.net
(done)  [lease] complete; received 1 lease(s) for 1 groups(s)
(done)  [deploy] deployment complete

Deployment
==========

Deployment ID:        	e7f1117820510fa781435c2e3aca80f6d7c08c49d7e2411f1148ba7b0b85d161
Deployment Groups(s): 	Group:        	global
                      	Requirements:
                      	Resources:    	Count:  	1
                      	              	Price:  	100
                      	              	CPU:    	250
                      	              	Memory: 	134217728
                      	              	Disk:   	1073741824
Fulfillment(s):       	GROUP	PRICE	PROVIDER
                      	1    	17   	da810802cc13c032c0793657e47acc9bda313a76fa2ea3c0bc486e8de612b667
                      	1    	17   	43781206bcc5f8b676ada3eb56234b48568c22bbb4936d85cb5d5569d737a9c9

Lease(s)
========

Lease ID:    	e7f1117820510fa781435c2e3aca80f6d7c08c49d7e2411f1148ba7b0b85d161/1/2/43781206bcc5f8b676ada3eb56234b48568c22bbb4936d85cb5d5569d737a9c9
Services(s): 	NAME	HOST(S) / IP(S)                         	AVAILABLE	TOTAL
             	web 	wks5jlm8ykf3v6dzadtrrf.roy.akashtest.net	1        	1
             	web 	139.178.68.207                          	1        	1



```
In this step, you post your deployment, the Akash marketplace matches you with a provider via auction, and your image is deployed. To create a deployment use `akash deployment`. The syntax for the deployment is `akash deployment create <config-path> -k <key-name>`. As you see in the above example, we have two providers bid on your workload.

The client will print the deployment id, bid, lease, and deployment data to console. Alternatively, you may also query your leases with `akash query lease -k <key-name>` to list all the leases associated with the key.

You can access the application by visiting the hostnames mapped to your deployment. In above example, its http://wks5jlm8ykf3v6dzadtrrf.roy.akashtest.net

### Check the status of the lease

```shell
akash query lease <lease>
```

Should display a response similar to:

```text
Lease(s)
========

Lease: 	e7f1117820510fa781435c2e3aca80f6d7c08c49d7e2411f1148ba7b0b85d161/1/2/43781206bcc5f8b676ada3eb56234b48568c22bbb4936d85cb5d5569d737a9c9
Price: 	17
State: 	ACTIVE
```

## 4. Access your deployed application in whatever way makes sense to you

Check the application logs using `akash logs` command, with the below syntax:

```shell
akash logs <service> <lease>
```

For example:

```
$ akash logs web e7f1117820510fa781435c2e3aca80f6d7c08c49d7e2411f1148ba7b0b85d161/1/2/43781206bcc5f8b676ada3eb56234b48568c22bbb4936d85cb5d5569d737a9c9

[web-cd56977cb-pmkfv] 2019-10-21T19:46:00.252704424Z 10.42.0.6 - - [21/Oct/2019:19:46:00 +0000] "GET / HTTP/1.1" 200 3583 "-" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.120 Safari/537.36" "10.42.0.1"
[web-cd56977cb-pmkfv] 2019-10-21T19:46:00.451634109Z 10.42.0.6 - - [21/Oct/2019:19:46:00 +0000] "GET /css/main.css HTTP/1.1" 200 195072 "http://wks5jlm8ykf3v6dzadtrrf.roy.akashtest.net/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.120 Safari/537.36" "10.42.0.1"
[web-cd56977cb-pmkfv] 2019-10-21T19:46:00.456884678Z 10.42.0.6 - - [21/Oct/2019:19:46:00 +0000] "GET /images/qr.png HTTP/1.1" 200 7039 "http://wks5jlm8ykf3v6dzadtrrf.roy.akashtest.net/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.120 Safari/537.36" "10.42.0.1"
[web-cd56977cb-pmkfv] 2019-10-21T19:46:00.47224385Z 10.42.0.6 - - [21/Oct/2019:19:46:00 +0000] "GET /images/svg/logo-label.svg HTTP/1.1" 200 2286 "http://wks5jlm8ykf3v6dzadtrrf.roy.akashtest.net/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.120 Safari/537.36" "10.42.0.1"
[web-cd56977cb-pmkfv] 2019-10-21T19:46:00.842295117Z 10.42.0.6 - - [21/Oct/2019:19:46:00 +0000] "GET /images/svg/logo-label-black.svg HTTP/1.1" 200 2162 "http://wks5jlm8ykf3v6dzadtrrf.roy.akashtest.net/css/main.css" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.120 Safari/537.36" "10.42.0.1"
[web-cd56977cb-pmkfv] 2019-10-21T19:46:01.021583795Z 10.42.0.6 - - [21/Oct/2019:19:46:01 +0000] "GET /images/favicon.png HTTP/1.1" 200 1825 "http://wks5jlm8ykf3v6dzadtrrf.roy.akashtest.net/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.120 Safari/537.36" "10.42.0.1"
```

The lease id is constructed as `[deployment]/[group]/[order]/[provider]`

For example, given a service named `webapp`, a lease has the following properties:

| Attribute | Value |
| :--- | :--- |
| deployment | e7f1117820510fa781435c2e3aca80f6d7c08c49d7e2411f1148ba7b0b85d161 |
| group | 1 |
| order | 2 |
| provider | 43781206bcc5f8b676ada3eb56234b48568c22bbb4936d85cb5d5569d737a9c9 |

So, the lease id would be:

```
e7f1117820510fa781435c2e3aca80f6d7c08c49d7e2411f1148ba7b0b85d161/1/2/43781206bcc5f8b676ada3eb56234b48568c22bbb4936d85cb5d5569d737a9c9
```

## 5. Update the deployment by adding a custom hostname

Optionally, we can add a custom hostname to share with others. Edit the `riot.yml` and add a hostname you have DNS access to under `expose.accept`

```shell
$(EDITOR) riot.yml
```

add a hostname under `expose.accept`

```yaml
...
services:
  web:
    image: <image>
    expose:
      - port: <port>
        accept:
          - <host>
        to:
          - global: true
...
```

For example:
```yaml
...
  web:
    image: bubuntux/riot-web
    expose:
      - port: 80
        accept:
          - chat.dentacoin.com
        to:
          - global: true
...
```

Here's a complete sample [riot-domain.yml](riot-domain.yml) if we want the riot client to have a domain `chat.dentacoin.com`.

To update the deploment, use the `akash deployment update` command:

```shell
akash deployment update <config> <deployment>
```

For example:

```shell
akash deployment update riot.yml e7f1117820510fa781435c2e3aca80f6d7c08c49d7e2411f1148ba7b0b85d161

(wait)  [deploy.update] upload manifest for deployment (e7f1117820510fa781435c2e3aca80f6d7c08c49d7e2411f1148ba7b0b85d161)
(wait)  [deploy.sendmani] upload manifest to provider (e014d0e903e0d82a2058be384e21efa5552aad49078f0471447020fc238e3bd7)
(done)  [deploy.sendmani] manifest received by provider (e014d0e903e0d82a2058be384e21efa5552aad49078f0471447020fc238e3bd7)

Lease(s)
========

Lease ID: 	79b88e8fb3e0c4e55c3b5d3eb6d78527f8565a26d284c9b69ebf34bff0027a53/1/2/e014d0e903e0d82a2058be384e21efa5552aad49078f0471447020fc238e3bd7
Price:    	60
State:    	ACTIVE
Provider: 	Address:           	e014d0e903e0d82a2058be384e21efa5552aad49078f0471447020fc238e3bd7
          	Owner:             	38f05967bba460d15b8b5e15559284ea9b56b7cd
          	Host URI:          	http://marx.akashtest.net
          	Attributes:        	region: ewr | region_name: Parsippany, NJ | sgx: enabled | tier: 5
          	Received Manifest: 	Yes
```

Verify the update by checking for the hostname using cURL, for example:

```shell
curl -H 'HOST: chat.dentacoin.com' wks5jlm8ykf3v6dzadtrrf.roy.akashtest.net
```

The above is an example, replace `chat.dentacoin.com` and `wks5jlm8ykf3v6dzadtrrf.roy.akashtest.net` with the values for your application.

### 5.1 Add a CNAME record

Optionally, add a CNAME dns record on your provider to map. For instruction on updating the DNS record, please check out this [guide](https://support.google.com/a/answer/47610?hl=en). For example, the CNAME `chat.dentacoin.com` should be mapped to `wks5jlm8ykf3v6dzadtrrf.roy.akashtest.net`. 

Once that's complete, you can simply share `chat.dentacoin.com` with your community.

{% hint style='warning' %}

If you're hosting your DNS on Cloudflare, please make sure your SSL/TLS encryption mode is Flexible for DNS to work.

{% endhint %}

## 6. Close your deployment

Close deployment using `deployment close` command:

```shell
akash deployment close <deployment>
```

For example:

```text
$ akash deployment close e7f1117820510fa781435c2e3aca80f6d7c08c49d7e2411f1148ba7b0b85d161 -k alice

(wait)  request close deployment
(done)  deployment closed

Close Deployment
================

Deployment ID: 	e7f1117820510fa781435c2e3aca80f6d7c08c49d7e2411f1148ba7b0b85d161
Reason:        	TENANT_CLOSE
Height:        	18578
Hash:          	beea69622f8a3d8d6e691febeab09f03d6221e32c939d67a6cae3ab5e73db3c4

```

When you are done with your application, close the deployment. This will deprovision your container and stop the token transfer. This is a critical step to conserve both your tokens and testnet server capacity.
