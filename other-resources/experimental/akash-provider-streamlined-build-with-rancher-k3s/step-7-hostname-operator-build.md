# STEP 7 - Hostname Operator Build

* Run the following command to build the Kubernetes hostname operator
* Note - if a need arises to use a different software version other than the one defined in the Chart.yaml Helm file - include the following switch.  In most circumstances this should not be necessary.
  * `--set image.tag=<image-name>`
  * Example: `--set image.tag=0.1.0`

```
helm install akash-hostname-operator akash/akash-hostname-operator -n akash-services
```

#### Expected/Example Output

```
NAME: akash-hostname-operator
LAST DEPLOYED: Thu Apr 28 19:06:30 2022
NAMESPACE: akash-services
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
1. Get the application URL by running these commands:
  export POD_NAME=$(kubectl get pods --namespace akash-services -l "app.kubernetes.io/name=hostname-operator,app.kubernetes.io/instance=hostname-operator" -o jsonpath="{.items[0].metadata.name}")
  export CONTAINER_PORT=$(kubectl get pod --namespace akash-services $POD_NAME -o jsonpath="{.spec.containers[0].ports[0].containerPort}")
  echo "Visit http://127.0.0.1:8080 to use your application"
  kubectl --namespace akash-services port-forward $POD_NAME 8080:$CONTAINER_PORT
```

## **Hostname Operator Confirmation**

```
kubectl get pods -n akash-services
```

#### **Expected output (example and name following akash-provider will differ)**

<pre><code>root@node1:~# kubectl get pods -n akash-services

NAME                                 READY   STATUS    RESTARTS   AGE
akash-provider-76966c6795-lvphs      1/1     Running   0          16m
<strong>akash-hostname-operator-84977c6fd9-qvnsm   1/1     Running   0          3m29s
</strong></code></pre>

