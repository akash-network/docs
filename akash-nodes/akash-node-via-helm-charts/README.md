# Akash Node Via Helm Charts

Build an Akash Node quickly and simply with a deployment onto your Kubernetes cluster via a ready to use Helm Chart.

The Akash Node build detailed takes advantage of "state sync" which allows rapid activation.  State Sync allows a new node to join a network by fetching a snapshot of the state at a recent height instead of fetching and replaying all historical blocks. This can reduce the time needed to sync with the network from hours to minutes.

Steps in this guide include:

* **STEP 1** - [Prepare Kubernetes Cluster](prepare-kubernetes-cluster.md)
* **STEP 2** - [Akash Node Installation](akash-node-installation.md)
* **STEP 3** - [Node Verifications](node-verifications.md)
