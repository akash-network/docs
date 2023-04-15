# NVIDIA Runtime Configuration

> _**NOTE**_ - This step should be completed on the Kubespray host

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

