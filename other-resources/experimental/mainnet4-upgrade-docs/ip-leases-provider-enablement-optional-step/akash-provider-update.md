# Akash Provider Update

Update your pre-existing Akash provider to support IP Leases.

### Attribute Update

Update your provider to advertise the following attribute.  This attribute can be used (by users deploying on Akash) to select providers supporting the IP Lease.

```
- key: ip-lease
  value: true
```

### Command Template

```
helm upgrade akash-provider akash/provider -n akash-services -f provider.yaml --set ipoperator=true
```

### Expected/Example Output

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
