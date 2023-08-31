# Apply NVIDIA Runtime Engine

> _**NOTE**_ - conduct these steps on the control plane node that Helm was installed on via the previous step

## Create RuntimeClass

#### Create the NVIDIA Runtime Config

```
cat > nvidia-runtime-class.yaml << EOF
kind: RuntimeClass
apiVersion: node.k8s.io/v1
metadata:
  name: nvidia
handler: nvidia
EOF
```

#### Apply the NVIDIA Runtime Config

```
kubectl apply -f nvidia-runtime-class.yaml
```

## Upgrade/Install the NVIDIA Device Plug In Via Helm

```
helm upgrade -i nvdp nvdp/nvidia-device-plugin \
  --namespace nvidia-device-plugin \
  --create-namespace \
  --version 0.13.0 \
  --set runtimeClassName="nvidia"
```

#### Expected/Example Output

```
root@ip-172-31-8-172:~# helm upgrade -i nvdp nvdp/nvidia-device-plugin \
  --namespace nvidia-device-plugin \
  --create-namespace \
  --version 0.13.0 \
  --set runtimeClassName="nvidia"
  
Release "nvdp" does not exist. Installing it now.
NAME: nvdp
LAST DEPLOYED: Thu Apr 13 19:11:28 2023
NAMESPACE: nvidia-device-plugin
STATUS: deployed
REVISION: 1
TEST SUITE: None
```

## Verification

```
kubectl -n nvidia-device-plugin logs -l app.kubernetes.io/instance=nvdp
```

#### Example/Expected Output

```
 root@node1:~# kubectl -n nvidia-device-plugin logs -l app.kubernetes.io/instance=nvdp
  "sharing": {
    "timeSlicing": {}
  }
}
2023/04/14 14:18:27 Retreiving plugins.
2023/04/14 14:18:27 Detected NVML platform: found NVML library
2023/04/14 14:18:27 Detected non-Tegra platform: /sys/devices/soc0/family file not found
2023/04/14 14:18:27 Starting GRPC server for 'nvidia.com/gpu'
2023/04/14 14:18:27 Starting to serve 'nvidia.com/gpu' on /var/lib/kubelet/device-plugins/nvidia-gpu.sock
2023/04/14 14:18:27 Registered device plugin for 'nvidia.com/gpu' with Kubelet
  "sharing": {
    "timeSlicing": {}
  }
}
2023/04/14 14:18:29 Retreiving plugins.
2023/04/14 14:18:29 Detected NVML platform: found NVML library
2023/04/14 14:18:29 Detected non-Tegra platform: /sys/devices/soc0/family file not found
2023/04/14 14:18:29 Starting GRPC server for 'nvidia.com/gpu'
2023/04/14 14:18:29 Starting to serve 'nvidia.com/gpu' on /var/lib/kubelet/device-plugins/nvidia-gpu.sock
2023/04/14 14:18:29 Registered device plugin for 'nvidia.com/gpu' with Kubelet
```
