# Provider Logs

The commands in this section peer into the provider’s logs and may be used to verify possible error conditions on provider start up and to ensure provider order receipt/bid process completion steps.

### Command Template

Issue the commands in this section from a control plane node within the Kubernetes cluster or a machine that has kubectl communication with the cluster.

```
kubectl logs <pod-name> -n akash-services
```

### Example Command Use

* Using the example command syntax we will list the last ten entries in Provider logs and enter a live streaming session of new logs generated

```
kubectl -n akash-services logs $(kubectl -n akash-services get pods -l app=akash-provider --output jsonpath='{.items[-1].metadata.name}') --tail=10 -f
```

### Example Output

* Note within the example the receipt of a deployment order with a DSEQ of 5949829
* The sequence shown from `order-detected` thru reservations thru `bid-complete` provides an example of what we would expect to see when an order is received by the provider
* The order receipt is one of many events sequences that can be verified within provider logs

```
kubectl -n akash-services logs $(kubectl -n akash-services get pods -l app=akash-provider --output jsonpath='{.items[-1].metadata.name}') --tail=10 -f

I[2022-05-19|17:20:42.069] syncing sequence                             cmp=client/broadcaster local=22 remote=22
I[2022-05-19|17:20:52.069] syncing sequence                             cmp=client/broadcaster local=22 remote=22
I[2022-05-19|17:21:02.068] syncing sequence                             cmp=client/broadcaster local=22 remote=22
D[2022-05-19|17:21:10.983] cluster resources                            module=provider-cluster cmp=service cmp=inventory-service dump="{\"nodes\":[{\"name\":\"node1\",\"allocatable\":{\"cpu\":1800,\"memory\":3471499264,\"storage_ephemeral\":46663523866},\"available\":{\"cpu\":780,\"memory\":3155841024,\"storage_ephemeral\":46663523866}},{\"name\":\"node2\",\"allocatable\":{\"cpu\":1900,\"memory\":3739934720,\"storage_ephemeral\":46663523866},\"available\":{\"cpu\":1295,\"memory\":3204544512,\"storage_ephemeral\":46663523866}}],\"total_allocatable\":{\"cpu\":3700,\"memory\":7211433984,\"storage_ephemeral\":93327047732},\"total_available\":{\"cpu\":2075,\"memory\":6360385536,\"storage_ephemeral\":93327047732}}\n"
I[2022-05-19|17:21:12.068] syncing sequence                             cmp=client/broadcaster local=22 remote=22
I[2022-05-19|17:21:22.068] syncing sequence                             cmp=client/broadcaster local=22 remote=22
I[2022-05-19|17:21:29.391] order detected                               module=bidengine-service order=order/akash1ggk74pf9avxh3llu30yfhmr345h2yrpf7c2cdu/5949829/1/1
I[2022-05-19|17:21:29.495] group fetched                                module=bidengine-order order=akash1ggk74pf9avxh3llu30yfhmr345h2yrpf7c2cdu/5949829/1/1
I[2022-05-19|17:21:29.495] requesting reservation                       module=bidengine-order order=akash1ggk74pf9avxh3llu30yfhmr345h2yrpf7c2cdu/5949829/1/1
D[2022-05-19|17:21:29.495] reservation requested                        module=provider-cluster cmp=service cmp=inventory-service order=akash1ggk74pf9avxh3llu30yfhmr345h2yrpf7c2cdu/5949829/1/1 resources="group_id:<owner:\"akash1ggk74pf9avxh3llu30yfhmr345h2yrpf7c2cdu\" dseq:5949829 gseq:1 > state:open group_spec:<name:\"akash\" requirements:<signed_by:<> attributes:<key:\"host\" value:\"akash\" > > resources:<resources:<cpu:<units:<val:\"100\" > > memory:<quantity:<val:\"2686451712\" > > storage:<name:\"default\" quantity:<val:\"268435456\" > > endpoints:<> > count:1 price:<denom:\"uakt\" amount:\"10000000000000000000000\" > > > created_at:5949831 "
D[2022-05-19|17:21:29.495] reservation count                            module=provider-cluster cmp=service cmp=inventory-service cnt=1
I[2022-05-19|17:21:29.495] Reservation fulfilled                        module=bidengine-order order=akash1ggk74pf9avxh3llu30yfhmr345h2yrpf7c2cdu/5949829/1/1
D[2022-05-19|17:21:29.496] submitting fulfillment                       module=bidengine-order order=akash1ggk74pf9avxh3llu30yfhmr345h2yrpf7c2cdu/5949829/1/1 price=4.540160000000000000uakt
I[2022-05-19|17:21:29.725] broadcast response                           cmp=client/broadcaster response="code: 0\ncodespace: \"\"\ndata: \"\"\nevents: []\ngas_used: \"0\"\ngas_wanted: \"0\"\nheight: \"0\"\ninfo: \"\"\nlogs: []\nraw_log: '[]'\ntimestamp: \"\"\ntx: null\ntxhash: AFCA8D4A900A62D961F4AB82B607749FFCA8C10E2B0486B89A8416B74593DBFA\n" err=null
I[2022-05-19|17:21:29.725] bid complete                                 module=bidengine-order order=akash1ggk74pf9avxh3llu30yfhmr345h2yrpf7c2cdu/5949829/1/1
I[2022-05-19|17:21:32.069] syncing sequence                             cmp=client/broadcaster local=23 remote=22
```
