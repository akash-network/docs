# Persistent Storage Limitations

Please note that storage only persists during the lease. The storage is lost when:

* The deployment is migrated to a different provider.
* The deployment’s lease is closed.  Even when relaunched onto the same provider, storage will not persist across leases.

When planning to use persistent storage in a deployment, take into account the network (between the storage nodes) as a factor which will cause the latency, causing slower disk throughput / IOPS. This might not be suitable for heavy IOPS applications such as a Solana validator.
