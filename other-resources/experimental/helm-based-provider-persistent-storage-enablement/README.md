# Helm Based Provider Persistent Storage Enablement



## **Overview**

At Akash we use the Kubernetes Rook Operator coupled with the Ceph distributed file system to provision Provider persistent storage.

Refer to the [ Akash Provider](../akash-cloud-provider-build-with-helm-charts/) guide if your provider has not yet been built.

We encourage becoming familiar with Rook and Ceph prior to configuring Akash persistent storage via this [guide](https://rook.github.io/docs/rook/v1.8/).  The current persistent storage use is based on Rook version 1.8.

Please take into consideration the following Akash recommendations:

* Persistent storage should only be enabled on Kubernetes nodes that are NOT serving as control-plane/master nodes.  This does not apply if you are running all-in-one node deployment.
* Ceph will only deploy it’s distributed file system on unformatted volumes  A node must have unformatted volumes mounted to serve persistent storage capabilities.

Get started within the following sections:

* [Environment Review](environment-review.md)
* [Deploy Persistent Storage](deploy-persistent-storage.md)
* [Check Persistent Storage Health](check-persistent-storage-health.md)
* [Provider Attributes and Pricing Adjustments](provider-attributes-and-pricing-adjustments.md)
* [Label Nodes For Storage Classes](label-nodes-for-storage-classes.md)
* [Inventory Operator](inventory-operator.md)
* [Verifications](../provider-persistent-storage-enablement/verifications.md)
* [Teardown](teardown.md)\


\
 <a href="#ensure-unformatted-drives" id="ensure-unformatted-drives"></a>
-------------------------------------------------------------------------

