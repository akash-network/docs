# NVIDIA Runtime Configuration

## Worker nodes

> _**IMPORTANT**_ - This should be done on all worker nodes that have GPU installed!

Update the nvidia-container-runtime config in order to prevent `NVIDIA_VISIBLE_DEVICES=all` abuse where tenants could access more GPU's than they requested.

> _**NOTE**_ - This will only work with `nvdp/nvidia-device-plugin` helm chart installed with `--set deviceListStrategy=volume-mounts` (you'll get there in the next steps)

Make sure the config file `/etc/nvidia-container-runtime/config.toml` contains these line uncommmented and set to these values:

```
accept-nvidia-visible-devices-as-volume-mounts = true
accept-nvidia-visible-devices-envvar-when-unprivileged = false
```

> _**NOTE**_ - `/etc/nvidia-container-runtime/config.toml` is part of `nvidia-container-toolkit-base` package; so it won't override the customer-set parameters there since it is part of the `/var/lib/dpkg/info/nvidia-container-toolkit-base.conffiles`

## Kubespray

> _**NOTE**_ - This step should be completed on the Kubespray host only

In this step we add the NVIDIA runtime confguration into the Kubespray inventory.  The runtime will be applied to necessary Kubernetes hosts when Kubespray builds the cluster in the subsequent step.

```
cat > ~/kubespray/inventory/akash/group_vars/all/akash.yml <<'EOF'
containerd_additional_runtimes:
  - name: nvidia
    type: "io.containerd.runc.v2"
    engine: ""
    root: ""
    options:
      BinaryName: '/usr/bin/nvidia-container-runtime'
EOF
```

