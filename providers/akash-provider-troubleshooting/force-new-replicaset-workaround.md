# Force New ReplicaSet Workaround

## Overview

The steps outlined in this guide provide a workaround for known issue which occurs when a deployment update is attempted and fails due to the provider being out of resources.  This is happens because K8s won't destroy an old pod instance until it ensures the new one has been created.\
\
GitHub issue description can be found [here](https://github.com/akash-network/support/issues/82).

## Requirements

#### Install JQ

```
apt -y install jq
```

## Steps to Implement

### 1). Create \`/usr/local/bin/akash-force-new-replicasets.sh\` file

```
cat > /usr/local/bin/akash-force-new-replicasets.sh <<'EOF'
#!/bin/bash
#
# Version: 0.2 - 25 March 2023
# Files:
# - /usr/local/bin/akash-force-new-replicasets.sh
# - /etc/cron.d/akash-force-new-replicasets
#
# Description:
# This workaround goes through the newest deployments/replicasets, pods of which can't get deployed due to "insufficient resources" errors and it then removes the older replicasets leaving the newest (latest) one.
# This is only a workaround until a better solution to https://github.com/akash-network/support/issues/82 is found.
#

kubectl get deployment -l akash.network/manifest-service -A -o=jsonpath='{range .items[*]}{.metadata.namespace} {.metadata.name}{"\n"}{end}' |
  while read ns app; do
    kubectl -n $ns rollout status --timeout=10s deployment/${app} >/dev/null 2>&1
    rc=$?
    if [[ $rc -ne 0 ]]; then
      if kubectl -n $ns describe pods | grep -q "Insufficient"; then
        OLD="$(kubectl -n $ns get replicaset -o json -l akash.network/manifest-service --sort-by='{.metadata.creationTimestamp}' | jq -r '(.items | reverse)[1:][] | .metadata.name')"
        for i in $OLD; do kubectl -n $ns delete replicaset $i; done
      fi
    fi
  done
EOF
```

### 2). Mark As Executable File

```
chmod +x /usr/local/bin/akash-force-new-replicasets.sh
```

### 3). Create Cronjob

Create the crontab job /`etc/cron.d/akash-force-new-replicasets` to run the workaround every 5 minutes.

```
cat > /etc/cron.d/akash-force-new-replicasets << 'EOF'
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
SHELL=/bin/bash

*/5 * * * * root /usr/local/bin/akash-force-new-replicasets.sh
EOF
```

