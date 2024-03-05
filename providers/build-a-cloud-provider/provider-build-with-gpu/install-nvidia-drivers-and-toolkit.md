# Install NVIDIA Drivers & Toolkit

> _**NOTE**_ - The steps in this section should be completed on all Kubernetes nodes hosting GPU resources

## Prepare Environment

> _**NOTE**_ - reboot the servers following the completion of this step

```
apt update

DEBIAN_FRONTEND=noninteractive apt -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" dist-upgrade

apt autoremove
```

## Install Latest NVIDIA Drivers

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

## Install the NVIDIA CUDA Toolkit

```
distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
curl -s -L https://nvidia.github.io/libnvidia-container/gpgkey | apt-key add -
curl -s -L https://nvidia.github.io/libnvidia-container/$distribution/libnvidia-container.list | tee /etc/apt/sources.list.d/libnvidia-container.list

apt-get update
apt-get install -y nvidia-cuda-toolkit nvidia-container-toolkit nvidia-container-runtime
```

## For non-PCIe, e.g. SXM* GPUs

In some circumstances it has been found that the CUDA Drivers Fabric Manager needs to be installed on worker nodes hosting GPU resources (typically, non-PCIe GPU configurations such as those using SXM form factors).

> Replace `525` with your nvidia driver version installed in the previous steps

```
apt-get install cuda-drivers-fabricmanager-525
```

[Reference](https://docs.akash.network/providers/akash-provider-troubleshooting/gpu-provider-troubleshooting)

## Additional References for Node Configurations

> _**NOTE -**_ references are for additional info only.  No actions are necessary and the Kubernetes nodes should be all set to proceed to next step based on configurations enacted in prior steps on this doc.

* [https://github.com/NVIDIA/k8s-device-plugin#prerequisites](https://github.com/NVIDIA/k8s-device-plugin#prerequisites)
* [https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html)
