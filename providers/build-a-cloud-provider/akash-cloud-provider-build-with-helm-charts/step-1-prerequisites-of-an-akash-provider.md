# STEP 1 - Prerequisites of an Akash Provider

## Akash Wallet

Placing a bid on an order requires a 5 AKT deposit placed into collateral per bid won. If the provider desired 2 concurrent leases, the provider’s wallet would need minimum funding of 10AKT.

As every deployment request bid requires 5 AKT to be deposited in the escrow account, it's always good to have more so your provider can keep bidding. If your provider is ready to offer 10 deployments, then it's best to have 5 x 10 = 50 AKT and a little more to make sure provider can pay the fees for broadcasting the transactions on Akash Network.

The steps to create an Akash wallet are covered in the following documentation sections:

* [Create an Account](../../../guides/cli/detailed-steps/part-2.-create-an-account.md)
* [Fund Your Account](../../../guides/cli/detailed-steps/part-3.-fund-your-account.md)

## **Kubernetes Cluster**

A full Kubernetes cluster is required with outbound internet access and be reachable from the internet.

If you need assistance in building a new cluster, visit the [Kubernetes Cluster for Akash Providers ](../kubernetes-cluster-for-akash-providers/)guide.

## RPC Node

Akash Providers need to run their own blockchain RPC node to remove dependence on public nodes.  This is a strict requirement.&#x20;

We have recently released documentation guiding thru the process of building a [RPC node via Helm Charts](../../../akash-nodes/akash-node-via-helm-charts/) with state sync.

## CPU Support

Only x86\_64 processors are officially supported by Akash for provider Kubernetes nodes at this time.  This may change in the future and when ARM processors are supported it will be announced and documented.

## Custom Kubernetes Cluster Settings

Akash Providers are deployed in many environments and we will make additions to these sections as when nuances are discovered.

* [VMware Tanzu](../../custom-kubernetes-cluster-settings/vmware-tanzu.md)

## Disable Search Domains

### Overview

In this section we perform the following DNS adjustments:

#### Set Use Domains to False

* Set `use-domains: false` to prevent the possibility of systemd's DHCP client overwriting the DNS search domain.  This prevents a potentially bad domain served by the DHCP server from becoming active.
* This is a common issue to some of the providers which is explained in more detail [here](https://github.com/akash-network/support/issues/80)

#### Set Accept RA to False

* Set `accept-ra: false` to disable IPv6 Router Advertisement (RA) as the DNS search domain may still leak through if not disabled.
* Potential issue this addresses is explained in more detail [here](https://bugs.launchpad.net/netplan/+bug/1858503)

### Create Netplan

> _**NOTE**_ - the DNS resolution issue & the Netplan fix addressed in this step are described [here](https://github.com/akash-network/support/issues/80)

Apply the following to all Kubernetes master and worker nodes.

```
cat > /etc/netplan/01-netcfg.yaml <<'EOF'
network:
  version: 2
  renderer: networkd
  ethernets:
    all:
      match:
        name: en*
      dhcp4: yes
      dhcp4-overrides:
        use-domains: false
      # disable accept-ra, otherwise it will bring search domains to your /etc/resolv.conf
      # refs https://bugs.launchpad.net/netplan/+bug/1858503
      accept-ra: false
      optional: true
EOF
```

### Test and Apply Netplan

Test the Netplan config and apply via these commands.

```
resolvectl domain
netplan try
netplan apply
resolvectl domain 
```

#### Expected/Example Output

```
root@ip-172-31-18-188:~# resolvectl domain
Global:
Link 2 (eth0): us-east-2.compute.internal
root@ip-172-31-18-188:~# netplan try
Do you want to keep these settings?


Press ENTER before the timeout to accept the new configuration


Changes will revert in 111 seconds
Configuration accepted.
root@ip-172-31-18-188:~# netplan apply
root@ip-172-31-18-188:~# resolvectl domain
Global:
Link 2 (eth0): us-east-2.compute.internal
```
