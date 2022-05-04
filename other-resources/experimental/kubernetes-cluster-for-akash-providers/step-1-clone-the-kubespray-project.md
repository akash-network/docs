# STEP 1 - Clone the Kubespray Project

## Cluster Recommendations

We recommend using the Kubespray project to deploy a cluster. Kubespray uses Ansible to make the deployment of a Kubernetes cluster easy.

The recommended minimum number of hosts is four. This is meant to allow:

* Three hosts serving as a redundant master nodes
* One host to serve as Kubernetes worker node to host provider leases
* NOTE - if you intended to build a provider with persistent storage please refer to host requirements detailed [here](https://docs.akash.network/testnet-technical-docs/provider-persistent-storage-enablement).

While you could use a single Kubernetes host in testing and dev this would not be recommended for production.

## **Kubespray Clone**

Install Kubespray on a machine that has connectivity to the hosts that will serve as the Kubernetes cluster.  Kubespray should not be installed on the Kubernetes hosts themselves but rather on a machine that has connectivity to the Kubernetes hosts.

Obtain Kubespray and navigate into the created local directory:

```
cd ~

git clone https://github.com/kubernetes-sigs/kubespray.git

cd kubespray
```
