# Provider Maintenance

## Stop Provider Services Prior to Maintenance

When conducting maintenance on your Akash Provider, ensure the `akash-provider` service is stopped during the maintenance period.

> An issue exist currently in which provider leases may be lost during maintenance activities if the `akash-provider` service is not stopped prior.  This issue is detailed further [here](https://github.com/akash-network/provider/issues/64).

#### Steps to Stop the `akash-provider` Service

```
kubectl -n akash-services get statefulsets
kubectl -n akash-services scale statefulsets akash-provider --replicas=0
```

#### Steps to Verify the `akash-provider` Service Has Been Stopped

```
kubectl -n akash-services get statefulsets
kubectl -n akash-services get pods -l app=akash-provide
```

#### Steps to Start the `akash-provider` Service Post Maintenance

```
kubectl -n akash-services scale statefulsets akash-provider --replicas=1
```
