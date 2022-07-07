# Akash Provider Attribute Updates

## Pre-Update Attribute Captures

* Prior to updating the Provider's attributes, capture the current attributes
* We will use this current capture to compare against the updated provider subsequently

### On Chain Current Attributes Capture

#### Command Template

```
akash query provider get <provder-address>
```

#### Example Command

```
akash query provider get akash1xmz9es9ay9ln9x2m3q8dlu0alxf0ltce7ykjfx
```

#### Expected/Example Output

```
attributes:
- key: region
  value: us-west
- key: host
  value: akash
- key: tier
  value: community
- key: organization
  value: akashtesting
host_uri: https://provider.akashtesting.xyz:8443
info:
  email: ""
  website: ""
owner: akash1xmz9es9ay9ln9x2m3q8dlu0alxf0ltce7ykjfx
```

## Provider Update

### **Environment Variables**

* Declare the following environment variables for Helm
* Replace the variable  with your own settings

```
ACCOUNT_ADDRESS=akash1XXXX #akash provider address that starts with `akash1`
KEY_PASSWORD=12341234 #set to the password you have entered upon `akash keys export <key-name> > key.pem`; this is for the akash-provider pod to decrypt the key
DOMAIN=test.com  #Registers DNS A and wildcard address as specified in previous step, i.e. `provider.test.com` DNS A record and `*.ingress.test.com` DNS wildcard record
NODE=http://<IP_address_of_your_RPC_node>:26657  # if you are going to deploy Akash RPC Node using Helm-Charts then set it to `http://akash-node-1:26657`
```

*   Ensure you are applying the latest version of subsequent Helm Charts install/upgrade steps

    ```
    helm repo update
    ```

### Create a provider.yaml File

* Issue the following command to update your Akash Provider
* Update and/or add to the attributes keys for your unique use case

```
cd ~

mkdir provider

cd provider

cat > provider.yaml << EOF
---
from: "$ACCOUNT_ADDRESS"
key: "$(cat ~/key.pem | openssl base64 -A)"
keysecret: "$(echo $KEY_PASSWORD | openssl base64 -A)"
domain: "$DOMAIN"
node: "$NODE"
withdrawalperiod: 24h
attributes:
  - key: region
    value: "<YOUR REGION>"   # set your region here, e.g. "us-west"
  - key: host
    value: akash
  - key: tier
    value: community
  - key: organization
    value: "<YOUR ORG>"      # set your organization name here
EOF
```

#### Example/Fully Populated Provider YAML File

```
from: "$ACCOUNT_ADDRESS"
key: "$(cat ~/key.pem | openssl base64 -A)"
keysecret: "$(echo $KEY_PASSWORD | openssl base64 -A)"
domain: "$DOMAIN"
node: "$NODE"
withdrawalperiod: 24h
attributes:
  - key: region
    value: eu-west
  - key: host
    value: akash
  - key: tier
    value: community
  - key: organization
    value: chainzero
```

### Update Provider

```
helm upgrade akash-provider akash/provider -n akash-services -f provider.yaml
```

## Post Update Verifications

### On Chain Post Update Attributes Verification

#### Command Template

```
akash query provider get <provder-address>
```

#### Example Command

```
akash query provider get akash1xmz9es9ay9ln9x2m3q8dlu0alxf0ltce7ykjfx
```

#### Expected/Example Output

* Ensure that the new/updated attributes are now active

```
attributes:
- key: region
  value: eu-west
- key: host
  value: akash
- key: tier
  value: community
- key: organization
  value: chainzero
host_uri: https://provider.akashtesting.xyz:8443
info:
  email: ""
  website: ""
owner: akash1xmz9es9ay9ln9x2m3q8dlu0alxf0ltce7ykjfx
```
