# Akash GSEQ and OSEQ Description and Utility

## GSEQ - Group Sequence

* Akash GSEQ is used to distinguish “groups” of containers in a deployment. Each group can be leased independently - orders, bids, and leases all act on a single group.
* Most often Akash deployments utilize only one group - GSEQ=1 - with all pods associated with the deployment using a single provider.
* Example SDL section that would provoke GSEQ specification other than 1 is provided below. In this SDL extracted section we request bids from multiple providers via the declaration of multiple placement sections (`westcoast` and `eastcoast`).
* With the individual placement sections we can define different attributes to dictate that the orders should receive bids from different providers.&#x20;
* In this example we define the westcoast placement section with an attribute of `region: us-west` and the eastcoast placement of `region: us-east` ensuring the pods land in a desired region.

```
  placement:
    westcoast:
      attributes:
        region: us-west
      pricing:
        grafana-profile:
          denom: uakt
          amount: 10000
    eastcoast:
      attributes:
        region: us-east
      pricing:
        postgres-profile:
          denom: uakt
          amount: 10000
```

* When the deployment is created with the use of multiple placement sections the GSEQ defines the individual, unique orders are distinguished via GSEQ and as seen from a  deployment creation output shown below. Note the value of GSEQ=1 in the first order created and the value of GSEQ=2 in the second order created.
* We can now target the individual orders as necessary in operations such as create lease.

```
{"order-created"},{"key":"owner","value":"akash1ggk74pf9avxh3llu30yfhmr345h2yrpf7c2cdu"},{"key":"dseq","value":"9507298"},{"key":"gseq","value":"1"},{"key":"oseq","value":"1"}

{"order-created"},{"key":"owner","value":"akash1ggk74pf9avxh3llu30yfhmr345h2yrpf7c2cdu"},{"key":"dseq","value":"9507298"},{"key":"gseq","value":"2"},{"key":"oseq","value":"1"}
```

## OSEQ - Order Sequence

* Akash OSEQ is used to distinguish multiple orders associated with a single deployment.
* Most often Akash deployments utilize only OSEQ equal to 1 with only a single order associated with the deployment.
* The OSEQ is only incremented when a lease associated with an existing deployment is closed and a new order is then generated.
* _**NOTE**_ - typically when a tenant requires movement of a deployment from one provider to another - the tenant will completely close the deployment and create anew. This would create a new deployment ID (DSEQ) with the order sequence number of 1 (OSEQ = 1). Only when the deployment is left open and the lease is closed (I.e. via `lease close`) would the OSEQ increment.
* To further clarify the use of OSEQ the following example is used:
* Initially we create a typical deployment:

```
provider-services tx deployment create deploy.yml --from $AKASH_KEY_NAME
```

* When the deployment is created we receive standard DSEQ, GSEQ, and OSEQ values such as (note specifically the DSEQ and OSEQ values):

```
{"order-created"},{"key":"owner","value":"akash1ggk74pf9avxh3llu30yfhmr345h2yrpf7c2cdu"},{"key":"dseq","value":"9507524"},{"key":"gseq","value":"1"},{"key":"oseq","value":"1"}]
```

* We proceed thru lease creation with desired provider
* Later we decide that we would like to move the deployment to a new provider and prefer to leave the deployment itself open and only close the current lease such as:

```
provider-services tx market lease close --node $AKASH_NODE --dseq $AKASH_DSEQ --provider $AKASH_PROVIDER --from $AKASH_KEY_NAME
```

* With the lease of the former provider now closed, a new order will be generated and the OSEQ (order sequence) is now incremented to 2. From the example deployment we see this increment OSEQ when we review the bid list from the new order such as the output displayed below.
* _**NOTE**_ - to display this bid list the following command syntax was used. Note the use of env variables oseq and gseq set to `0`. This syntax displays all bids for a deployment regardless of the OSEQ/GSEQ current sequence number.

#### Command Used:

```
provider-services query market bid list --owner=$AKASH_ACCOUNT_ADDRESS --node $AKASH_NODE --dseq $AKASH_DSEQ  --gseq 0 --oseq 0
```

#### Output:

```
bid:
    bid_id:
      dseq: "9507524"
      gseq: 1
      oseq: 2
      owner: akash1ggk74pf9avxh3llu30yfhmr345h2yrpf7c2cdu
      provider: akash1lmaulqyvlj0wwcjm5dgqn5wv5j957g672g20ht
    created_at: "9507559"
```
