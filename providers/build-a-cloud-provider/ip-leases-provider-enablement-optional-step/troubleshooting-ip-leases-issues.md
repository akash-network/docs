# Troubleshooting IP Leases Issues

## Issues Following IP Leases Install

If either of the symptoms listed in this section are apparent following initial IP Leases installation, cure the issue by bouncing the `ip-operator` pod as follows:

```
kubectl -n akash-services delete pod -l app=akash-ip-operator
```

### Symptoms

1. The Akash Provider isn't replying to 8443/status endpoint (I.e. `curl -ks https://provider.xyz.com:8443/status`)
2. The `akash-ip-operator` has `barrier is locked messages` in its logs.  Which can be gathered via:

```
kubectl -n akash-services logs -l akash.network/component=akash-ip-operator -f
```

#### Example Log Output When Issue Exists

```
kubectl -n akash-services logs -l akash.network/component=akash-ip-operator -f
...
E[2023-06-22|13:11:42.428] barrier is locked, can't service request     operator=ip path=/health
E[2023-06-22|13:11:44.430] barrier is locked, can't service request     operator=ip path=/health
```
