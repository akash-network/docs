# Provider Guide: Selling compute on Akash Market

Akash offers a permission-less market for trading computing, meaning anyone with a computer can offer to sell compute on the Akash network.

In this guide, we'll walk through the steps necessary to become an Akash provider by selling unused compute on the Akash marketplace.

Throughout the tutorial, we will be using environment variables to simplify configuration, so you should use a single terminal session for the entirety of the tutorial.

You will require a publicly reachable IP address and a [Kubernetes](https://kubernetes.io) (v1.15.4 and above) cluster. For instructions on setting up a Kubernetes cluster for Akash, please see [stack](https://github.com/ovrclk/stack) for details.

## Before we begin



## Adding a provider to the network

First, lets create a key locally that we'll use as an identifier.

```shell
export key=$USER

akash key create $key
```
You should see a response similar to:

```text
(info)  [key] key created

Create Key
==========

Name:           	alice
Public Key:     	4fbe42a0f09ed555ef36566d148a15bae5a694db
Recovery Codes: 	album return owner forget top scissors kangaroo escape panther history liberty industry raise surge trigger jealous fit erase horn era hero dust weekend slim
```
{% hint style="warn" %}

Write these Recovery codes in a safe place. It is the only way to recover your account.

{% endhint %}

Create a config file with various attributes to your offering, such as `region`. By running  `akash provider status` , you can get an idea of what attributes to use. In our example, we set the region to `sfo`.

```shell
export ingress="$key.akashtest.net"

cat > "$key.provider.yml" <<EOF
hostURI: http://${ingress}
attributes:
  - name: region
    value: sfo
EOF
```

To register, run the below and save the key as this is your unique identifier.

```shell
akash provider add $key.provider.yml -key $key
```

{% hint style="info" %}

Optionally, you can save the address to a file by piping the output using:

```shell
akash provider add $key.provider.yml -k $key | grep Key | awk '{print $2}' | tee -a $key.address

export address=$(cat $key.address)
```
{% endhint %}

You should see a response similar to:

```text
(info)  [provider] provider added

Add Provider
============

Key: 	7b07444c2b89aa42333a13ed42f48ae48c8b4ea66fae2150144bac802b3ab0eb
```

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
7b07444c2b89aa42333....	region: sfo	                                      error=response not ok: 404 Not Found
```

## Deploying Akash Provider service on Kubernetes

### Create a secret for you private key

To create a secret for the private key,  first export the private key to a file using `key show --private` and then create a kubernetes secret.

```shell
akash key show $key --private > $key.private.key
```

Create a kubernetes from literal using:

```shell

kubectl create secret generic $key-akash-provider-private-key \
  --from-literal=keyname=$key \
  --from-literal=key="$(cat $key.private.key)"
```

Confirm using `kubectl describe secret $key-akash-provider-private-key`

### Deploy to kubernetes

{% hint style="warn" %}

Make sure `$address` environment is populated with provider address from `akash provider add` step, you could use `export address=$(cat $key.address)`

{% endhint %}

{% tabs %} {% tab title="Helm" %}

### Using Helm

Simplest way to install Akash is using Helm. Install Akash Provider chart by:

```shell
<<<<<<< HEAD
curl https://helm.akash.network/dist/akash-provider-0.1.0.tgz | tar xvz

helm install akash-provider -n $key   \
  --set "ingress.domain=$ingress"     \
  --set "provider.address=$address"
```


=======
helm install akash-provider --repo helm.akash.network \
  --name $key \
  --set "ingress.domain=$ingress" \
  --set "provider.address=$address"
```

>>>>>>> master
{% endtab %} {% tab title="kubectl" %}

### Using kubectl

First, create kubernetes deployment configuration using:

```shell
cat > akash-provider.yml <<EOF
---
apiVersion: rbac.authorization.k8s.io/v1beta1
kind: ClusterRoleBinding
metadata:
  name: akash-provider
  labels:
    app: akash-provider
subjects:
  - kind: ServiceAccount
    name: default
    namespace: default
roleRef:
  kind: ClusterRole
  name: cluster-admin
  apiGroup: rbac.authorization.k8s.io

---
apiVersion: v1
kind: Service
metadata:
  name: akash-provider
  labels:
    app: akash-provider
spec:
  ports:
    - port: 3001
      name: http
      type: HTTP
  selector:
    app: akash-provider

---
apiVersion: apps/v1beta2
kind: Deployment
metadata:
  name: akash-provider
  labels:
    app: akash-provider
    akash.network/component: provider
spec:
  selector:
    matchLabels:
      app: akash-provider
  template:
    metadata:
      labels:
        app: akash-provider
        akash.network/component: provider
    spec:
      containers:
        - name: akash-provider
          image: "ovrclk/akash:latest"
          imagePullPolicy: IfNotPresent
          command:
            - "/akash"
            - "provider"
            - "run"
            - "${address}"
            - "--key"
            - "${key}"
            - "--private-key"
            - "/private/private.key"
            - "--kube"
          env:
            - name: AKASH_HOST
              value: http://${ingress}
            - name: AKASH_NODE
              value: "http://api.akashtest.net:80"
            - name: AKASH_DEPLOYMENT_SERVICE_TYPE
              value: "ClusterIP"
            - name: AKASH_DEPLOYMENT_INGRESS_STATIC_HOSTS
              value: "true"
            - name: AKASH_DEPLOYMENT_INGRESS_DOMAIN
              value: ${ingress}
          ports:
            - containerPort: 3001
              name: http
          volumeMounts:
            - name: config
              mountPath: /private
              readOnly: true
      volumes:
        - name: config
          secret:
            secretName: akash-provider-private-key
            items:
              - key: key
                path: private.key

---
apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: akash-provider
  labels:
    app: akash-provider
spec:
  rules:
    - host: ${ingress}
      http:
        paths:
          - backend:
              serviceName: akash-provider
              servicePort: http

EOF
```

Make sure the values are populated correctly and use `kubectl` to deploy:

```shell
kubectl apply -f akash-provider.yml
```
{% endtab %} {% endtabs %}

Confirm the provider is active by:

```shell
akash provider status $address
```

You should see a response similar to:

```text
Active Provider(s) Status
=========================

Provider:    	003be9da7457fa3d833b7e5d5da4ae98b2b4375fd52aa6d74434c5153005cdaa
Attributes:  	region: sfo
Version:     	commit: deaa5acdafb694eb7a00a4be701084b6f4f1b828 | date: 2019-10-17T21:27:32Z | version: 0.5.1
Leases:      	2
Deployments: 	0
Orders:      	0
Active:      	cpu: 500 | disk: 1.1 GB | mem: 537 MB
Pending:
Available:   	cpu: 7541 | disk: 222 GB | mem: 29 GB
Message(s):  	code=200  msg=OK
```
