# Helm Based Provider Persistent Storage Enablement



## **Overview**

At Akash we use the Kubernetes Rook Operator coupled with the Ceph distributed file system to provision Provider persistent storage.

Refer to the [ Akash Provider](../akash-cloud-provider-build-with-helm-charts/) guide if your provider has not yet been built.

We encourage becoming familiar with Rook and Ceph prior to configuring Akash persistent storage via this [guide](https://rook.github.io/docs/rook/v1.9/).  The current persistent storage use is based on Rook version 1.9.

Please take into consideration the following Akash recommendations:

* Persistent storage should only be enabled on Kubernetes nodes that are NOT serving as control-plane/master nodes.  This does not apply if you are running all-in-one node deployment.
* Ceph will only deploy it’s BlueStore on unformatted volumes.  A node must have unformatted volumes mounted to serve persistent storage capabilities.
* Ceph uses BlueStore as its default backend to store the objects in a monolithic database-like fashion.
* To read more on Ceph Architecture go [here](https://docs.ceph.com/en/quincy/architecture/).

Get started within the following sections:



* [Persistent Storage Requirements](persistent-storage-requirements.md)
* [Environment Review](environment-review.md)
* [Deploy Persistent Storage](deploy-persistent-storage.md)
* [Check Persistent Storage Health](check-persistent-storage-health.md)
* [Provider Attributes and Pricing Adjustments](provider-attributes-and-pricing-adjustments.md)
* [Label Nodes For Storage Classes](label-nodes-for-storage-classes.md)
* [Inventory Operator](inventory-operator.md)
* [Verifications](broken-reference)
* [Teardown](teardown.md)\


\
 <a href="#ensure-unformatted-drives" id="ensure-unformatted-drives"></a>
-------------------------------------------------------------------------

