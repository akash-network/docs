# Install NVIDIA drivers

## Install latest NVIDIA drivers and the nvidia-cuda-toolkit

This steps should be completed on all Kubernetes worker nodes of the Akash Provider cluster.

```
apt update

DEBIAN_FRONTEND=noninteractive apt -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" dist-upgrade

apt autoremove

apt -y install nvidia-cuda-toolkit
```
