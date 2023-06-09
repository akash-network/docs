# Install NVIDIA Drivers & Toolkit

> _**NOTE**_ - The steps in this guide should be completed on all Kubernetes worker nodes of the Akash Provider cluster.

## Prepare Environment

> _**NOTE**_ - reboot the servers following the completion of these steps

```
apt update

DEBIAN_FRONTEND=noninteractive apt -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" dist-upgrade

apt autoremove
```

## Install Latest NVIDIA Drivers

The `ubuntu-drivers devices` command detects your GPU and determines which version of the NVIDIA drivers is best.

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

Either run `ubuntu-drivers autoinstall` or `apt install nvidia-driver-525` (based on the example provided and the `recommended` version indicated which may be different in your use).

```
ubuntu-drivers autoinstall
```

## Install nvidia-cuda-toolkit

```
distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
curl -s -L https://nvidia.github.io/libnvidia-container/gpgkey | apt-key add -
curl -s -L https://nvidia.github.io/libnvidia-container/$distribution/libnvidia-container.list | tee /etc/apt/sources.list.d/libnvidia-container.list

apt-get update
apt-get install -y nvidia-cuda-toolkit nvidia-container-toolkit nvidia-container-runtime
```

## Additional References for Node Configurations

> _**NOTE -**_ references are for additional info only.  No actions are necessary and the Kubernetes nodes should be all set to proceed to next step based on configurations enacted in prior steps on this doc.

* [https://github.com/NVIDIA/k8s-device-plugin#prerequisites](https://github.com/NVIDIA/k8s-device-plugin#prerequisites)
* [https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html)
