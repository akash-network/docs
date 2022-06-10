# Node Verifications

## View Helm Chart Values

* Utilize this step to ensure the installed Helm Chart user supplied variables are correct
* The values were defined when we executed the `helm install` command with specified parameters

```
helm -n akash-services get values akash-node
```

### **Expected/Sample Output**

```
helm -n akash-services get values akash-node

USER-SUPPLIED VALUES:
image:
  tag: 0.16.4-rc2
state_sync:
  enabled: true
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

```
kubectl logs <name-of-node-pod> -n akash-services
```

### Expected/Sample Output

```
kubectl logs akash-node-1-78954d745c-g46pf -n akash-services | grep -iv peer | tail

4:54PM INF indexed block height=6260707 module=txindex
4:54PM INF Timed out dur=4928.97849 height=6260708 module=consensus round=0 step=1
4:54PM INF received proposal module=consensus proposal={"Type":32,"block_id":{"hash":"F887995CC8AAF5DF842C4F06B70D42C00B9BF5C669C8FD9527E4913F675FEE2D","parts":{"hash":"3A6DDADC168E36A428BFCA020E24FFEE68488A1C2F782FD15BDD092B94CC2EA7","total":1}},"height":6260708,"pol_round":-1,"round":0,"signature":"cCYOvKBc3j3swyb6na8dj2WEjYs56gbNgg/ldYv2NHqsUUp0VCWu/XXC7DOdQ1IGUOcMJTtSDDc9pErBpVnnBw==","timestamp":"2022-06-10T16:54:35.018532747Z"}
4:54PM INF received complete proposal block hash=F887995CC8AAF5DF842C4F06B70D42C00B9BF5C669C8FD9527E4913F675FEE2D height=6260708 module=consensus
4:54PM INF finalizing commit of block hash=F887995CC8AAF5DF842C4F06B70D42C00B9BF5C669C8FD9527E4913F675FEE2D height=6260708 module=consensus num_txs=0 root=6F7415C62DE816E38BB745E6712605601D757F787742B07A3C43E7B2BE3B1295
4:54PM INF minted coins from module account amount=8707778uakt from=mint module=x/bank
4:54PM INF executed block height=6260708 module=state num_invalid_txs=0 num_valid_txs=0
4:54PM INF commit synced commit=436F6D6D697449447B5B36312038382032303020313835203938203637203230382036302031363620343020393320323435203135352036382031313720323031203139312031343220313631203138203731203233352039392036322032343020313931203231392032323620323232203131332031372034385D3A3546383745347D
4:54PM INF committed state app_hash=3D58C8B96243D03CA6285DF59B4475C9BF8EA11247EB633EF0BFDBE2DE711130 height=6260708 module=state num_txs=0
4:54PM INF indexed block height=6260708 module=txindex
```

## Akash Node Status

* Access the Kubernetes shell of the Akash Node deployment to view sync status

```
kubectl exec --stdin --tty -n akash-services <pod-name> -- /bin/bash
```

### Expected/Sample Output

* Note the following expected values:
  * `catching_up` - should be `false` once your Node is in sync with the blockchain
  * `latest_block_height` - compare this block height with the latest height on a block explorer as another method of validating if the node is in sync or if not in sync how close to completing that process the node may be

```
kubectl exec --stdin --tty -n akash-services akash-node-1-78954d745c-g46pf -- /bin/bash

root@akash-node-1-78954d745c-g46pf:/# akash status
{"NodeInfo":{"protocol_version":{"p2p":"8","block":"11","app":"0"},"id":"330603b82b2e0dbeadf84b13d00d81ff19017854","listen_addr":"tcp://0.0.0.0:26656","network":"akashnet-2","version":"0.34.19","channels":"40202122233038606100","moniker":"mynode-1","other":{"tx_index":"on","rpc_address":"tcp://0.0.0.0:26657"}},"SyncInfo":{"latest_block_hash":"826995C3E57B5D5B56F2EB5B47C3F9315F87795F078063DE9E6C736064C3A6C3","latest_app_hash":"1B3DCEFCFA1752777FBEC5B1E26DCB29484D22518C86492D50E8FCE02560D1B5","latest_block_height":"6260678","latest_block_time":"2022-06-10T16:51:26.696963875Z","earliest_block_hash":"1957CBF8018B0819880ADB44402AE837E170FAD47FF5F745F9872D622F037816","earliest_app_hash":"2A0D0C3541D399D24C26A4098A5741C628B28AC15EFEA6947DF6D3D71FD24B1F","earliest_block_height":"6260001","earliest_block_time":"2022-06-10T15:42:43.877575807Z","catching_up":false},"ValidatorInfo":{"Address":"3410C9951968DA68145D8A4F06B3C7BA962D6926","PubKey":{"type":"tendermint/PubKeyEd25519","value":"tHKKYDHdV3VoWtRHzOu5vUP94vGc98QD8bxytH1Jlwo="},"VotingPower":"0"}}
```
