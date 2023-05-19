# Provider Lease Management

Use the verifications included in this section for the following purposes:

* [List Provider Active Leases](provider-lease-management.md#list-provider-active-leases)
* [List Active Leases from Hostname Operator Perspective](provider-lease-management.md#list-active-leases-from-hostname-operator-perspective)
* [Provider Side Lease Closure](provider-lease-management.md#provider-side-lease-closure)
* [Ingress Controller Verifications](provider-lease-management.md#ingress-controller-verifications)

## List Provider Active Leases

### Command Template

Issue the commands in this section from any machine that has the [Akash CLI](../../guides/cli/detailed-steps/) installed.

```
provider-services query market lease list --provider <provider-address> --gseq 0 --oseq 0 --page 1 --limit 500 --state active
```

### Example Command Use

```
provider-services query market lease list --provider akash1yvu4hhnvs84v4sv53mzu5ntf7fxf4cfup9s22j --gseq 0 --oseq 0 --page 1 --limit 500 --state active
```

### Example Output

```
leases:
- escrow_payment:
    account_id:
      scope: deployment
      xid: akash19gs08y80wlk5wl4696wz82z2wrmjw5c84cvw28/5903794
    balance:
      amount: "0.455120000000000000"
      denom: uakt
    owner: akash1q7spv2cw06yszgfp4f9ed59lkka6ytn8g4tkjf
    payment_id: 1/1/akash1q7spv2cw06yszgfp4f9ed59lkka6ytn8g4tkjf
    rate:
      amount: "24.780240000000000000"
      denom: uakt
    state: open
    withdrawn:
      amount: "32536"
      denom: uakt
  lease:
    closed_on: "0"
    created_at: "5903822"
    lease_id:
      dseq: "5903794"
      gseq: 1
      oseq: 1
      owner: akash19gs08y80wlk5wl4696wz82z2wrmjw5c84cvw28
      provider: akash1q7spv2cw06yszgfp4f9ed59lkka6ytn8g4tkjf
    price:
      amount: "24.780240000000000000"
      denom: uakt
    state: active
```

## List Active Leases from Hostname Operator Perspective

#### **Command Syntax**

Issue the commands in this section from a control plane node within the Kubernetes cluster or a machine that has the kubectl communication with the cluster.

```
kubectl -n lease get providerhosts
```

#### **Example Output**

```
NAME                                                  AGE
gtu5bo14f99elel76srrbj04do.ingress.akashtesting.xyz   60m
kbij2mvdlhal5dgc4pc7171cmg.ingress.akashtesting.xyz   18m
```

## Provider Side Lease Closure

### **Command Template**

Issue the commands in this section from a control plane node within the Kubernetes cluster or a machine that has the kubectl communication with the cluster.

```
provider-services tx market bid close --node $AKASH_NODE --chain-id $AKASH_CHAIN_ID --owner <TENANT-ADDRESS> --dseq $AKASH_DSEQ --gseq 1 --oseq 1 --from <PROVIDER-ADDRESS> --keyring-backend $AKASH_KEYRING_BACKEND -y --gas-prices="0.025uakt" --gas="auto" --gas-adjustment=1.15
```

### Example Command Use

```
provider-services tx market bid close --node $AKASH_NODE --chain-id akashnet-2 --owner akash1n44zc8l6gfm0hpydldndpg8n05xjjwmuahc6nn --dseq 5905802 --gseq 1 --oseq 1 --from akash1yvu4hhnvs84v4sv53mzu5ntf7fxf4cfup9s22j --keyring-backend os -y --gas-prices="0.025uakt" --gas="auto" --gas-adjustment=1.15
```

### **Example Output (Truncated)**

```
{"height":"5906491","txhash":"0FC7DA74301B38BC3DF2F6EBBD2020C686409CE6E973E25B4E8F0F1B83235473","codespace":"","code":0,"data":"0A230A212F616B6173682E6D61726B65742E763162657461322E4D7367436C6F7365426964","raw_log":"[{\"events\":[{\"type\":\"akash.v1\",\"attributes\":[{\"key\":\"module\",\"value\":\"deployment\"},{\"key\":\"action\",\"value\":\"group-paused\"},{\"key\":\"owner\",\"value\":\"akash1n44zc8l6gfm0hpydldndpg8n05xjjwmuahc6nn\"},{\"key\":\"dseq\",\"value\":\"5905802\"},{\"key\":\"gseq\",\"value\":\"1\"},{\"key\":\"module\",\"value\":\"market\"},{\"key\":\"action\",\"value\":\"lease-closed\"}
```

## Ingress Controller Verifications

### Example Command Use

Issue the commands in this section from a control plane node within the Kubernetes cluster or a machine that has the kubectl communication with the cluster.

```
kubectl get ingress -A
```

### Example Output

* **NOTE -** in this example output the last entry (with namespace moc58fca3ccllfrqe49jipp802knon0cslo332qge55qk) represents an active deployment on the provider

```
NAMESPACE                                       NAME                                                  CLASS                 HOSTS                                                 ADDRESS                   PORTS   AGE

moc58fca3ccllfrqe49jipp802knon0cslo332qge55qk   5n0vp4dmbtced00smdvb84ftu4.ingress.akashtesting.xyz   akash-ingress-class   5n0vp4dmbtced00smdvb84ftu4.ingress.akashtesting.xyz   10.0.10.122,10.0.10.236   80      70s
```
