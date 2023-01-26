# Node Verifications

## View Helm Chart Values

* Utilize this step to ensure the installed Helm Chart user supplied variables are correct
* The values were defined when we executed the `helm install` command with specified parameters

```
helm -n akash-services get values akash-node
```

### **Expected/Sample Output**

* If custom values were included with the `helm install` command the following output is expected (example)

```
helm -n akash-services get values akash-node

USER-SUPPLIED VALUES:
image:
  tag: 0.18.1
state_sync:
  enabled: true
```

* If no custom values were included with the `helm install` command the following output is expected

```
USER-SUPPLIED VALUES:
null
```

## Verify Akash Node Pod Status

* Confirm that the Akash Node pod is in a pristine state

```
kubectl get pods -n akash-services
```

### Expected/Sample Output

```
kubectl get pods -n akash-services

NAME                            READY   STATUS    RESTARTS   AGE
akash-node-1-78954d745c-xgkhx   1/1     Running   0          50s
```

## Verify Akash Node Sync via Logs

* Ensure that the Akash Node pod has errors of concerns in logs and that the blockchain sync is progressing
* Replace the `name-of-pod` variable with `akash-node` pod name displayed in the previous step

```
kubectl logs <name-of-pod> -n akash-services | grep -iv peer | tail
```

### Expected/Sample Output

```
kubectl logs akash-node-1-78954d745c-xgkhx -n akash-services | grep -iv peer | tail

2:07PM INF Applied snapshot chunk to ABCI app chunk=16 format=1 height=6442000 module=statesync total=26
2:07PM INF Applied snapshot chunk to ABCI app chunk=17 format=1 height=6442000 module=statesync total=26
2:07PM INF Applied snapshot chunk to ABCI app chunk=18 format=1 height=6442000 module=statesync total=26
2:07PM INF Applied snapshot chunk to ABCI app chunk=19 format=1 height=6442000 module=statesync total=26
2:07PM INF Discovered new snapshot format=1 hash=":��6u�^�/G号Ĝ��d]��W�]/\x11�S�N*�" height=6443000 module=statesync
2:07PM INF Discovered new snapshot format=1 hash="�\x1bkn\x18��_��\x06���8��,��\f�Jp�\x01Ft�\t�~" height=6442500 module=statesync
2:07PM INF Applied snapshot chunk to ABCI app chunk=20 format=1 height=6442000 module=statesync total=26
2:07PM INF Applied snapshot chunk to ABCI app chunk=21 format=1 height=6442000 module=statesync total=26
2:07PM INF Applied snapshot chunk to ABCI app chunk=22 format=1 height=6442000 module=statesync total=26
2:07PM INF Applied snapshot chunk to ABCI app chunk=23 format=1 height=6442000 module=statesync total=26
```

## Akash Node Status

### Access Pod Shell

* Access the Kubernetes shell of the Akash Node deployment to view sync status

```
kubectl exec --stdin --tty -n akash-services <pod-name> -- /bin/bash
```

### Verify Node Status

```
akash status
```

#### Expected/Sample Output

* Note the following expected values:
  * `catching_up` - should be `false` once your Node is in sync with the blockchain
  * `latest_block_height` - compare this block height with the latest height on a block explorer as another method of validating if the node is in sync or if not in sync how close to completing that process the node may be

```
kubectl exec --stdin --tty -n akash-services akash-node-1-78954d745c-g46pf -- /bin/bash

root@akash-node-1-78954d745c-g46pf:/# akash status
{"NodeInfo":{"protocol_version":{"p2p":"8","block":"11","app":"0"},"id":"330603b82b2e0dbeadf84b13d00d81ff19017854","listen_addr":"tcp://0.0.0.0:26656","network":"akashnet-2","version":"0.34.19","channels":"40202122233038606100","moniker":"mynode-1","other":{"tx_index":"on","rpc_address":"tcp://0.0.0.0:26657"}},"SyncInfo":{"latest_block_hash":"826995C3E57B5D5B56F2EB5B47C3F9315F87795F078063DE9E6C736064C3A6C3","latest_app_hash":"1B3DCEFCFA1752777FBEC5B1E26DCB29484D22518C86492D50E8FCE02560D1B5","latest_block_height":"6260678","latest_block_time":"2022-06-10T16:51:26.696963875Z","earliest_block_hash":"1957CBF8018B0819880ADB44402AE837E170FAD47FF5F745F9872D622F037816","earliest_app_hash":"2A0D0C3541D399D24C26A4098A5741C628B28AC15EFEA6947DF6D3D71FD24B1F","earliest_block_height":"6260001","earliest_block_time":"2022-06-10T15:42:43.877575807Z","catching_up":false},"ValidatorInfo":{"Address":"3410C9951968DA68145D8A4F06B3C7BA962D6926","PubKey":{"type":"tendermint/PubKeyEd25519","value":"tHKKYDHdV3VoWtRHzOu5vUP94vGc98QD8bxytH1Jlwo="},"VotingPower":"0"}}
```
