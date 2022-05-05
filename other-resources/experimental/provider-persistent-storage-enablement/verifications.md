# Verifications

## View Ceph Configuration

```
kubectl -n rook-ceph describe cephclusters
```

#### **Example Output (Tail Only)**

```
Status:
  Ceph:
    Capacity:
      Bytes Available:  107353726976
      Bytes Total:      107369988096
      Bytes Used:       16261120
      Last Updated:     2022-02-16T21:24:12Z
    Health:             HEALTH_OK
    Last Changed:       2022-02-16T20:07:44Z
    Last Checked:       2022-02-16T21:24:12Z
    Previous Health:    HEALTH_WARN
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
    Last Heartbeat Time:   2022-02-16T21:24:13Z
    Last Transition Time:  2022-02-16T20:05:32Z
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

## **View Ceph Related Pods**

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
rook-ceph-osd-1-69d59cf974-ftbtm                  1/1     Running     0          77m
rook-ceph-osd-2-bc9dc46c5-mspfs                   1/1     Running     0          77m
rook-ceph-osd-prepare-node2-x4qqv                 0/1     Completed   0          76m
rook-ceph-tools-6646766697-lgngb                  1/1     Running     0          79m
```
