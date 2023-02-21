# Maintaining and Rotating Kubernetes/etcd Certificates: A How-To Guide

> The following doc is based on [https://kubernetes.io/docs/tasks/administer-cluster/kubeadm/kubeadm-certs/](https://kubernetes.io/docs/tasks/administer-cluster/kubeadm/kubeadm-certs/) & [https://txconsole.com/certificate-renewal-manually-in-kubernetes/](https://txconsole.com/certificate-renewal-manually-in-kubernetes/)

## Overview

When K8s certs expire, you won't be able to use your cluster. Make sure to rotate your certs proactively.

The following procedure explains how to rotate them manually.

Evidence that the certs have expired:

```
root@node1:~# kubectl get nodes -o wide
error: You must be logged in to the server (Unauthorized)
```

You can always view the certs expiration using the  `kubeadm certs check-expiration` command:

```
root@node1:~# kubeadm certs check-expiration
[check-expiration] Reading configuration from the cluster...
[check-expiration] FYI: You can look at this config file with 'kubectl -n kube-system get cm kubeadm-config -o yaml'
[check-expiration] Error reading configuration from the Cluster. Falling back to default configuration

CERTIFICATE                         EXPIRES                  RESIDUAL TIME   CERTIFICATE AUTHORITY   EXTERNALLY MANAGED
admin.conf                          Feb 20, 2023 17:12 UTC   <invalid>       ca                      no
apiserver                           Mar 03, 2023 16:42 UTC   10d             ca                      no
!MISSING! apiserver-etcd-client
apiserver-kubelet-client            Feb 20, 2023 17:12 UTC   <invalid>       ca                      no
controller-manager.conf             Feb 20, 2023 17:12 UTC   <invalid>       ca                      no
!MISSING! etcd-healthcheck-client
!MISSING! etcd-peer
!MISSING! etcd-server
front-proxy-client                  Feb 20, 2023 17:12 UTC   <invalid>       front-proxy-ca          no
scheduler.conf                      Feb 20, 2023 17:12 UTC   <invalid>       ca                      no

CERTIFICATE AUTHORITY   EXPIRES                  RESIDUAL TIME   EXTERNALLY MANAGED
ca                      Feb 18, 2032 17:12 UTC   8y              no
!MISSING! etcd-ca
front-proxy-ca          Feb 18, 2032 17:12 UTC   8y              no
root@node1:~#
```

## Rotate K8s Certs

### Backup etcd DB

It is crucial to back up your etcd DB as it contains your K8s cluster state! So make sure to backup your etcd DB first before rotating the certs!

#### Take the etcd DB Backup

> Replace the etcd key & cert with your locations found in the prior steps

```
export $(grep -v '^#' /etc/etcd.env | xargs -d '\n')
etcdctl -w table member list
etcdctl endpoint health --cluster -w table
etcdctl endpoint status --cluster -w table
etcdctl snapshot save node1.etcd.backup
```

You can additionally backup the current certs:

```
tar czf etc_kubernetes_ssl_etcd_bkp.tar.gz /etc/kubernetes /etc/ssl/etcd
```

### Renew the Certs

> IMPORTANT: For an HA Kubernetes cluster with multiple control plane nodes, the `kubeadm certs renew` command (followed by the `kube-apiserver`, `kube-scheduler`, `kube-controller-manage`r pods and `etcd.service` restart) needs to be executed on all the control-plane nodes, on one control plane node at a time, starting with the primary control plane node. This approach ensures that the cluster remains operational throughout the certificate renewal process and that there is always at least one control plane node available to handle API requests. To find out whether you have an HA K8s cluster (multiple control plane nodes) use this command `kubectl get nodes -l node-role.kubernetes.io/control-plane`

Now that you have the etcd DB backup, you can rotate the K8s certs using the following commands:

#### Rotate the k8s Certs

```
kubeadm certs renew all
```

#### Update your kubeconfig

```
mv -vi /root/.kube/config /root/.kube/config.old
cp -pi /etc/kubernetes/admin.conf /root/.kube/config
```

#### Bounce the following services in this order

```
kubectl -n kube-system delete pods -l component=kube-apiserver
kubectl -n kube-system delete pods -l component=kube-scheduler
kubectl -n kube-system delete pods -l component=kube-controller-manager
systemctl restart etcd.service
```

#### Verify the Certs Status

```
kubeadm certs check-expiration
```

Repeat the process for all control plane nodes, one at a time, if you have a HA Kubernetes cluster.
