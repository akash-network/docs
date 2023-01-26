# IP Leases Migration

The migration steps in this section are useful when you need to make changes to an existing deployment - which require deploying the app anew - and there is a desire to limit down time as we transition to the new, updated deployment.

When starting the new deployment - on the same  provider as the pre-existing deployment and with the same IP Leases endpoint name - the new deployment will have no IP address allocated initially.  Used the Migration Steps below to transition the IP lease from the pre-existing to new/updated deployment.

### Migration Steps

You can migrate an IP address between two active deployments on the same provider. This is done by using the `akash provider migrate-endpoints` command.&#x20;

To migrate an endpoint between two deployments, the endpoint must be declared with identical names in both deployments.

#### Migrate Command Template

* The DSEQ specified should be that of the deployment the IP address should be migrated to

```
provider-services migrate-endpoints --from <key-name> --dseq <dseq-number> --provider=<provider-address> <endpoint-name>
```

#### Migrate Command Example

```
provider-services migrate-endpoints --from mykey --dseq 250172 --provider=akash16l4nf3z6xttgk673q536p873axmy8c7aggre3g myendpoint
```

## Migration Example

To experiment with the IP Leases migration functionality follow these steps.  This example is provided simply to clarify the steps and functionality of the migration process that could be used for your own applications.

* STEP 1 - create a deployment using the [full SDL example](full-sdl-example-with-ip-leases.md) in this guide
* STEP 2 - create a second deployment using the [full SDL example](full-sdl-example-with-ip-leases.md) in this guide.  No changes to the SDL are necessary.
* STEP 3 - observe that the IP lease remains on the first deployment made
* STEP 4 - with the goal of migrating the IP lease to the new/second deployment - execute the migration steps detailed in this [section](ip-leases-migration.md#migration-steps)
* STEP 5 - following the successful IP Leases migration - observe that the IP lease is now active on the second/new deployment
* STEP 6 - close the first deployment completing the example of migrating an IP lease to new/updated deployment with little down time during the transition&#x20;
