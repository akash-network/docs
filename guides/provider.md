
## Create a Provider account

1. Create a key using `akash key create`

```shell
$
akash key create alice                                                                                                                                                   
(info)  [key] key created

Create Key
==========

Name:           	alice
Public Key:     	4fbe42a0f09ed555ef36566d148a15bae5a694db
Recovery Codes: 	album return owner forget top scissors kangaroo escape panther history liberty industry raise surge trigger jealous fit erase horn era hero dust weekend slim

(warn)  [Important] Write these Recovery codes in a safe place. It is the only way to recover your account.
```

2. Create a provider account for alice

You'll need a publicly reachable address (either hostname or IP address).

 Create config file `alice.yml`

```yaml
hostURI: http://alice.akashtest.net
attributes:
  - name: region
    value: sjc
```

List alice as a provider by running `akash provider add alice.yml`, for example:

```shell
$ akash provider add alice.yml

(info)  [provider] provider added

Add Provider
============

Key: 	7b07444c2b89aa42333a13ed42f48ae48c8b4ea66fae2150144bac802b3ab0eb
```

Save this key as this is your unique identifier. You can optionally run pipe the command  `akash provider add alice.yml | grep Key | awk 'print{$2}' | tee -a alice.address`


If you check the status using `akash provider status`, you'll see alice is passive. To make alice active, deploy Akash provider server on the cluster.

```

Active Provider(s) Status
=========================

Provider               	Attributes                                                        	Version	Leases	Deployments	Orders	Message(s)
--------               	----------                                                        	-------	------	-----------	------	----------

08d3308887403b5e00e....	region: ewr | region_name: Parsippany, NJ | sgx: enabled | tier: 5	0.5.1  	0     	0          	0     	code=200  msg=OK
0f1bf178ad4b411a52b....	region: nrt | region_name: Tokyo, JP | sgx: enabled | tier: 5     	0.5.1  	0     	0          	0     	code=200  msg=OK
2c84a88fb60129ffc1e....	region: ams | region_name: Amsterdam, NL | sgx: enabled | tier: 5 	0.5.1  	0     	0          	0     	code=200  msg=OK
4af7cf48cc96d5d3774....	region: ewr | region_name: Parsippany, NJ | sgx: enabled | tier: 5	0.5.1  	1     	1          	0     	code=200  msg=OK
7e9555db6e666087c25....	region: nrt | region_name: Tokyo, JP | sgx: enabled | tier: 5     	0.5.1  	0     	0          	0     	code=200  msg=OK
b3efe465ee9a7abd272....	region: ams | region_name: Amsterdam, NL | sgx: enabled | tier: 5 	0.5.1  	0     	0          	0     	code=200  msg=OK
ce2132dc4a64e0c37c4....	region: sjc | region_name: Sunnyvale, US | sgx: enabled | tier: 5 	0.5.1  	1     	1          	0     	code=200  msg=OK
d9c16bc27bd65ba2a89....	region: sjc | region_name: Sunnyvale, US | sgx: enabled | tier: 5 	0.5.1  	2     	0          	0     	code=200  msg=OK

Passive Provider(s) Status
==========================

Provider               	Attributes    Version	Leases	Deployments	Orders	Message(s)
--------               	----------    -------	------	-----------	------	----------
7b07444c2b89aa42333....	region: sjc	                                      error=response not ok: 404 Not Found
```

## Deploying Akash Provider

1. Create a secret for the private key. First export the private key to a file using `key show --private` and then create a kubernetes secret.

```
export AKASH_PRIVATE_KEY_PATH=alice.private.key
$ akash key show alice --private > $AKASH_PRIVATE_KEY_PATH
```

Create a kubernetes from literal

```
export SECRET_NAME=alice-secret

kubectl create secret generic $SECRET_NAME --from-literal=keyname=$AKASH_KEY_NAME --from-literal=key="$(cat $AKASH_PRIVATE_KEY_PATH)"
```

Instead of installing Akash via a Deployment object, you can also use the Akash Helm chart.

Install Akash chart by:

```
helm install stable/akash-provider
```

For more information, check out the doc.
