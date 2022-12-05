# Verifications

Several provider verifications and troubleshooting options are presented in this section which aid in persistent storage investigations including:

* [Ceph Status and Health](verifications.md#view-ceph-status-and-health)
* [Ceph Configuration and Detailed Health](verifications.md#view-ceph-configuration-and-detailed-health)
* [Ceph Related Pod Status](verifications.md#view-ceph-related-pods-status)
* [Kubernetes General Events](verifications.md#kubernetes-general-events)

## Ceph Status and Health

```
kubectl -n rook-ceph get cephclusters
```

#### **Example Output**

```
root@node1:~/helm-charts/charts# kubectl -n rook-ceph get cephclusters

NAME        DATADIRHOSTPATH   MONCOUNT   AGE   PHASE   MESSAGE                        HEALTH      EXTERNAL
rook-ceph   /var/lib/rook     1          69m   Ready   Cluster created successfully   HEALTH_OK
```

## Ceph Configuration and Detailed Health

```
kubectl -n rook-ceph describe cephclusters
```

#### **Example Output (Tail Only)**

* Ensure the name is correct in the Nodes section
* The `Health` key should have a value of `HEALTH_OK` as shown in example output below
* Review any output of interest in the Events section

```
 Storage:
    Config:
      Osds Per Device:  1
    Nodes:
      Name:  node2
      Resources:
    Use All Devices:                        true
  Wait Timeout For Healthy OSD In Minutes:  10
Status:
  Ceph:
    Capacity:
      Bytes Available:  107333730304
      Bytes Total:      107369988096
      Bytes Used:       36257792
      Last Updated:     2022-05-05T18:43:50Z
    Health:             HEALTH_OK
    Last Checked:       2022-05-05T18:43:50Z
    Versions:
      Mgr:
        ceph version 16.2.5 (0883bdea7337b95e4b611c768c0279868462204a) pacific (stable):  1
      Mon:
        ceph version 16.2.5 (0883bdea7337b95e4b611c768c0279868462204a) pacific (stable):  1
      Osd:
        ceph version 16.2.5 (0883bdea7337b95e4b611c768c0279868462204a) pacific (stable):  3
      Overall:
        ceph version 16.2.5 (0883bdea7337b95e4b611c768c0279868462204a) pacific (stable):  5
  Conditions:
    Last Heartbeat Time:   2022-05-05T18:43:51Z
    Last Transition Time:  2022-05-05T17:34:32Z
    Message:               Cluster created successfully
    Reason:                ClusterCreated
    Status:                True
    Type:                  Ready
  Message:                 Cluster created successfully
  Phase:                   Ready
  State:                   Created
  Storage:
    Device Classes:
      Name:  ssd
  Version:
    Image:    ceph/ceph:v16.2.5
    Version:  16.2.5-0
Events:       <none>
```

## **Ceph Related Pod Status**

```
kubectl -n rook-ceph get pods
```

#### Example Output

```
root@node1:~/akash# kubectl -n rook-ceph get pods

NAME                                              READY   STATUS      RESTARTS   AGE
csi-cephfsplugin-269qv                            3/3     Running     0          77m
csi-cephfsplugin-provisioner-5c8b6d6f4-9j4tm      6/6     Running     0          77m
csi-cephfsplugin-provisioner-5c8b6d6f4-gwhhh      6/6     Running     0          77m
csi-cephfsplugin-qjp86                            3/3     Running     0          77m
csi-rbdplugin-nzm45                               3/3     Running     0          77m
csi-rbdplugin-provisioner-8564cfd44-55gmq         6/6     Running     0          77m
csi-rbdplugin-provisioner-8564cfd44-gtmqb         6/6     Running     0          77m
csi-rbdplugin-t8klb                               3/3     Running     0          77m
rook-ceph-crashcollector-node2-74c68c58b7-kspv6   1/1     Running     0          77m
rook-ceph-mgr-a-6cd6ff8c9f-z6fvk                  1/1     Running     0          77m
rook-ceph-mon-a-79fdcc8b9c-nr5vf                  1/1     Running     0          77m
rook-ceph-operator-bf9c6fd7-px76k                 1/1     Running     0          79m
rook-ceph-osd-0-747fcf4864-mrq6f                  1/1     Running     0          77m
rook-ceph-osd-prepare-node2-x4qqv                 0/1     Completed   0          76m
rook-ceph-tools-6646766697-lgngb                  1/1     Running     0          79m
```

## Kubernetes General Events

* Enters a scrolling events output which would display persistent storage logs and issues if present

```
kubectl get events --sort-by='.metadata.creationTimestamp' -A -w
```

#### Example Output from a Healthy Cluster

```
root@node1:~/helm-charts/charts# kubectl get events --sort-by='.metadata.creationTimestamp' -A -w

warning: --watch or --watch-only requested, --sort-by will be ignored

NAMESPACE        LAST SEEN   TYPE     REASON              OBJECT                                     MESSAGE
akash-services   37m         Normal   ScalingReplicaSet   deployment/akash-provider                  Scaled up replica set akash-provider-6bf9986cdc to 1
akash-services   37m         Normal   Scheduled           pod/akash-provider-6bf9986cdc-btvlg        Successfully assigned akash-services/akash-provider-6bf9986cdc-btvlg to node2
akash-services   37m         Normal   SuccessfulCreate    replicaset/akash-provider-6bf9986cdc       Created pod: akash-provider-6bf9986cdc-btvlg
akash-services   37m         Normal   SuccessfulDelete    replicaset/akash-provider-76966c6795       Deleted pod: akash-provider-76966c6795-lvphs
akash-services   37m         Normal   Created             pod/akash-provider-6bf9986cdc-btvlg        Created container provider
akash-services   36m         Normal   Killing             pod/akash-provider-76966c6795-lvphs        Stopping container provider
akash-services   37m         Normal   Pulled              pod/akash-provider-6bf9986cdc-btvlg        Container image "ghcr.io/ovrclk/akash:0.1.0" already present on machine
akash-services   37m         Normal   ScalingReplicaSet   deployment/akash-provider                  Scaled down replica set akash-provider-76966c6795 to 0
akash-services   37m         Normal   Started             pod/akash-provider-6bf9986cdc-btvlg        Started container provider
akash-services   30m         Normal   SuccessfulCreate    replicaset/inventory-operator-645fddd5cc   Created pod: inventory-operator-645fddd5cc-86jr9
akash-services   30m         Normal   ScalingReplicaSet   deployment/inventory-operator              Scaled up replica set inventory-operator-645fddd5cc to 1
akash-services   30m         Normal   Scheduled           pod/inventory-operator-645fddd5cc-86jr9    Successfully assigned akash-services/inventory-operator-645fddd5cc-86jr9 to node2
akash-services   30m         Normal   Pulling             pod/inventory-operator-645fddd5cc-86jr9    Pulling image "ghcr.io/ovrclk/k8s-inventory-operator"
akash-services   30m         Normal   Created             pod/inventory-operator-645fddd5cc-86jr9    Created container inventory-operator
akash-services   30m         Normal   Started             pod/inventory-operator-645fddd5cc-86jr9    Started container inventory-operator
akash-services   30m         Normal   Pulled              pod/inventory-operator-645fddd5cc-86jr9    Successfully pulled image "ghcr.io/ovrclk/k8s-inventory-operator" in 5.154257083s
ingress-nginx    12m         Normal   RELOAD              pod/ingress-nginx-controller-59xcv         NGINX reload triggered due to a change in configuration
ingress-nginx    12m         Normal   RELOAD              pod/ingress-nginx-controller-tk8zj         NGINX reload triggered due to a change in configuration
```
