# Persistent Storage Limitations

## Persistence of Storage

Please note that storage only persists during the lease. The storage is lost when:

* The deployment is migrated to a different provider.
* The deployment’s lease is closed.  Even when relaunched onto the same provider, storage will not persist across leases.
* Shared volumes are not currently supported.  If a SDL defines a single profile with a persistent storage definition - and that profile is then used by multiple services - individual, unique volumes will be created per service.

## Deployment Specifications

* Note that currently only a single persistent volume is allowed/supported per service definition in the Akash SDL.  It is not possible to mount multiple persistent volumes in a service.

## Additional Details

When planning to use persistent storage in a deployment, take into account the network (between the storage nodes) as a factor which will cause the latency, causing slower disk throughput / IOPS. This might not be suitable for heavy IOPS applications such as a Solana validator.
