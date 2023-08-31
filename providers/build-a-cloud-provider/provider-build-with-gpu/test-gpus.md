# Test GPUs

## Launch GPU Test Pod

#### Create the GPU Test Pod Config

```
cat > gpu-test-pod.yaml << EOF
apiVersion: v1
kind: Pod
metadata:
  name: gpu-pod
spec:
  restartPolicy: Never
  runtimeClassName: nvidia
  containers:
    - name: cuda-container
    # Nvidia cuda compatibility https://docs.nvidia.com/deploy/cuda-compatibility/
    # for nvidia 510 drivers
    ## image: nvcr.io/nvidia/k8s/cuda-sample:vectoradd-cuda10.2
    # for nvidia 525 drivers use below image
      image: nvcr.io/nvidia/k8s/cuda-sample:vectoradd-cuda11.6.0
      resources:
        limits:
          nvidia.com/gpu: 1 # requesting 1 GPU
  tolerations:
  - key: nvidia.com/gpu
    operator: Exists
    effect: NoSchedule
EOF
```

#### Apply the GPU Test Pod Config

```
kubectl apply -f gpu-test-pod.yaml
```

## Verification of GPU Pod

```
kubectl logs gpu-pod
```

#### Expected/Example Output

```
root@node1:~# kubectl logs gpu-pod
[Vector addition of 50000 elements]
Copy input data from the host memory to the CUDA device
CUDA kernel launch with 196 blocks of 256 threads
Copy output data from the CUDA device to the host memory
Test PASSED
Done
```
