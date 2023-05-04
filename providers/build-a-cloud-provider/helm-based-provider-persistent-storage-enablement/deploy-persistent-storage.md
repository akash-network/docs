# Deploy Persistent Storage

## **Helm Install**

Install Helm and add the Akash repo if not done previously by following the steps in this [guide](../akash-cloud-provider-build-with-helm-charts/step-4-helm-installation-on-kubernetes-node.md)**.**

All steps in this section should be conducted from the Kubernetes master node on which Helm has been installed.

Rook has published the following Helm charts for the Ceph storage provider:

* Rook Ceph Operator: Starts the Ceph Operator, which will watch for Ceph CRs (custom resources)
* Rook Ceph Cluster: Creates Ceph CRs that the operator will use to configure the cluster

The Helm charts are intended to simplify deployment and upgrades.

## Persistent Storage Deployment

* **Note** - if any issues are encountered during the Rook deployment, tear down the Rook-Ceph components via the steps listed [here](teardown.md) and begin anew.
* Deployment typically takes approximately 10 minutes to complete**.**

### Migration procedure

If you already have the `akash-rook` helm chart installed, make sure to use the following documentation:

* [Migration from akash-rook to the upstream rook-ceph Helm Charts](https://gist.github.com/andy108369/cd3ab76884f9006611a2becb4b3ccb4f)

### Rook Ceph repository

#### Add Repo

* Add the Rook repo to Helm

```
helm repo add rook-release https://charts.rook.io/release
```

* Expected/Example Result

```
# helm repo add rook-release https://charts.rook.io/release

"rook-release" has been added to your repositories
```

#### Verify Repo

* Verify the Rook repo has been added

```
helm search repo rook-release --version v1.10.11
```

* Expected/Example Result

```
# helm search repo rook-release --version v1.10.11

NAME                          	CHART VERSION	APP VERSION	DESCRIPTION                                       
rook-release/rook-ceph        	v1.10.11       	v1.10.11     	File, Block, and Object Storage Services for yo...
rook-release/rook-ceph-cluster	v1.10.11       	v1.10.11     	Manages a single Ceph cluster namespace for Rook  
```

### **Deployment Steps**

#### **STEP 1 - Install Ceph Operator Helm Chart**

#### **Testing**

> For additional Operator chart values refer to [this](https://github.com/rook/rook/blob/v1.9.9/deploy/charts/rook-ceph/values.yaml) page.

#### All In One Provisioner Replicas

> For all-in-one deployments, you will likely want only one replica of the CSI provisioners.
>
> * Add following to  `rook-ceph-operator.values.yml` created in the subsequent step
> * By setting `provisionerReplicas` to `1`, you ensure that only a single replica of the CSI provisioner is deployed. This defaults to `2` when it is not explicitly set.

```
csi:
 provisionerReplicas: 1
```

#### Default Resource Limits

You can disable default resource limits by using the following yaml config, this is useful when testing:

```
cat > rook-ceph-operator.values.yml << 'EOF'
resources:
csi:
  csiRBDProvisionerResource:
  csiRBDPluginResource:
  csiCephFSProvisionerResource:
  csiCephFSPluginResource:
  csiNFSProvisionerResource:
  csiNFSPluginResource:
EOF
```

### Install the Operator Chart

```
helm upgrade --install --create-namespace -n rook-ceph rook-ceph rook-release/rook-ceph --version 1.10.11 -f rook-ceph-operator.values.yml
```

**PRODUCTION**

> No customization is required by default.

* Install the Operator chart:

```
helm upgrade --install --create-namespace -n rook-ceph rook-ceph rook-release/rook-ceph --version 1.10.11
```

#### STEP 2 - Install Ceph Cluster Helm Chart

> For additional Cluster chart values refer to [this](https://github.com/rook/rook/blob/v1.9.9/deploy/charts/rook-ceph-cluster/values.yaml) page.\
> For custom storage configuration refer to [this](https://rook.io/docs/rook/v1.9/ceph-cluster-crd.html#storage-configuration-specific-devices) example.

**TESTING / ALL-IN-ONE**

> * Update `deviceFilter` to match your disks
> * Change storageClass name from `beta3` to one you are planning to use based on this [table](https://docs.akash.network/providers/build-a-cloud-provider/helm-based-provider-persistent-storage-enablement/storage-class-types)
> * Add your nodes you want the Ceph storage to use the disks on under the `nodes` section; (make sure to change `node1`, `node2`, ... to your K8s node names!
>
> When planning all-in-one production provider (or a single storage node) with multiple storage drives (minimum 3):
>
> * Change `failureDomain` to `osd`
> * Change `min_size` to `2`and size to `3`
> * Comment or remove `resources:` field to make sure Ceph services will get enough resources before running them

```
cat > rook-ceph-cluster.values.yml << 'EOF'
operatorNamespace: rook-ceph

configOverride: |
  [global]
  osd_pool_default_pg_autoscale_mode = on
  osd_pool_default_size = 1
  osd_pool_default_min_size = 1

cephClusterSpec:
  resources:

  mon:
    count: 1
  mgr:
    count: 1

  storage:
    useAllNodes: false
    useAllDevices: false
    deviceFilter: "^nvme."
    config:
      osdsPerDevice: "1"
    nodes:
    - name: "node1"
      config:

cephBlockPools:
  - name: akash-deployments
    spec:
      failureDomain: host
      replicated:
        size: 1
      parameters:
        min_size: "1"
        bulk: "true"
    storageClass:
      enabled: true
      name: beta3
      isDefault: true
      reclaimPolicy: Delete
      allowVolumeExpansion: true
      parameters:
        # RBD image format. Defaults to "2".
        imageFormat: "2"
        # RBD image features. Available for imageFormat: "2". CSI RBD currently supports only `layering` feature.
        imageFeatures: layering
        # The secrets contain Ceph admin credentials.
        csi.storage.k8s.io/provisioner-secret-name: rook-csi-rbd-provisioner
        csi.storage.k8s.io/provisioner-secret-namespace: rook-ceph
        csi.storage.k8s.io/controller-expand-secret-name: rook-csi-rbd-provisioner
        csi.storage.k8s.io/controller-expand-secret-namespace: rook-ceph
        csi.storage.k8s.io/node-stage-secret-name: rook-csi-rbd-node
        csi.storage.k8s.io/node-stage-secret-namespace: rook-ceph
        # Specify the filesystem type of the volume. If not specified, csi-provisioner
        # will set default as `ext4`. Note that `xfs` is not recommended due to potential deadlock
        # in hyperconverged settings where the volume is mounted on the same node as the osds.
        csi.storage.k8s.io/fstype: ext4

  - name: akash-nodes
    spec:
      failureDomain: host
      replicated:
        size: 1
      parameters:
        min_size: "1"
    storageClass:
      enabled: true
      name: akash-nodes
      isDefault: false
      reclaimPolicy: Delete
      allowVolumeExpansion: true
      parameters:
        # RBD image format. Defaults to "2".
        imageFormat: "2"
        # RBD image features. Available for imageFormat: "2". CSI RBD currently supports only `layering` feature.
        imageFeatures: layering
        # The secrets contain Ceph admin credentials.
        csi.storage.k8s.io/provisioner-secret-name: rook-csi-rbd-provisioner
        csi.storage.k8s.io/provisioner-secret-namespace: rook-ceph
        csi.storage.k8s.io/controller-expand-secret-name: rook-csi-rbd-provisioner
        csi.storage.k8s.io/controller-expand-secret-namespace: rook-ceph
        csi.storage.k8s.io/node-stage-secret-name: rook-csi-rbd-node
        csi.storage.k8s.io/node-stage-secret-namespace: rook-ceph
        # Specify the filesystem type of the volume. If not specified, csi-provisioner
        # will set default as `ext4`. Note that `xfs` is not recommended due to potential deadlock
        # in hyperconverged settings where the volume is mounted on the same node as the osds.
        csi.storage.k8s.io/fstype: ext4

# Do not create default Ceph file systems, object stores
cephFileSystems:
cephObjectStores:

# Spawn rook-ceph-tools, useful for troubleshooting
toolbox:
  enabled: true
  resources:
EOF
```

**PRODUCTION**

> * Update `deviceFilter` to match your disks
> * Change storageClass name from `beta3` to one you are planning to use based on this [table](https://docs.akash.network/providers/build-a-cloud-provider/helm-based-provider-persistent-storage-enablement/storage-class-types)
> * Update `osdsPerDevice` based on this [table](https://docs.akash.network/providers/build-a-cloud-provider/helm-based-provider-persistent-storage-enablement/storage-class-types)
> * Add your nodes you want the Ceph storage to use the disks on under the `nodes` section; (make sure to change `node1`, `node2`, ... to your K8s node names!
> * When planning a single storage node with multiple storage drives (minimum 3):
>   * Change `failureDomain` to `osd`

```
cat > rook-ceph-cluster.values.yml << 'EOF'
operatorNamespace: rook-ceph

configOverride: |
  [global]
  osd_pool_default_pg_autoscale_mode = on
  osd_pool_default_size = 3
  osd_pool_default_min_size = 2

cephClusterSpec:
  resources:
    prepareosd:
      limits:
        memory: "800Mi"

  mon:
    count: 3
  mgr:
    count: 2

  storage:
    useAllNodes: false
    useAllDevices: false
    deviceFilter: "^nvme."
    config:
      osdsPerDevice: "2"
    nodes:
    - name: "node1"
      config:
    - name: "node2"
      config:
    - name: "node3"
      config:

cephBlockPools:
  - name: akash-deployments
    spec:
      failureDomain: host
      replicated:
        size: 3
      parameters:
        min_size: "2"
        bulk: "true"
    storageClass:
      enabled: true
      name: beta3
      isDefault: true
      reclaimPolicy: Delete
      allowVolumeExpansion: true
      parameters:
        # RBD image format. Defaults to "2".
        imageFormat: "2"
        # RBD image features. Available for imageFormat: "2". CSI RBD currently supports only `layering` feature.
        imageFeatures: layering
        # The secrets contain Ceph admin credentials.
        csi.storage.k8s.io/provisioner-secret-name: rook-csi-rbd-provisioner
        csi.storage.k8s.io/provisioner-secret-namespace: rook-ceph
        csi.storage.k8s.io/controller-expand-secret-name: rook-csi-rbd-provisioner
        csi.storage.k8s.io/controller-expand-secret-namespace: rook-ceph
        csi.storage.k8s.io/node-stage-secret-name: rook-csi-rbd-node
        csi.storage.k8s.io/node-stage-secret-namespace: rook-ceph
        # Specify the filesystem type of the volume. If not specified, csi-provisioner
        # will set default as `ext4`. Note that `xfs` is not recommended due to potential deadlock
        # in hyperconverged settings where the volume is mounted on the same node as the osds.
        csi.storage.k8s.io/fstype: ext4

  - name: akash-nodes
    spec:
      failureDomain: host
      replicated:
        size: 3
      parameters:
        min_size: "2"
    storageClass:
      enabled: true
      name: akash-nodes
      isDefault: false
      reclaimPolicy: Delete
      allowVolumeExpansion: true
      parameters:
        # RBD image format. Defaults to "2".
        imageFormat: "2"
        # RBD image features. Available for imageFormat: "2". CSI RBD currently supports only `layering` feature.
        imageFeatures: layering
        # The secrets contain Ceph admin credentials.
        csi.storage.k8s.io/provisioner-secret-name: rook-csi-rbd-provisioner
        csi.storage.k8s.io/provisioner-secret-namespace: rook-ceph
        csi.storage.k8s.io/controller-expand-secret-name: rook-csi-rbd-provisioner
        csi.storage.k8s.io/controller-expand-secret-namespace: rook-ceph
        csi.storage.k8s.io/node-stage-secret-name: rook-csi-rbd-node
        csi.storage.k8s.io/node-stage-secret-namespace: rook-ceph
        # Specify the filesystem type of the volume. If not specified, csi-provisioner
        # will set default as `ext4`. Note that `xfs` is not recommended due to potential deadlock
        # in hyperconverged settings where the volume is mounted on the same node as the osds.
        csi.storage.k8s.io/fstype: ext4

# Do not create default Ceph file systems, object stores
cephFileSystems:
cephObjectStores:

# Spawn rook-ceph-tools, useful for troubleshooting
toolbox:
  enabled: true
  #resources:
EOF
```

* Install the Cluster chart:

```
helm upgrade --install --create-namespace -n rook-ceph rook-ceph-cluster \
   --set operatorNamespace=rook-ceph rook-release/rook-ceph-cluster --version 1.10.11 -f rook-ceph-cluster.values.yml
```

#### STEP 3 - Label the storageClass

> This label is mandatory and is [used](https://github.com/ovrclk/k8s-inventory-operator/blob/v0.1.4/ceph.go#L185) by the Akash's `inventory-operator` for searching the storageClass.

* Change beta3 to your storageClass you have picked before

```
kubectl label sc akash-nodes akash.network=true
kubectl label sc beta3 akash.network=true
```

#### STEP 4 - Update Failure Domain (Single Storage Node or All-In-One Scenarios Only)

> When running a single storage node or all-in-one, make sure to change the failure domain from `host` to `osd` for the `.mgr` pool.

```
kubectl -n rook-ceph exec -it $(kubectl -n rook-ceph get pod -l "app=rook-ceph-tools" -o jsonpath='{.items[0].metadata.name}') -- bash

ceph osd crush rule create-replicated replicated_rule_osd default osd
ceph osd pool set .mgr crush_rule replicated_rule_osd
```
