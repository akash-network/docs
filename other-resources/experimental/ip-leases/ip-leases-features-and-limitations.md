# IP Leases Features and Limitations

## IP Leases Features

* Option for Tenants to request publicly routable IP addresses for the services they deploy
* Requested as part of a deployment
* Opens new deployment opportunities dependent on static public IP address
* Opens new deployment opportunities dependent on static port mappings
* Allows use of standard IP ports (0-1023 range) as well as others (0-65535 range)

## IP Leases Limitations

* If a deployment is updated the IP lease is retained
* If the lease is closed the IP address is not retained and the reservation of the IP address is lost
* An IP lease may be migrated to another deployment as detailed in this [section](ip-leases-migration.md). Using a migration it would be possible to transfer the IP lease to a new deployment and preserve the reserved address.
* Specific leased IP addresses are made available by a specific provider
* If a deployment is closed and moved to another provider there is no means to maintain or migrate the leased IP address
