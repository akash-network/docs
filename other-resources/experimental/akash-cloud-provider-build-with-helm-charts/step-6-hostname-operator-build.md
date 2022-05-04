# Step 6 - Hostname Operator Build

* Run the following command to build the Kubernetes hostname operator

```
helm install hostname-operator akash/hostname-operator -n akash-services --set image.tag="0.16.4-rc0"
```

#### Expected/Example Output

```
NAME: hostname-operator
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
