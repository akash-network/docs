# Persistent Storage Limitations

Please note that storage only persists during the lease. The storage is lost when:

* The deployment is migrated to a different provider.
* The deployment’s lease is closed.  Even when relaunched onto the same provider, storage will not persist across leases.
