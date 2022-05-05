# STEP 2 - Install Ansible

When you launch Kubespray it will use an Ansible playbook to deploy a Kubernetes cluster.  In this step we will install Ansible.

Depending on your operating system it may be necessary to install OS patches, pip3, and virtualenv.  Example steps for a Ubuntu OS are detailed below.

```
apt-get update ; apt-get install -y python3-pip virtualenv
```

Within the kubespray directory use the following commands for the purpose of:

* Opening a Python virtual environment for the Ansible install
* Installing Ansible and other necessary packages specified in the requirements.txt file

```
virtualenv --python=python3 venv

source venv/bin/activate

rm requirements.txt

cat > requirements.txt << 'EOF'
ansible==4.8.0
ansible-core==2.11.6
cryptography==2.8
jinja2==2.11.3
netaddr==0.7.19
pbr==5.4.4
jmespath==0.9.5
ruamel.yaml==0.16.10
ruamel.yaml.clib==0.2.6
MarkupSafe==1.1.1
EOF

pip3 install -r requirements.txt
```
