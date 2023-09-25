# Inventory Operator

* Install an Inventory Operator that is used for persistent storage
* The Operator reports the free space available to the Akash Provider

```
helm install inventory-operator akash/akash-inventory-operator -n akash-services
```

#### Expected Output

```
root@node1:~/helm-charts/charts# helm install inventory-operator akash/akash-inventory-operator -n akash-services

NAME: inventory-operator
LAST DEPLOYED: Thu May  5 18:15:57 2022
NAMESPACE: akash-services
STATUS: deployed
REVISION: 1
TEST SUITE: None
```
