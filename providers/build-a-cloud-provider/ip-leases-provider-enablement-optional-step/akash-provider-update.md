---
description: Update your pre-existing Akash provider to support IP Leases
---

# Akash Provider Update

### IP Leases Provider Setting

Update your provider configuration with the  necessary IP Leases  setting.  The setting will be added via an edit of your `provider.yaml` file and subsequent provider Helm update as detailed in this section.

#### Capture Current Provider Settings to File

* Issue this command to capture current provider settings and write to file

```
cd ~

helm -n akash-services get values akash-provider | grep -v ^USER > provider.yaml
```

#### Update Provider Settings

Open the file containing the current provider settings

```
cd ~

vi provider.yaml
```

#### Add the IP Operator Key-Value Pair

```
ipoperator: true
```

#### Example Provider YAML Post Update

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
domain: akashtesting.xyz
from: akash1xmz9es9ay9ln9x2m3q8dlu0alxf0ltce7ykjfx
key: <redacted>
keysecret: <redacted>
node: http://akash.c29r3.xyz:80/rpc
withdrawalperiod: 24h
ipoperator: true
```

### Update Provider Command Template

```
helm upgrade akash-provider akash/provider -n akash-services -f provider.yaml
```

#### Expected/Example Output

```
root@node1:~/provider# helm upgrade akash-provider akash/provider -n akash-services -f provider.yaml --set ipoperator=true
Release "akash-provider" has been upgraded. Happy Helming!
NAME: akash-provider
LAST DEPLOYED: Wed Aug 10 20:35:10 2022
NAMESPACE: akash-services
STATUS: deployed
REVISION: 2
TEST SUITE: None
```

## Verification

Run the following command to verify the the IP Operator setting

```
kubectl -n akash-services get statefulsets akash-provider -o yaml | grep -i -A1 ip_oper
```

#### Expected/Example Output

```
# kubectl -n akash-services get statefulsets akash-provider -o yaml | grep -i -A1 ip_oper
        - name: AKASH_IP_OPERATOR
          value: "true"
```
