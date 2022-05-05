# Provider Persistent Storage Enablement



## **Overview**

At Akash we use the Kubernetes Rook Operator coupled with the Ceph distributed file system to provision Provider persistent storage.

Refer to the  [Akash Provider](broken-reference) guide if your provider has not yet been built.

We encourage becoming familiar with Rook and Ceph prior to configuring Akash persistent storage via this [guide](https://rook.github.io/docs/rook/v1.8/).  The current persistent storage use is based on Rook version 1.8.

Please take into consideration the following Akash recommendations:

* Persistent storage should only be enabled on Kubernetes nodes that are NOT serving as control-plane/master nodes.
* Ceph will only deploy it’s distributed file system on unformatted volumes  A node must have unformatted volumes mounted to serve persistent storage capabilities.

Get started within the following sections:

* [Clone Akash Repo](broken-reference)
* [Environmental Variable Config](broken-reference)
* [Retrieve Nodes](broken-reference)
* [Edit Cluster.yaml Config](broken-reference)
* [Deploy Persistent Storage](broken-reference)
* [Check Persistent Storage Health](broken-reference)
* [Provider Attributes and Pricing Adjustments](broken-reference)
* [Label Nodes For Storage Classes](broken-reference)
* [Inventory Operator](broken-reference)
* [Verifications](broken-reference)
*   [Teardown](broken-reference)\


    \
     <a href="#attribute-adjustments" id="attribute-adjustments"></a>
    -----------------------------------------------------------------

    \
     <a href="#ensure-unformatted-drives" id="ensure-unformatted-drives"></a>
    -------------------------------------------------------------------------

