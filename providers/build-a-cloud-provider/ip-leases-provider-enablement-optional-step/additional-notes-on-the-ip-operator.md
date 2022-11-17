# Additional notes on the IP Operator

If running non-Helm-based Akash Provider, then make sure to set the following&#x20;

```
AKASH_IP_OPERATOR=true
```

* Alternatively this could be passed in via CLI argument

```
provider-services run --ip-operator=true
```

* Additional ensure that the Akash provider IP operator is running (`provider-services ip-operator`)
