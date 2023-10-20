# STEP 8 - Create Kubernetes Cluster

## Create Cluster

With inventory in place we are ready to build the Kubernetes cluster via Ansible.

* Note - the cluster creation may take several minutes to complete
* If the Kubespray process fails or is interpreted, run the Ansible playbook again and it will complete any incomplete steps on the subsequent run

> _**NOTE**_ - if you intend to enable GPU resources on your provider - consider completing this [step](../../../other-resources/experimental/build-a-cloud-provider/gpu-resource-enablement-optional-step/gpu-provider-configuration.md) now to avoid having to run Kubespray on multiple occasions.  Only the `NVIDIA Runtime Configuration` section of the `GPU Resource Enablement` guide should be completed at this time and then return to this guide/step.

```
cd ~/kubespray

ansible-playbook -i inventory/akash/hosts.yaml -b -v --private-key=~/.ssh/id_rsa cluster.yml
```
