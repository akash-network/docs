# Disable Search Domains

## Overview

In this section we perform the following DNS adjustments:

#### Set Use Domains to False

* Set `use-domains: false` to prevent the possibility of systemd's DHCP client overwriting the DNS search domain.  This prevents a potentially bad domain served by the DHCP server from becoming active.
* This is a common issue to some of the providers which is explained in more detail [here](https://github.com/akash-network/support/issues/80)

#### Set Accept RA to False

* Set `accept-ra: false` to disable IPv6 Router Advertisement (RA) as the DNS search domain may still leak through if not disabled.
* Potential issue this addresses is explained in more detail [here](https://bugs.launchpad.net/netplan/+bug/1858503)

## Create Netplan

> _**NOTE**_ - the DNS resolution issue & the Netplan fix addressed in this step are described [here](https://github.com/akash-network/support/issues/80)

Apply the following to all Kubernetes control plane and worker nodes.

> _**IMPORTANT**_ - Make sure you do not have any other config files under the `/etc/netplan` directory, otherwise it could cause unexpected networking issues / issues with booting up your node.

> If you aren't using the DHCP or want to add additional configuration, please refer to the netplan documentation [here](https://netplan.readthedocs.io/en/stable/netplan-yaml/) for additional config options.

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

## Test and Apply Netplan

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
