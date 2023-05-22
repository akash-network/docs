# STEP 5 - Additional Verifications/Config

In this section we will enable gVisor which provides basic container security.

## Containerd Edit/Verification

* Change into the directory of the config file

```
cd ~/kubespray/inventory/akash/group_vars/k8s_cluster
```

* Using VI or nano edit the k8s-cluster.yml file:

```
vi k8s-cluster.yml
```

* Add/update the container\_manager key if necessary to containerd

```
container_manager: containerd
```

## **gVisor Issue - No system-cgroup v2 Support**

If you are using a newer systemd version,  your container will get stuck in ContainerCreating state on your provider with gVisor enabled. Please reference [this document](../gvisor-issue-no-system-cgroup-v2-support.md) for details regarding this issue and the recommended workaround.
