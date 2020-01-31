# layer 2

In this step, you'll install monitoring stack such as prometheus, graphana and metrics server

```
make layer2-install HOST=node.sjc1.ovrclk1.com
```

### Verify

Verify the monitoring pods are setup properly

```
kubectl get pods -n monitoring
```

Should give you a response, similar to:

```
prometheus-kube-state-metrics-698c5bfbd6-scl4v   1/1     Running   0          2m7s
prometheus-node-exporter-2f46s                   1/1     Running   0          2m7s
prometheus-pushgateway-7d85754c5d-vqfrw          1/1     Running   0          2m7s
grafana-756fdcb548-f548d                         1/1     Running   0          2m5s
metrics-server-77f4b87964-99k5w                  1/1     Running   0          2m3s
prometheus-alertmanager-58744c5f9d-v6r4r         2/2     Running   0          2m7s
prometheus-server-85566d5586-bm569               2/2     Running   0          2m7s
```
