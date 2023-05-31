# STEP 9 - Custom Kernel Parameters

## Create and apply custom kernel parameters

Apply these settings to ALL Kubernetes worker nodes to guard against `too many open files` errors.

### Create Config

```
cat > /etc/sysctl.d/90-akash.conf << EOF
# Common: tackle "failed to create fsnotify watcher: too many open files"
fs.inotify.max_user_instances = 512
fs.inotify.max_user_watches = 1048576

# Custom: increase memory mapped files limit to allow Solana node
# https://docs.solana.com/running-validator/validator-start
vm.max_map_count = 1000000
EOF
```

### Apply Config

```
sysctl -p /etc/sysctl.d/90-akash.conf
```
