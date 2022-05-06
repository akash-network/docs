# Edit Cluster.yaml Config

Use the Kubernetes host names captured in the prior steps ago to update the Rook operator’s targeted nodes.

Remember - we only want Rook to target non-master Kubenetes nodes with available, unformatted volumes.  In this simple example there exist a single master node (node1) and a single worker node (node2).  Based on this topology we only add node2 to the Ceph template.

#### Additional Notes

* Edit/replace the default "node-a" specification
* The node name should NOT be in quotes and as seen in the `Post cluster.yaml Update` section

```
cd ~/akash/_docs/rook/test

vi cluster.yaml
```

#### Prior to cluster.yaml Update

```
      nodes: # <<< PUT YOUR NODES HERE
      - name: "node-a"
```

#### **Post cluster.yaml Update**

```
    nodes: # <<< PUT YOUR NODES HERE
      - name: node2
```
