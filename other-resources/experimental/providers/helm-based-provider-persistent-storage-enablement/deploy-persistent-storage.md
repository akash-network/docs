# Deploy Persistent Storage

## **Helm Install**

Install Helm and add the Akash repo if not done previously by following the steps in this [guide](../akash-cloud-provider-build-with-helm-charts/step-4-helm-installation-on-kubernetes-node.md)**.**

## **Rook Deployment**

* Step in this section should be conducted from the Kubernetes master node on which Helm has been installed

```
kubectl create -f https://raw.githubusercontent.com/ovrclk/helm-charts/provider-0.157.0/charts/akash-rook/crds.yaml
```

## Persistent Storage Deployment

* Replace `NODE-NAME` in the Helm command provided with the name of the node on which persistent storage will be hosted.  It is important to use the Kubernetes name of the target node as collected from `kubectl get nodes` in a previous step.
* **Note** - the Helm chart's values.yaml file has a persistent storage class setting equal to `beta2`.  Refer to [Storage Class Types](storage-class-types.md) doc section for further info.  If a different class is needed, include a switch with the helm install command such as `--set persistent_storage.class=beta3.`
* **Note** - using the default Helm Chart values - the build will attempt to use ALL un-initialized disks / partitions on specified nodes.  If this is not desired, add the following/example switch to the `helm install` command.
  * `--set useAllDevices=false --set deviceFilter="^nvme."`
* **Note** - if any issues are encountered during the Rook deployment, tear down the Rook-Ceph components via the steps listed [here](teardown.md) and begin anew.
* Deployment typically takes approximately 10 minutes to complete**.**

### Single Persistent Storage Node Build

* Use this Helm Chart command in an environment in which a single node will host persistent storage
* Single persistent storage node build isn't recommended for production and should be used mostly for testing. Refer to the production recommendations [here](deploy-persistent-storage.md#multiple-persistent-storage-nodes-build).

```
helm install akash-rook akash/akash-rook -n akash-services --set nodes[0].name="NODE-NAME",nodes[0].config=""
```

#### Example Command

```
helm install akash-rook akash/akash-rook -n akash-services --set nodes[0].name="node2",nodes[0].config=""
```

### Multiple Persistent Storage Nodes Build

* Use this Helm Chart command in an environment in which multiple nodes will host persistent storage
* In this example command two nodes are targeted for persistent storage.  Continue to define additional nodes as necessary using this syntax - for example a third node would be included such as `nodes[2].name="`NODE-NAME`",nodes[2].config=""`
* In this example command we are using the following Ceph settings:
  * MGR (manager) count 2 which is the minimum recommended value.  Also note that the maximum accept value is also 2.  Thus this setting should always be of count 2.
  * MON (monitor) count 3 which is the minimum recommended value.
  * OSDs count of 3 which is appropriate for SSD disks.  Adjust `-set osdsPerDevice` as necessary based on the disk type and the recommended settings [here](persistent-storage-requirements.md).

```
helm install akash-rook akash/akash-rook -n akash-services -set mgrCount=2 --set monCount=3 --set osdsPerDevice=3 --set nodes[0].name="NODE-NAME",nodes[0].config="",nodes[1].name="NODE-NAME",nodes[1].config=""
```

#### Example Command

```
helm install akash-rook akash/akash-rook -n akash-services -set mgrCount=2 --set monCount=3 --set osdsPerDevice=3 --set nodes[0].name="node2",nodes[0].config="",nodes[1].name="node3",nodes[1].config="",nodes[2].name="node4",nodes[2].config=""
```
