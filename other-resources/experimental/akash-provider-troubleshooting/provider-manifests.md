# Provider Manifests

Use the verifications included in this section for the following purposes:

* [Retrieve Active Manifest List From Provider](provider-manifests.md#retrieve-active-manifest-list-from-provider)
* [Retrieve Manifest Detail From Provider](provider-manifests.md#retrieve-manifest-detail-from-provider)

## Retrieve Active Manifest List From Provider

### **Command Syntax**

Issue the commands in this section from a control plane node within the Kubernetes cluster or a machine that has kubectl communication with the cluster.

```
kubectl -n lease get manifests --show-labels
```

### Example Output

* The show-labels options includes display of associated DSEQ / OSEQ / GSEQ / Owner labels

```
kubectl -n lease get manifests --show-labels

NAME                                            AGE   LABELS
h644k9qp92e0qeakjsjkk8f3piivkuhgc6baon9tccuqo   26h   akash.network/lease.id.dseq=5950031,akash.network/lease.id.gseq=1,akash.network/lease.id.oseq=1,akash.network/lease.id.owner=akash15745vczur53teyxl4k05u250tfvp0lvdcfqx27,akash.network/lease.id.provider=akash1xmz9es9ay9ln9x2m3q8dlu0alxf0ltce7ykjfx,akash.network/namespace=h644k9qp92e0qeakjsjkk8f3piivkuhgc6baon9tccuqo,akash.network=true
```

## Retrieve Manifest Detail From Provider

### Command Template

Issue the commands in this section from a control plane node within the Kubernetes cluster or a machine that has kubectl communication with the cluster.

```
kubectl -n lease get manifest <namespace> -o yaml
```

### Example Command Use

* **Note -** use the \`kubectl get ingress -A\` covered in this guide to lookup the namespace of the deployment of interest

```
kubectl -n lease get manifest moc58fca3ccllfrqe49jipp802knon0cslo332qge55qk -o yaml
```

### Example Output

```
apiVersion: akash.network/v2beta1
kind: Manifest
metadata:
  creationTimestamp: "2022-05-16T14:42:29Z"
  generation: 1
  labels:
    akash.network: "true"
    akash.network/lease.id.dseq: "5905802"
    akash.network/lease.id.gseq: "1"
    akash.network/lease.id.oseq: "1"
    akash.network/lease.id.owner: akash1n44zc8l6gfm0hpydldndpg8n05xjjwmuahc6nn
    akash.network/lease.id.provider: akash1yvu4hhnvs84v4sv53mzu5ntf7fxf4cfup9s22j
    akash.network/namespace: moc58fca3ccllfrqe49jipp802knon0cslo332qge55qk
  name: moc58fca3ccllfrqe49jipp802knon0cslo332qge55qk
  namespace: lease
  resourceVersion: "75603"
  uid: 81fc7e4f-9091-44df-b4cf-5249ddd4863d
spec:
  group:
    name: akash
    services:
    - count: 1
      expose:
      - external_port: 80
        global: true
        http_options:
          max_body_size: 1048576
          next_cases:
          - error
          - timeout
          next_tries: 3
          read_timeout: 60000
          send_timeout: 60000
        port: 8080
        proto: TCP
      image: pengbai/docker-supermario
      name: supermario
      unit:
        cpu: 100
        memory: "268435456"
        storage:
        - name: default
          size: "268435456"
  lease_id:
    dseq: "5905802"
    gseq: 1
    oseq: 1
    owner: akash1n44zc8l6gfm0hpydldndpg8n05xjjwmuahc6nn
    provider: akash1yvu4hhnvs84v4sv53mzu5ntf7fxf4cfup9s22j
```
