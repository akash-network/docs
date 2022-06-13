# Script Execution Templates

## Single Kubernetes Node with No Persistent Storage

* In this example the following resource specs are provided (note in this input example CPU/Memory/Storage are calculated for ease of input - I.e. count of 32 vCPU may be specified instead of 32000 without the calculation):
  * 1 Kubernetes Worker Node&#x20;
  * 32 vCPU&#x20;
  * 420 GB RAM&#x20;
  * 1 TB Ephemeral Storage

```
./charts/akash-provider/scripts/price_script_generic.sh <<<  '[{"memory":'"$((420*(1024**3)))"',"cpu":'"$((32*1000))"',"storage":[{"class":"ephemeral","size":'"$((1*(1024**4)))"'}],"count":1,"endpoint_quantity":1}]'
```

## Two Kubernetes Nodes with Persistent Storage

* In this example the following resource specs are provided (note in this input example CPU/Memory/Storage are entered in their raw format - I.e. 1 vCPU is entered as 1000):
  * 2 Kubernetes Worker Nodes
  * 1 vCPU (per node)
  * 524 GB RAM
  * 2 TB Ephemeral Storage (per node)
  * 1 TB Persistent Storage of type Beta3/NVME (per node)

```
./charts/akash-provider/scripts/price_script_generic.sh <<< '[{"memory":536870912,"cpu":1000,"storage":[{"class":"beta3","size":1073741824},{"class":"ephemeral","size":2147483648}],"count":1,"endpoint_quantity":1},{"memory":536870912,"cpu":1000,"storage":[{"class":"beta3","size":1073741824},{"class":"ephemeral","size":2147483648}],"count":1,"endpoint_quantity":1}]'
```

