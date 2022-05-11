# Deploy Persistent Storage

## **Helm Install**

Install Helm and add the Akash repo if not done previously by following the steps in this [guide](../akash-cloud-provider-build-with-helm-charts/step-4-helm-installation-on-kubernetes-node.md)**.**

## **Execute Rook Deployment**

* Step in this section should be conducted from the Kubernetes master node on which Helm has been installed
* Replace `NODE-NAME` in the Helm command provided with the name of the node on which persistent storage will be hosted.  It is important to use the Kubernetes name of the target node as collected from `kubectl get nodes` in a previous step.
* Deployment typically takes approximately 10 minutes to complete**.**
* Note - if any issues are encountered during the Rook deployment, tear down the Rook-Ceph components via the steps listed [here ](../provider-persistent-storage-enablement/teardown.md)and begin anew.

```
kubectl create -f https://raw.githubusercontent.com/ovrclk/helm-charts/main/charts/akash-rook/crds.yaml

helm install akash-rook akash/akash-rook -n akash-services --set nodes[0].name="NODE-NAME",nodes[0].config=""
```
