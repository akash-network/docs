# STEP 11 - Extras

## Force New ReplicaSet Workaround

A known issue exists which occurs when a deployment update is attempted and fails due to the provider being out of resources. This is happens because K8s won't destroy an old pod instance until it ensures the new one has been created.

Follow the steps in the [Force New ReplicaSet Workaround](../../akash-provider-troubleshooting/force-new-replicaset-workaround.md) document to address this issue.

## Kill Zombie Processes

A known issue exists which occurs when a tenant creates a deployment which doesn't handle child processes properly, leaving the defunct (aka zombie) proceses behind.
These could potentially occupy all available process slots.

Follow the steps in the [Kill Zombie Processes](../../akash-provider-troubleshooting/kill-zombie-processes.md) document to address this issue.

