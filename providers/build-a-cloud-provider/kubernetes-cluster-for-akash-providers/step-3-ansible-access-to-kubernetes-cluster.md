# STEP 3 - Ansible Access to Kubernetes Cluster

Ansible will configure the Kubernetes hosts via SSH.  The user Ansible connects with must be root or have the capability of escalating privileges to root.

Commands in this step provide an example set up of SSH access to Kubernetes hosts and testing those connections.

## **Create SSH Keys on Ansible Host**

* Accept the defaults to create a public-private key pair

```
ssh-keygen -t rsa -C $(hostname) -f "$HOME/.ssh/id_rsa" -P "" ; cat ~/.ssh/id_rsa.pub
```

### **Confirm SSH Keys**

* The keys will be stored in the user’s home directory
* Use these commands to verify keys

```
cd ~/.ssh ; ls
```

#### **Example files created**

```
authorized_keys  id_rsa  id_rsa.pub
```

## **Copy Public Key to the Kubernetes Hosts**

### **Template**

```
ssh-copy-id -i ~/.ssh/id_rsa.pub <username>@<ip-address>
```

### **Example**

* Conduct this step for every Kubernetes master and worker node in the cluster

```
ssh-copy-id -i ~/.ssh/id_rsa.pub root@10.88.94.5
```

## **Confirm SSH to the Kubernetes Hosts**

* Ansible should be able to access all **** Kubernetes hosts with no password

### **Template**

```
ssh -i ~/.ssh/id_rsa <username>@<ip-address>
```

### **Example**

* Conduct this access test for every Kubernetes master and worker node in the cluster

```
ssh -i ~/.ssh/id_rsa root@10.88.94.5
```
