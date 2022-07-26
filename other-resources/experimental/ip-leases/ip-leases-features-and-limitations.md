# IP Leases Features and Limitations

This section details Akash IP Leases features and limitations

## Duration of Lease

* If a deployment is updated the IP lease is retained
* However if the lease is closed the IP address is not retained and the reservation of the IP address is lost
* An IP lease may be migrated to another deployment as detailed in this [section](ip-leases-migration.md). Using a migration it would be possible to transfer the IP lease to a new deployment and preserve the reserved address.

## Provider Centric

* Specific leased IP addresses are made available by a specific provider
* If a deployment is closed and moved to another provider there is no means to maintain or migrate the leased IP address
