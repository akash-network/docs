# GPU Provider Configuration

## Overview

Sections in this guide cover the installation of the following packages necessary for Akash Provider GPU hosting:

* [Install NVIDIA Drivers & Toolkit](gpu-provider-configuration.md#install-nvidia-drivers-and-toolkit)
* [NVIDIA Runtime Configuration](gpu-provider-configuration.md#nvidia-runtime-configuration)

## Install NVIDIA Drivers & Toolkit

> _**NOTE**_ - The steps in this section should be completed on all Kubernetes nodes hosting GPU resources

### Prepare Environment

> _**NOTE**_ - reboot the servers following the completion of this step

```
apt update

DEBIAN_FRONTEND=noninteractive apt -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" dist-upgrade

apt autoremove
```

### Install Latest NVIDIA Drivers

The `ubuntu-drivers devices` command detects your GPU and determines which version of the NVIDIA drivers is best.

> _**NOTE**_ - the NVIDIA drivers detailed and installed in this section have known compatibility issues with some `6.X` lLinux kernels as discussed [here](https://forums.developer.nvidia.com/t/390-154-driver-no-longer-works-with-kernel-6-0/230959/7).  In our experience, when such compatibility issue occur the driver will install with no errors generated but will not functionality properly.  If you encounter Linux kernel and NVIDIA driver compatibility issues, consider downgrading the Kernel to the officially supported Ubuntu 22.04 kernel which at the time of this writing is `5.15.0-73`

```
apt install ubuntu-drivers-common

ubuntu-drivers devices
```

#### Expected/Example Output

```
root@node1:~# ubuntu-drivers devices

== /sys/devices/pci0000:00/0000:00:1e.0 ==
modalias : pci:v000010DEd00001EB8sv000010DEsd000012A2bc03sc02i00
vendor   : NVIDIA Corporation
model    : TU104GL [Tesla T4]
driver   : nvidia-driver-450-server - distro non-free
driver   : nvidia-driver-418-server - distro non-free
driver   : nvidia-driver-470-server - distro non-free
driver   : nvidia-driver-515 - distro non-free
driver   : nvidia-driver-510 - distro non-free
driver   : nvidia-driver-525-server - distro non-free
driver   : nvidia-driver-525 - distro non-free recommended
driver   : nvidia-driver-515-server - distro non-free
driver   : nvidia-driver-470 - distro non-free
driver   : xserver-xorg-video-nouveau - distro free builtin
```

#### Driver Install Based on Output

Run either `ubuntu-drivers autoinstall` or `apt install nvidia-driver-525` (driver names may be different in your environment).

The `autoinnstall` option installs the recommended version and is appropriate in most instances.

The `apt install <driver-name>`alternatively allows the install of preferred driver instead of the recommended version.

```
ubuntu-drivers autoinstall
```

### Install the NVIDIA CUDA Toolkit

> _**NOTE**_ - The steps in this sub-section should be completed on all Kubernetes nodes hosting GPU resources


```
distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
curl -s -L https://nvidia.github.io/libnvidia-container/gpgkey | apt-key add -
curl -s -L https://nvidia.github.io/libnvidia-container/$distribution/libnvidia-container.list | tee /etc/apt/sources.list.d/libnvidia-container.list

apt-get update
apt-get install -y nvidia-cuda-toolkit nvidia-container-toolkit nvidia-container-runtime
```

### Additional References for Node Configurations

> _**NOTE -**_ references are for additional info only.  No actions are necessary and the Kubernetes nodes should be all set to proceed to next step based on configurations enacted in prior steps on this doc.

* [https://github.com/NVIDIA/k8s-device-plugin#prerequisites](https://github.com/NVIDIA/k8s-device-plugin#prerequisites)
* [https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html)

## NVIDIA Runtime Configuration

### Worker nodes

> _**NOTE**_ - The steps in this sub-section should be completed on all Kubernetes nodes hosting GPU resources

Update the nvidia-container-runtime config in order to prevent `NVIDIA_VISIBLE_DEVICES=all` abuse where tenants could access more GPU's than they requested.

> _**NOTE**_ - This will only work with `nvdp/nvidia-device-plugin` helm chart installed with `--set deviceListStrategy=volume-mounts` (you'll get there in the next steps)

Make sure the config file `/etc/nvidia-container-runtime/config.toml` contains these line uncommmented and set to these values:

```
accept-nvidia-visible-devices-as-volume-mounts = true
accept-nvidia-visible-devices-envvar-when-unprivileged = false
```

> _**NOTE**_ - `/etc/nvidia-container-runtime/config.toml` is part of `nvidia-container-toolkit-base` package; so it won't override the customer-set parameters there since it is part of the `/var/lib/dpkg/info/nvidia-container-toolkit-base.conffiles`

### Kubespray

> _**NOTE**_ - the steps in this sub-section should be completed on the Kubespray host only

> _**NOTE**_ - skip this sub-section if these steps were completed during your Kubernetes build process

In this step we add the NVIDIA runtime confguration into the Kubespray inventory.  The runtime will be applied to necessary Kubernetes hosts when Kubespray builds the cluster in the subsequent step.

### Create NVIDIA Runtime File for Kubespray Use

```
cat > ~/kubespray/inventory/akash/group_vars/all/akash.yml <<'EOF'
containerd_additional_runtimes:
  - name: nvidia
    type: "io.containerd.runc.v2"
    engine: ""
    root: ""
    options:
      BinaryName: '"/usr/bin/nvidia-container-runtime"'
EOF
```

### Kubespray the Kubernetes Cluster

```
cd ~/kubespray

###Execute following command if not already in the Python virtual environment
###Creation and activation of virtual evironment described further here:
###https://docs.akash.network/providers/build-a-cloud-provider/kubernetes-cluster-for-akash-providers/step-2-install-ansible
source venv/bin/activate

ansible-playbook -i inventory/akash/hosts.yaml -b -v --private-key=~/.ssh/id_rsa cluster.yml
```
