# IP Leases Migration

When starting a deployment on a provider that already has a deployment from the same owner utilizing the same endpoint names, the new deployment will have no IP address allocated initially.

### Migration Steps

You can migrate an IP address between two deployments on the same provider. This is done by using the `akash provider migrate-endpoints` command.&#x20;

To migrate an endpoint between two deployments, the endpoint must be declared with identical names in both deployments.

#### Migrate Command Template

* The DSEQ specified should be that of the deployment the IP address should be migrated to

```
akash provider migrate-endpoints --from <key-name> --dseq <dseq-number> --provider=<provider-address> <hostname>
```

#### Migrate Command Example

```
akash provider migrate-endpoints --from mykey --dseq 250172 --provider=akash16l4nf3z6xttgk673q536p873axmy8c7aggre3g myendpoint
```

#### &#x20;
