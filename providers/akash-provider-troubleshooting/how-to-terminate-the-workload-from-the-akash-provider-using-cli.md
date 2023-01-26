# How to terminate the workload from the Akash Provider using CLI

## How to terminate the workload from the Akash Provider using CLI

#### Impact of Steps Detailed in the K8s Cluster

* Steps outlined in this section will terminate the deployment in K8s cluster and remove the manifest.
* Providers can close the bid to get the provider escrow back.
* Closing the bid will terminate the associated application running on the provider.
* Closing the bid closes the lease (payment channel), meaning the tenant won't get any further charge for the deployment from the moment the bid is closed.
* Providers cannot close the deployment orders.  Only the tenants can close deployment orders and only then would the deployment escrow be returned to the tenant.

#### Impact of Steps Detailed on the Blockchain

The lease will get closed and the deployment will switch from the open to paused state with the open escrow account. Use akash query deployment get CLI command to verify this of desired. The owner will still have to close his deployment (akash tx deployment close) in order to get the AKT back from the deployment's escrow account (5 AKT by default). The provider has no rights to close the user deployment on its own.

Of course you don't have to kubectl exec inside the akash-provider Pod - as detailed in this guide - you can just do the same anywhere where you have:

* Providers key
* Akash CLI tool;
* Any mainnet akash RPC node to broadcast the bid close transaction
* It is also worth noting that in some cases running the transactions from the account that is already in use (such as running akash-provider service) can cause the account sequence mismatch errors (typically when two clients are trying to issue the transaction within the same block window which is \~6.1s)

#### STEP 1 - Find the deployment you want to close

```
root@node1:~# kubectl -n lease get manifest --show-labels --sort-by='.metadata.creationTimestamp'
...
5reb3l87s85t50v77sosktvdeeg6pfbnlboigoprqv3d4   26s     akash.network/lease.id.dseq=8438017,akash.network/lease.id.gseq=1,akash.network/lease.id.oseq=1,akash.network/lease.id.owner=akash1h24fljt7p0nh82cq0za0uhsct3sfwsfu9w3c9h,akash.network/lease.id.provider=akash1nxq8gmsw2vlz3m68qvyvcf3kh6q269ajvqw6y0,akash.network/namespace=5reb3l87s85t50v77sosktvdeeg6pfbnlboigoprqv3d4,akash.network=true
```

#### STEP 2 - Close the bid

```
root@node1:~# kubectl -n akash-services exec -i $(kubectl -n akash-services get pods -l app=akash-provider --output jsonpath='{.items[0].metadata.name}') -- bash -c "akash tx market bid close --owner akash1h24fljt7p0nh82cq0za0uhsct3sfwsfu9w3c9h --dseq 8438017 --oseq 1 --gseq 1 -y"
```

#### STEP 3 - Verification

* To make sure your provider is working well, you can watch the logs while trying to deploy something there, to make sure it bids (i.e. broadcasts the tx on the network)

```
kubectl -n akash-services logs -l app=akash-provider --tail=100 -f | grep -Ev "running check|check result|cluster resources|service available replicas below target"
```

_**Example/Expected Messages**_

```
I[2022-11-11|12:09:10.778] Reservation fulfilled                        module=bidengine-order order=akash1h24fljt7p0nh82cq0za0uhsct3sfwsfu9w3c9h/8438017/1/1
D[2022-11-11|12:09:11.436] submitting fulfillment                       module=bidengine-order order=akash1h24fljt7p0nh82cq0za0uhsct3sfwsfu9w3c9h/8438017/1/1 price=21.000000000000000000uakt
I[2022-11-11|12:09:11.451] broadcast response                           cmp=client/broadcaster response="code: 0\ncodespace: \"\"\ndata: \"\"\nevents: []\ngas_used: \"0\"\ngas_wanted: \"0\"\nheight: \"0\"\ninfo: \"\"\nlogs: []\nraw_log: '[]'\ntimestamp: \"\"\ntx: null\ntxhash: AF7E9AB65B0200B0B8B4D9934C019F8E07FAFB5C396E82DA582F719A1FA15C14\n" err=null
I[2022-11-11|12:09:11.451] bid complete                                 module=bidengine-order order=akash1h24fljt7p0nh82cq0za0uhsct3sfwsfu9w3c9h/8438017/1/1
```

* To ensure, you can always bounce the provider service which will have no impact on active workloads

```
kubectl -n akash-services delete pods -l app=akash-provider
```
