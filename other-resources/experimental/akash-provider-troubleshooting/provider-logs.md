# Provider Logs

The commands in this section peer into the provider’s logs and may be used to verify possible error conditions on provider start up and to ensure provider order receipt/bid process completion steps.

### Command Template

Issue the commands in this section from a control plane node within the Kubernetes cluster or a machine that has kubectl communication with the cluster.

```
kubectl logs <pod-name> -n akash-services
```

### Example Command Use

#### STEP 1 - isolate the name of the provider pod **(example)**

```
kubectl get pods -n akash-services

NAME                                 READY   STATUS    RESTARTS   AGE
akash-provider-8cbbc5955-22kfk       1/1     Running   0          3h40m
```

#### STEP 2 - use the provider pod name to view logs

```
kubectl logs akash-provider-8cbbc5955-22kfk -n akash-services
```

### Example Output

* Note within the example the receipt of a deployment order with a DSEQ of 5905802
* The sequence shown from `order-detected` thru reservations thru `bid-complete` provides an example of what we would expect to see when an order is received by the provider
* The order receipt is one of many events sequences that can be verified within provider logs

```
I[2022-05-16|14:40:47.243] syncing sequence                             cmp=client/broadcaster local=196 remote=196
I[2022-05-16|14:40:57.243] syncing sequence                             cmp=client/broadcaster local=196 remote=196
D[2022-05-16|14:40:58.565] cluster resources                            module=provider-cluster cmp=service cmp=inventory-service dump="{\"nodes\":[{\"name\":\"node1\",\"allocatable\":{\"cpu\":1800,\"memory\":3471437824,\"storage_ephemeral\":46663523866},\"available\":{\"cpu\":780,\"memory\":3155779584,\"storage_ephemeral\":46663523866}},{\"name\":\"node2\",\"allocatable\":{\"cpu\":1900,\"memory\":3739877376,\"storage_ephemeral\":46663523866},\"available\":{\"cpu\":1295,\"memory\":3204487168,\"storage_ephemeral\":46663523866}}],\"total_allocatable\":{\"cpu\":3700,\"memory\":7211315200,\"storage_ephemeral\":93327047732},\"total_available\":{\"cpu\":2075,\"memory\":6360266752,\"storage_ephemeral\":93327047732}}\n"
I[2022-05-16|14:41:07.245] syncing sequence                             cmp=client/broadcaster local=196 remote=196
I[2022-05-16|14:41:14.384] order detected                               module=bidengine-service order=order/akash1n44zc8l6gfm0hpydldndpg8n05xjjwmuahc6nn/5905802/1/1
I[2022-05-16|14:41:14.489] group fetched                                module=bidengine-order order=akash1n44zc8l6gfm0hpydldndpg8n05xjjwmuahc6nn/5905802/1/1
I[2022-05-16|14:41:14.489] requesting reservation                       module=bidengine-order order=akash1n44zc8l6gfm0hpydldndpg8n05xjjwmuahc6nn/5905802/1/1
D[2022-05-16|14:41:14.489] reservation requested                        module=provider-cluster cmp=service cmp=inventory-service order=akash1n44zc8l6gfm0hpydldndpg8n05xjjwmuahc6nn/5905802/1/1 resources="group_id:<owner:\"akash1n44zc8l6gfm0hpydldndpg8n05xjjwmuahc6nn\" dseq:5905802 gseq:1 > state:open group_spec:<name:\"akash\" requirements:<signed_by:<> attributes:<key:\"host\" value:\"akash\" > > resources:<resources:<cpu:<units:<val:\"100\" > > memory:<quantity:<val:\"268435456\" > > storage:<name:\"default\" quantity:<val:\"268435456\" > > endpoints:<> > count:1 price:<denom:\"uakt\" amount:\"10000000000000000000000\" > > > created_at:5905807 "
D[2022-05-16|14:41:14.489] reservation count                            module=provider-cluster cmp=service cmp=inventory-service cnt=0
I[2022-05-16|14:41:14.489] Reservation fulfilled                        module=bidengine-order order=akash1n44zc8l6gfm0hpydldndpg8n05xjjwmuahc6nn/5905802/1/1
D[2022-05-16|14:41:14.490] submitting fulfillment                       module=bidengine-order order=akash1n44zc8l6gfm0hpydldndpg8n05xjjwmuahc6nn/5905802/1/1 price=0.850560000000000000uakt
I[2022-05-16|14:41:14.721] broadcast response                           cmp=client/broadcaster response="code: 0\ncodespace: \"\"\ndata: \"\"\nevents: []\ngas_used: \"0\"\ngas_wanted: \"0\"\nheight: \"0\"\ninfo: \"\"\nlogs: []\nraw_log: '[]'\ntimestamp: \"\"\ntx: null\ntxhash: BBB18951805908A389B7C913E8F2514F0B8F3B2530B24DF0A50EF4815BDBF0A3\n" err=null
I[2022-05-16|14:41:14.721] bid complete                                 module=bidengine-order order=akash1n44zc8l6gfm0hpydldndpg8n05xjjwmuahc6nn/5905802/1/1
```
