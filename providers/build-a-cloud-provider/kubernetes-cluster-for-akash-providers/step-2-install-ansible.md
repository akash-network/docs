# STEP 2 - Install Ansible



> _**NOTE**_ - the commands in this section and in all remaining sections of this guide assume that the `root` user is used.  For ease we suggest using the `root` user for the Kubernetes and Akash Provider install.  If a non-root user is used instead, minor command adjustments may be necessary such as using `sudo` command prefixes and updating the home directory in command syntaxes.

When you launch Kubespray it will use an Ansible playbook to deploy a Kubernetes cluster.  In this step we will install Ansible.

Depending on your operating system it may be necessary to install OS patches, pip3, and virtualenv.  Example steps for a Ubuntu OS are detailed below.

```
apt-get update ; apt-get install -y python3-pip virtualenv
```

Within the kubespray directory use the following commands for the purpose of:

* Opening a Python virtual environment for the Ansible install
* Installing Ansible and other necessary packages specified in the requirements.txt file
* Please remember to `cd kubespray` AND `source venv/bin/activate` - as detailed in the code block below - each time you want to use the  `ansible-playbook` commands in upcoming sections. &#x20;

```
cd ~/kubespray

virtualenv --python=python3 venv

source venv/bin/activate

pip3 install -r requirements.txt
```
