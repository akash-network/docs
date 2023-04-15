# Install NVIDIA Drivers & Toolkit

> _**NOTE**_ - The steps in this guide should be completed on all Kubernetes worker nodes of the Akash Provider cluster.

## Prepare Environment

> _**NOTE**_ - reboot the servers following the completion of these steps

```
apt update

DEBIAN_FRONTEND=noninteractive apt -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" dist-upgrade

apt autoremove
```

## Install Latest NVIDIA Drivers&#x20;

```
apt install ubuntu-drivers-common

ubuntu-drivers devices

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
