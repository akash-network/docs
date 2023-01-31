# Heal Broken Deployment Replicas by Returning Lost command to Manifests

Prior to the `provider` version `0.2.1` (`akash/provider helm-chart version 4.2.0`) there was an issue which was affecting some deployments.

## Issue

&#x20;The deployments with the `command` explicitly set in their SDL manifest files were losing it upon `akash-provider` pod/service restart.

This was leading to their replica pods running in `CrashLoopBackOff` state on the provider side reserving additional resources, while the original replica was still running which was not visible to the client.

## Impact

* Double amount of the resources are being occupied by the deployment on the provider side
* Manifests of these deployments are missing the command

The good news is that both issues can be fixed without the customer intervention.

Once you have updated your provider to 0.2.1 version following the instructions, you can patch the manifests with the correct command which will get rid of the deployments left in `CrashLoopBackOff` state.

**STEP1** - Backup manifests

Before patching the manifests, please make sure to back them up.

```
mkdir before
cd before
for i in manifests providerhosts providerleasedips; do kubectl -n lease get $i -o yaml > $i-backup.yaml; done
```

They can help in troubleshooting the issues should any arise later.

**STEP2** - Collect the deployments which are affected by the lost command issue

```
kubectl get deployment -l akash.network/manifest-service -A -o=jsonpath='{range .items[*]}{.metadata.namespace} {.metadata.name}{"\n"}{end}' |
  while read ns app; do
    kubectl -n $ns rollout status --timeout=60s deployment/${app} >/dev/null 2>&1
    rc=$?
    if [[ $rc -ne 0 ]]; then
      kubectl -n $ns rollout history deployment/${app} -o json |
        jq -r '[(.metadata | .annotations."deployment.kubernetes.io/revision", .namespace, .name), (.spec.template.spec.containers[0].command|tostring)] | @tsv'
      echo
     fi
   done
```

_**Example Output:**_

> revision, namespace, pod, command

```
3	2anv3d7diieucjlga92fk8e5ej12kk8vmtkpi9fpju79a	cloud-sql-proxy-7bfb55ddb	["sh","-c"]
4	2anv3d7diieucjlga92fk8e5ej12kk8vmtkpi9fpju79a	cloud-sql-proxy-57c8f9ff48	null

3	2dl4vdk2f7ia1m0vme8nqkv0dadnnj15becr5pmfu9j22	cloud-sql-proxy-7dc7f5b856	["sh","-c"]
4	2dl4vdk2f7ia1m0vme8nqkv0dadnnj15becr5pmfu9j22	cloud-sql-proxy-864fd4cff4	null

1	2k83g8gstuugse0952arremk4gphib709gi7b6q6srfdo	app-78756d77ff	["bash","-c"]
2	2k83g8gstuugse0952arremk4gphib709gi7b6q6srfdo	app-578b949f48	null

7	2qpj8537lq7tiv9fabdhk8mn4j75h3anhtqb1b881fhie	cloud-sql-proxy-7c5f486d9b	["sh","-c"]
8	2qpj8537lq7tiv9fabdhk8mn4j75h3anhtqb1b881fhie	cloud-sql-proxy-6c95666bc8	null

1	b49oi05ph3bo7rdn2kvkkpk4tcigb3ts0o7sp40fcdk5o	app-b58f9bb4f	["bash","-c"]
2	b49oi05ph3bo7rdn2kvkkpk4tcigb3ts0o7sp40fcdk5o	app-6dd87bb7c6	null
3	b49oi05ph3bo7rdn2kvkkpk4tcigb3ts0o7sp40fcdk5o	app-57c67cc57d	["bash","-c"]
4	b49oi05ph3bo7rdn2kvkkpk4tcigb3ts0o7sp40fcdk5o	app-655567846f	null
```

The pods with the null commands are the bad replicas in this case, affected by the lost command issue.

You might see some pods with `null` commands for those replicas which stuck in `Pending` state because of insufficient resources on the provider, just ignore those.

They will start back again once provider regains enough capacity.

**STEP3** - Patch the manifests

```
kubectl get deployment -l akash.network/manifest-service -A -o=jsonpath='{range .items[*]}{.metadata.namespace} {.metadata.name}{"\n"}{end}' |
  while read ns app; do
    kubectl -n $ns rollout status --timeout=60s deployment/${app} >/dev/null 2>&1
    rc=$?
    if [[ $rc -ne 0 ]]; then
      command=$(kubectl -n $ns rollout history deployment/${app} -o json | jq -sMc '.[0].spec.template.spec.containers[0].command | select(length > 0)')
      if [[ $command != "null" && ! -z $command ]]; then
        index=$(kubectl -n lease get manifests $ns -o json | jq --arg app $app -r '[.spec.group.services[]] | map(.name == $app) | index(true)')
        if [[ $index == "null" || -z $index ]]; then
          echo "Error: index=$index, skipping $ns/$app ..."
          continue
        fi
        echo "Patching manifest ${ns} to return the ${app} app its command: ${command} (index: ${index})"
        kubectl -n lease patch manifests $ns --type='json' -p='[{"op": "add", "path": "/spec/group/services/'${index}'/command", "value":'${command}'}]'

        ### to debug:  --dry-run=client -o json | jq -Mc '.spec.group.services[0].command'
        ### locate service by its name instead of using the index: kubectl -n lease get manifests $ns -o json | jq --indent 4 --arg app $app --argjson command $command -r '(.spec.group.services[] | select(.name == $app)) |= . + { command: $command }' | kubectl apply -f -
        echo
      else
        echo "Skipping ${ns}/${app} which does not use command in SDL."
      fi
     fi
   done
```

_**Example Output**_:

```
Patching manifest 2anv3d7diieucjlga92fk8e5ej12kk8vmtkpi9fpju79a to return the cloud-sql-proxy its command: ["sh","-c"]
manifest.akash.network/2anv3d7diieucjlga92fk8e5ej12kk8vmtkpi9fpju79a patched

Patching manifest 2dl4vdk2f7ia1m0vme8nqkv0dadnnj15becr5pmfu9j22 to return the cloud-sql-proxy its command: ["sh","-c"]
manifest.akash.network/2dl4vdk2f7ia1m0vme8nqkv0dadnnj15becr5pmfu9j22 patched

Patching manifest 2k83g8gstuugse0952arremk4gphib709gi7b6q6srfdo to return the app its command: ["bash","-c"]
manifest.akash.network/2k83g8gstuugse0952arremk4gphib709gi7b6q6srfdo patched

Patching manifest 2qpj8537lq7tiv9fabdhk8mn4j75h3anhtqb1b881fhie to return the cloud-sql-proxy its command: ["sh","-c"]
manifest.akash.network/2qpj8537lq7tiv9fabdhk8mn4j75h3anhtqb1b881fhie patched

Patching manifest b49oi05ph3bo7rdn2kvkkpk4tcigb3ts0o7sp40fcdk5o to return the app its command: ["bash","-c"]
manifest.akash.network/b49oi05ph3bo7rdn2kvkkpk4tcigb3ts0o7sp40fcdk5o patched
```

**STEP4** - Bounce the provider pod/service

```
kubectl -n akash-services delete pods -l app=akash-provider
```

That's all.  The bad replicas will disappear on their own.

Example with one namespace:

_**Before**_:

```
0obkk0j6vdnp7qmsj477a88ml4i0639628gcn016smrg0   cloud-sql-proxy-69f75ffbdc-c5t69                                  1/1     Running            0                 20d
0obkk0j6vdnp7qmsj477a88ml4i0639628gcn016smrg0   syncer-59c447b98c-t9xv9                                           1/1     Running            36 (15h ago)      20d
0obkk0j6vdnp7qmsj477a88ml4i0639628gcn016smrg0   cloud-sql-proxy-56b5685cc7-qjvh2                                  0/1     CrashLoopBackOff   5587 (48s ago)    19d
```

_**After:**_

```
0obkk0j6vdnp7qmsj477a88ml4i0639628gcn016smrg0   cloud-sql-proxy-69f75ffbdc-c5t69                                  1/1     Running            0                  20d
0obkk0j6vdnp7qmsj477a88ml4i0639628gcn016smrg0   syncer-59c447b98c-t9xv9                                           1/1     Running            36 (15h ago)       20d
```

## Persistent Storage Deployments

* Persistent storage enabled deployments are of statefulset kind.
* These do not have replicas and thus `CrashLoopBackOff` containers.
* There is no impact, so you can skip them.
* However, if you still want to fix their manifests, then apply the following procedure

**STEP1** - Verify the statefulset deployments

Here you can ignore the "null" ones, they are normal deployments just not using the command in their SDL manifest files.

```
kubectl get statefulset -l akash.network/manifest-service -A -o=jsonpath='{range .items[*]}{.metadata.namespace} {.metadata.name}{"\n"}{end}' |
  while read ns app; do
    kubectl -n $ns get statefulset $app -o json | jq -r '[(.metadata | .namespace, .name), (.spec.template.spec.containers[0].command|tostring)] | @tsv'
    echo
   done
```

_**Example Output:**_

```
4ibg2ii0dssqtvb149thrd4a6a46g4mkcln2v70s6p20c	hnsnode	["hsd","--bip37=true","--public-host=REDACTED","--listen=true","--port=REDACTED","--max-inbound=REDACTED"]

66g95hmtta0bn8dajdcimo55glf60sne7cg8u9mv6j9l6	postgres	["sh","-c"]

esnphe9a86mmn3ibdcrncul82nnck7p4dpdj69ogu4b7o	validator	null

idr99rvt44lt6m1rp7vc1o0thpfqdqgcnfplj2a92ju86	web	null

k9ch280ud97qle6bqli9bqk65pn7h07tohmrmq88sofq2	wiki	null

tahcqnrs6dvo9ugee59q94nthgq5mm645e89cmml906m2	node	null
```

**STEP2** - Patch the manifest

```
kubectl get statefulset -l akash.network/manifest-service -A -o=jsonpath='{range .items[*]}{.metadata.namespace} {.metadata.name}{"\n"}{end}' |
  while read ns app; do
    command=$(kubectl -n $ns get statefulset $app -o json | jq -Mc '.spec.template.spec.containers[0].command')
    if [[ $command != "null" && ! -z $command ]]; then
      echo "Patching manifest ${ns} to return the ${app} its command: ${command}"
      kubectl -n lease patch manifests $ns --type='json' -p='[{"op": "add", "path": "/spec/group/services/0/command", "value":'${command}'}]'
      ## to debug:  --dry-run=client -o json | jq -Mc '.spec.group.services[0].command'
      echo
    else
      echo "Skipping ${ns}/${app} which does not use command in SDL."
    fi
   done
```

That's all. There is no need bouncing the `akash-provider` pod/service for the statefulset deployment.
