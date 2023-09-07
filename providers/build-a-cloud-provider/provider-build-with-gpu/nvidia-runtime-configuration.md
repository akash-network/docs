# NVIDIA Runtime Configuration

> _**NOTE**_ - This step should be completed on the Kubespray host only

In this step we add the NVIDIA runtime confguration into the Kubespray inventory.  The runtime will be applied to necessary Kubernetes hosts when Kubespray builds the cluster in the subsequent step.

```
cat > ~/kubespray/inventory/akash/group_vars/all/akash.yml <<'EOF'
ansible_user: root

ansible_connection: ssh

containerd_additional_runtimes:
  - name: nvidia
    type: "io.containerd.runc.v2"
    engine: ""
    root: ""
    options:
      BinaryName: '"/usr/bin/nvidia-container-runtime"'
EOF
```

