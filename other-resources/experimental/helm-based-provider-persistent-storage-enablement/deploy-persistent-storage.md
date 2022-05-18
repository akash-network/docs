# Deploy Persistent Storage

## **Helm Install**

Install Helm and add the Akash repo if not done previously by following the steps in this [guide](../akash-cloud-provider-build-with-helm-charts/step-4-helm-installation-on-kubernetes-node.md)**.**

## **Rook Deployment**

* Step in this section should be conducted from the Kubernetes master node on which Helm has been installed
* Replace `NODE-NAME` in the Helm command provided with the name of the node on which persistent storage will be hosted.  It is important to use the Kubernetes name of the target node as collected from `kubectl get nodes` in a previous step.
* Deployment typically takes approximately 10 minutes to complete**.**
* **Note** - the Helm chart's values.yaml file has a persistent storage class setting equal to `beta2`.  If a different class is needed, include a switch with the helm install command such as `--set persistent_storage.class=beta3`
* **Note** - if any issues are encountered during the Rook deployment, tear down the Rook-Ceph components via the steps listed [here ](broken-reference)and begin anew.

```
kubectl create -f https://raw.githubusercontent.com/ovrclk/helm-charts/main/charts/akash-rook/crds.yaml
```

### Single Persistent Storage Node Build

* Use this Helm Chart command in an environment in which a single node will host persistent storage

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

```
helm install akash-rook akash/akash-rook -n akash-services --set nodes[0].name="NODE-NAME",nodes[0].config="",nodes[1].name="NODE-NAME",nodes[1].config=""
```

#### Example Command

```
helm install akash-rook akash/akash-rook -n akash-services --set nodes[0].name="node2",nodes[0].config="",nodes[1].name="node3",nodes[1].config=""
```
