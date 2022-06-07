# STEP 5 - Provider Logs

* In this step we will verify that deployment orders are reaching our provider successfully
* Within the provider logs we will further ensure that the provider bids on the order as expected
* We would recommend that a new deployment is launched for this review to ensure the log entries are available and easy to isolate.  Revisit [STEP 1 ](step-1-launch-a-test-deployment-on-provider.md)of this guide if you need a refresher on launching a deployment that we would expect to find on our provider.
* Create a new test deployment and proceed thru the steps of accepting the bid from our own provider prior to the verification steps performed below

## Verify Provider Order Received and Bid Submitted

* Initially we will verify that the test deployment launched is received by the provider and that in response the provider submits a bid to the tenant

### Command Template

Issue the commands in this section from a control plane node within the Kubernetes cluster or a machine that has kubectl communication with the cluster.

```
kubectl logs <pod-name> -n akash-services | grep <DEPLOYMENT-DSEQ>
```

### Example Command Use

* Using the example command syntax our provider pod will be automatically populated
* Replace the \<DEPLOYMENT-DSEQ> variable with your deployment ID

```
kubectl -n akash-services logs $(kubectl -n akash-services get pods -l app=akash-provider --output jsonpath='{.items[-1].metadata.name}') | grep 5964735
```

### Example/Expected Output

* Note within the example the receipt of a deployment order with a DSEQ of 5964735
* The sequence shown from `order-detected` thru reservations thru `bid-complete` provides an example of what we would expect to see when an order is received by the provider

```
I[2022-05-20|18:36:57.089] order detected                               module=bidengine-service order=order/akash1ggk74pf9avxh3llu30yfhmr345h2yrpf7c2cdu/5964735/1/1
I[2022-05-20|18:36:57.193] group fetched                                module=bidengine-order order=akash1ggk74pf9avxh3llu30yfhmr345h2yrpf7c2cdu/5964735/1/1
I[2022-05-20|18:36:57.193] requesting reservation                       module=bidengine-order order=akash1ggk74pf9avxh3llu30yfhmr345h2yrpf7c2cdu/5964735/1/1
D[2022-05-20|18:36:57.193] reservation requested                        module=provider-cluster cmp=service cmp=inventory-service order=akash1ggk74pf9avxh3llu30yfhmr345h2yrpf7c2cdu/5964735/1/1 resources="group_id:<owner:\"akash1ggk74pf9avxh3llu30yfhmr345h2yrpf7c2cdu\" dseq:5964735 gseq:1 > state:open group_spec:<name:\"akash\" requirements:<signed_by:<> attributes:<key:\"host\" value:\"akash\" > > resources:<resources:<cpu:<units:<val:\"100\" > > memory:<quantity:<val:\"268435456\" > > storage:<name:\"default\" quantity:<val:\"268435456\" > > endpoints:<> > count:1 price:<denom:\"uakt\" amount:\"10000000000000000000000\" > > > created_at:5964737 "
D[2022-05-20|18:36:57.193] reservation count                            module=provider-cluster cmp=service cmp=inventory-service cnt=-1
I[2022-05-20|18:36:57.193] Reservation fulfilled                        module=bidengine-order order=akash1ggk74pf9avxh3llu30yfhmr345h2yrpf7c2cdu/5964735/1/1
D[2022-05-20|18:36:57.193] submitting fulfillment                       module=bidengine-order order=akash1ggk74pf9avxh3llu30yfhmr345h2yrpf7c2cdu/5964735/1/1 price=0.850560000000000000uakt
I[2022-05-20|18:36:57.432] broadcast response                           cmp=client/broadcaster response="code: 0\ncodespace: \"\"\ndata: \"\"\nevents: []\ngas_used: \"0\"\ngas_wanted: \"0\"\nheight: \"0\"\ninfo: \"\"\nlogs: []\nraw_log: '[]'\ntimestamp: \"\"\ntx: null\ntxhash: BDBE9B03F7FDB936D175152AB79ACF7A49CDF75DF9B3EBB264F3E6315C48F821\n" err=null
I[2022-05-20|18:36:57.433] bid complete                                 module=bidengine-order order=akash1ggk74pf9avxh3llu30yfhmr345h2yrpf7c2cdu/5964735/1/1
```

## Verify Provider Processes Accepted Bid

* In this section we verify that the provider received and process the bid accepted by the tenant

### Command Template

Issue the commands in this section from a control plane node within the Kubernetes cluster or a machine that has kubectl communication with the cluster.

```
kubectl logs <pod-name> -n akash-services | grep 5964735
```

### Example Command Use

* Using the example command syntax our provider pod will be automatically populated

```
kubectl -n akash-services logs $(kubectl -n akash-services get pods -l app=akash-provider --output jsonpath='{.items[-1].metadata.name}') | grep 5964735
```

### Example/Expected Output

* Provider log events when tenant accepts our bid
* Note the progression thru the `bid complete` to `lease-won` events

```
I[2022-05-20|18:36:57.433] bid complete                                 module=bidengine-order order=akash1ggk74pf9avxh3llu30yfhmr345h2yrpf7c2cdu/5964735/1/1
I[2022-05-20|18:38:10.199] lease won                                    module=provider-manifest lease=akash1ggk74pf9avxh3llu30yfhmr345h2yrpf7c2cdu/5964735/1/1/akash1xmz9es9ay9ln9x2m3q8dlu0alxf0ltce7ykjfx
I[2022-05-20|18:38:10.200] new lease                                    module=manifest-manager deployment=akash1ggk74pf9avxh3llu30yfhmr345h2yrpf7c2cdu/
```

* Subsequent event when tenant sends deployment manifest to provider
* Note the progression thru the `manifest received` to `deploy complete` events

```
I[2022-05-20|18:38:28.620] manifest received                            module=manifest-manager deployment=akash1ggk74pf9avxh3llu30yfhmr345h2yrpf7c2cdu/5964735
I[2022-05-20|18:38:28.620] watchdog done                                module=provider-manifest lease=akash1ggk74pf9avxh3llu30yfhmr345h2yrpf7c2cdu/5964735
D[2022-05-20|18:38:28.620] requests valid                               module=manifest-manager deployment=akash1ggk74pf9avxh3llu30yfhmr345h2yrpf7c2cdu/5964735 num-requests=1
D[2022-05-20|18:38:28.620] publishing manifest received                 module=manifest-manager deployment=akash1ggk74pf9avxh3llu30yfhmr345h2yrpf7c2cdu/5964735 num-leases=1
D[2022-05-20|18:38:28.620] publishing manifest received for lease       module=manifest-manager deployment=akash1ggk74pf9avxh3llu30yfhmr345h2yrpf7c2cdu/5964735 lease_id=akash1ggk74pf9avxh3llu30yfhmr345h2yrpf7c2cdu/5964735/1/1/akash1xmz9es9ay9ln9x2m3q8dlu0alxf0ltce7ykjfx
I[2022-05-20|18:38:28.829] hostnames withheld                           module=provider-cluster cmp=service cmp=deployment-manager lease=akash1ggk74pf9avxh3llu30yfhmr345h2yrpf7c2cdu/5964735/1/1/akash1xmz9es9ay9ln9x2m3q8dlu0alxf0ltce7ykjfx manifest-group=akash cnt=0
I[2022-05-20|18:38:28.907] declaring hostname                           module=provider-cluster-kube lease=akash1ggk74pf9avxh3llu30yfhmr345h2yrpf7c2cdu/5964735/1/1/akash1xmz9es9ay9ln9x2m3q8dlu0alxf0ltce7ykjfx service-name=supermario external-port=80
D[2022-05-20|18:38:28.924] deploy complete                              module=provider-cluster cmp=service cmp=deployment-manager lease=akash1ggk74pf9avxh3llu30yfhmr345h2yrpf7c2cdu/5964735/1/1/akash1xmz9es9ay9ln9x2m3q8dlu0alxf0ltce7ykjfx manifest-group=akash
```
