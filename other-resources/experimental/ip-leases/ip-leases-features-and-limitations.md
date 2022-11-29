# IP Leases Features and Limitations

## IP Leases Features

* Option for Tenants to request publicly routable IP addresses for the services they deploy
* IP Lease can be ordered as part of a deployment
* Opens new deployment opportunities dependent: on&#x20;
  * Static public IP address
  * Static port mappings
* Allows use of all ports (1-65535 range)

## IP Leases Limitations

* If a deployment is updated the IP lease is retained.  However if the lease is closed the IP address is not retained and the reservation of the IP address is lost.
* IP Leases is only valid for inbound communications.  Any communication initiated from within the deployment outbound will utilize a shared IP address from the provider.  However and based on the nature of TCP communications, responses to inbound initiated traffic will use the IP Leases address.
* An IP lease may be migrated to another deployment as detailed in this [section](ip-leases-migration.md). Using a migration it would be possible to transfer the IP lease to a new deployment and preserve the reserved address.
* If a deployment is closed and moved to another provider there is no means to maintain or migrate the leased IP address
* Not all providers offer the IP Leases and is currently limited to providers using [MetalLB. ](https://metallb.universe.tf/installation/clouds/)However some providers might use [alternative, custom load balancers](https://metallb.universe.tf/installation/clouds/#alternatives) such as `keepalive-vip`.
