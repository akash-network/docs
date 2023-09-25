# IP Leases - Provider Enablement (Optional Step)

In this guide we detail the enablement of IP Leases on a pre-existing Akash provider.

Please be aware of the following prerequisites prior to getting started.&#x20;

> _**NOTE**_ - IP Leases enablement is an optional step for Akash providers.  Some providers may not have available public IP address pools and/or other requirements for enabling this feature.

## Prerequisites&#x20;

* Provider IP Leases enablement is only supported for Akash providers built using [Helm Charts](../../../../providers/build-a-cloud-provider/akash-cloud-provider-build-with-helm-charts/)
* Available pool of unallocated public IP addresses

## Sections in this Guide

* [Create the MetalLB Namespace](../../../../providers/build-a-cloud-provider/ip-leases-provider-enablement-optional-step/create-the-metallb-namespace.md)
* [MetalLB Install](../../../../providers/build-a-cloud-provider/ip-leases-provider-enablement-optional-step/metallb-install.md)
* [Enable strictARP in kube-proxy](../../../../providers/build-a-cloud-provider/ip-leases-provider-enablement-optional-step/enable-strictarp-in-kube-proxy.md)
* [Akash Provider Update](../../../../providers/build-a-cloud-provider/ip-leases-provider-enablement-optional-step/akash-provider-update.md)
* [IP Operator](../../../../providers/build-a-cloud-provider/ip-leases-provider-enablement-optional-step/ip-operator.md)
* [Additional notes on the IP Operator](../../../../providers/build-a-cloud-provider/ip-leases-provider-enablement-optional-step/additional-notes-on-the-ip-operator.md)
* [Troubleshooting IP Leases Issues](../../../../providers/build-a-cloud-provider/ip-leases-provider-enablement-optional-step/troubleshooting-ip-leases-issues.md)

