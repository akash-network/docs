# STEP 1 - Clone the Kubespray Project

## Cluster Recommendations

We recommend using the Kubespray project to deploy a cluster. Kubespray uses Ansible to make the deployment of a Kubernetes cluster easy.

The recommended minimum number of hosts is four for a production Provider Kubernetes cluster. This is meant to allow:

* Three hosts serving as a redundant control plane/master instances
* One host to serve as Kubernetes worker node to host provider leases.&#x20;

### Additional Cluster Sizing Considerations

> While a production Kubernetes cluster would typically require three redundant control plane nodes, in circumstances in which the control plane node is easily recoverable the use of a single control instance for Akash providers should suffice.

> The number of control plane nodes in the cluster should always be an odd number to allow the cluster to reach consensus.

> We recommend running a single worker node per physical server as CPU is typically the largest resource bottleneck.  The use of a single worker node allows larger workloads to be deployed on your provider.

> If you intended to build a provider with persistent storage please refer to host requirements detailed [here](../helm-based-provider-persistent-storage-enablement/persistent-storage-requirements.md).

## Kubernetes Cluster Software/Hardware Requirements and Recommendations

### Software Recommendation

Akash Providers have been tested on Ubuntu 22.04 with the default Linux kernel. Your experience may vary should install be attempted using a different Linux distro/kernel.

### Kubernetes Master Node Requirements

* Minimum Specs
  * 2 CPU
  * 4 GB RAM
  * 30 GB disk
* Recommended Specs
  * 4 CPU
  * 8 GB RAM
  * 40 GB disk

### Kubernetes Work Node Requirements

* Minimum Specs
  * 4 CPU
  * 8 GB
  * 100 GB disk
* Recommendations
  * The more resources the better depending on your goal of maximum number of concurrent deployments.&#x20;
  * Especially important to note that worker node needs to have as much CPU as possible, because if it's got, say 8 CPU and, 100 GB RAM, and 2 TB disk -> the cpu would likely be a bottleneck. Since people tend to deploy at least 1 CPU per deployment, the server could only host 8 deployments maximum and likely about 6 deployments as other \~2 CPU will be reserved by the Kubernetes system components.

## **etcd Hardware Recommendations**

* Use this [guide](https://etcd.io/docs/v3.3/op-guide/hardware) to ensure Kubernetes control plane nodes meet the recommendations for hosting a `etcd` database.

## **Kubespray Clone**

Install Kubespray on a machine that has connectivity to the hosts that will serve as the Kubernetes cluster.  Kubespray should not be installed on the Kubernetes hosts themselves but rather on a machine that has connectivity to the Kubernetes hosts.

### Kubespray Host Recommendation

We recommend installing Kubespray on Ubuntu 22.04.  Versions prior it Ubuntu 20.X may experience issues with recent Ansible versions specified in later steps.

### Clone the Kubespray Project

Obtain Kubespray and navigate into the created local directory:

```
cd ~

git clone -b v2.21.0 --depth=1 https://github.com/kubernetes-sigs/kubespray.git

cd kubespray
```

## Cluster Updates

To update the Kubernetes cluster in the future, review the[ latest Kubespray documentation](https://github.com/kubernetes-sigs/kubespray/blob/master/docs/upgrades.md) to take advantage of recent bug fixes and enhancements.
