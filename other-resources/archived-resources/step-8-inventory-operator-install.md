# STEP 8 - Inventory Operator Install

_**NOTE**_ - the Inventory Operator is now required on ALL Akash Providers.  Previously this operator was only required when the Provider hosted persistent storage.  But the operator is now mandated on all providers.

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
