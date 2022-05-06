# STEP 6 - Create Kubernetes Cluster

## Ubuntu DNS Resolution

If you are deploying Kubernetes on Ubuntu 22.04 (impish) systems, then make sure to add this DNS resolution fix to support Ubuntu 22.04 (impish) releases.

```
cp ~/kubespray/roles/kubernetes/node/vars/ubuntu-20.yml ~/kubespray/roles/kubernetes/node/vars/ubuntu-22.yml
```

## Create Cluster

With inventory in place we are ready to build the Kubernetes cluster via Ansible.

* Note - the cluster creation may take several minutes to complete
* If the Kubespray process fails or is interpreted, run the Ansible playbook again and it will complete any incomplete steps on the subsequent run

```
cd ~/kubespray

ansible-playbook -i inventory/akash/hosts.yaml -b -v --private-key=~/.ssh/id_rsa cluster.yml
```
