# Step 11 - Disable Unattended Upgrades

## Overview

Unattended upgrades can bring all sorts of uncertainty/troubles such as updates of NVIDIA drivers and have the potential to affects your Provider/K8s cluster. Impact of unattended upgrades can include:

* `nvidia-smi` will hang on the host/pod
* `nvdp plugin` will become stuck and hence K8s cluster will run in a non-desired state where closed deployments will be stuck in `Terminating` status

## Disable Unattended Upgrades

To disable unattended upgrades, execute these two commands on your Kubernetes worker & control plane nodes:\


```
echo -en 'APT::Periodic::Update-Package-Lists "0";\nAPT::Periodic::Unattended-Upgrade "0";\n' | tee /etc/apt/apt.conf.d/20auto-upgrades

apt remove unattended-upgrades

systemctl stop unattended-upgrades.service
systemctl mask unattended-upgrades.service
```

## Verify

These commands should output `0` following the disable of unattended upgrades.  Conduct these verifications  your Kubernetes worker & control plane nodes:

```
apt-config dump APT::Periodic::Unattended-Upgrade

apt-config dump APT::Periodic::Update-Package-Lists
```

#### Example/Expected Output

```
# apt-config dump APT::Periodic::Unattended-Upgrade
APT::Periodic::Unattended-Upgrade "0";

# apt-config dump APT::Periodic::Update-Package-Lists
APT::Periodic::Update-Package-Lists "0";
```

