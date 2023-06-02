# STEP 11 - Extras

## Force New ReplicaSet Workaround

A known issue exists which occurs when a deployment update is attempted and fails due to the provider being out of resources. This is happens because K8s won't destroy an old pod instance until it ensures the new one has been created.

Follow the steps in the [Force New ReplicaSet Workaround](../../akash-provider-troubleshooting/force-new-replicaset-workaround.md) document to address this issue.
