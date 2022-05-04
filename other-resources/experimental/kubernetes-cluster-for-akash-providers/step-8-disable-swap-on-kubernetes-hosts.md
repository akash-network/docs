# STEP 8 - Disable Swap on Kubernetes Hosts

The Kubelet process on Kubernetes worker nodes does not support swap.  Issue the following command on each worker node to disable swap.

```
swapoff -a
```



We should in addition ensure that swap is permanently disabled on the Linux hosts via:

* Open the /etc/fstab file
* Search for a swap line and add a # (hashtag) sign in front of the line to comment out the entire line

```
vi /etc/fstab
```
