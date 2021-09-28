# Build a Cloud Provider

## **Prerequisites of an Akash Provider**

Prior to reviewing and completing the implementation steps of an Akash Provider environment consider the following mandates.

Prior to reviewing and completing the implementation steps of an Akash Provider environment consider the following mandates.

#### **Wallet Funding Requirement - Minimum of 50 AKT**

An associated, available wallet must have sufficient funding, as placing a bid on an order on the blockchain requires a 50 AKT deposit. This deposit is fully refunded after the bid is won/lost.

* * The precise minimum funding requirement of the wallet is marginally greater than 50 AKT as tiny amounts \(about 0.001\) of AKT is utilized by the Akash provider to commit transactions on the Akash blockchain.
  * Reference [https://docs.akash.network/guides/funding](https://docs.akash.network/guides/funding)  as a purchasing guide of AKT and[ https://docs.akash.network/guides/deploy](https://docs.akash.network/guides/deploy) Akash CLI wallet install.
* An associated, available wallet must have sufficient funding, as placing a bid on an order on the blockchain requires a 50 AKT deposit. This deposit is fully refunded after the bid is won/lost.
  * The precise minimum funding requirement of the wallet is marginally greater than 50 AKT as tiny amounts \(about 0.001\) of AKT is utilized by the Akash provider to commit transactions on the Akash blockchain.
  * Reference [https://docs.akash.network/guides/funding](https://docs.akash.network/guides/funding)  as a purchasing guide of AKT and[ https://docs.akash.network/guides/deploy](https://docs.akash.network/guides/deploy) Akash CLI wallet install.

_**Compute Resources Powering the Provider’s Kubernetes Cluster**_

* The compute resources hosting the provider’s Kubernetes cluster - on which tenants deploy workloads - should be x86-64 software capable.
* The provider must provision a full Kubernetes cluster.  This guide provides possible techniques and configuration of an appropriate cluster.
* As detailed subsequently the  recommended method for provisioning the cluster is via the utilization of the kubespray project. 
* The cluster must have access to the internet and be accessible from the internet.

_**Compute Resource to Host the Akash Provider Service**_

* The Akash provider service foundationally listens for events on the Akash blockchain and responds to those events by offering available compute resources in the provider’s own Kubernetes cluster. 
* The provider service must be accessible from the internet and have an associated hostname. When a provider/tenant lease is created, the tenant of the lease communicates directly with the provider detailing precise instructions/requirements of the desired workload deployment and thus requires a direct communication path.

**Access to an Akash blockchain RPC node**

#### **Compute Resources Powering the Provider’s Kubernetes Cluster**

* The compute resources hosting the provider’s Kubernetes cluster - on which tenants deploy workloads - should be x86-64 software capable.
* The provider must provision a full Kubernetes cluster.  This guide provides possible techniques and configuration of an appropriate cluster.
* As detailed subsequently the  recommended method for provisioning the cluster is via the utilization of the kubespray project. 
* The cluster must have access to the internet and be accessible from the internet.

#### **Compute Resource to Host the Akash Provider Service**

* The provider requires access to a Remote Procedure Call \(RPC\) node on the Akash network as the  provider does not directly participate in the blockchain network. 
* The provider utilizes an external RPC node to manage all interaction with the blockchain. 
* Any accessible RPC node in the Akash network may be utilized. 
* All Akash providers are strongly recommended to run a node on the Akash network co-located with the provider for a reduced communication path and reduced round trip communication delay. The node need not act as a validator. Multiple providers may access a single RPC node.

## **Kubernetes Cluster Setup**

* The Akash provider service foundationally listens for events on the Akash blockchain and responds to those events by offering available compute resources in the provider’s own Kubernetes cluster. 
* The provider service must be accessible from the internet and have an associated hostname. When a provider/tenant lease is created, the tenant of the lease communicates directly with the provider detailing precise instructions/requirements of the desired workload deployment and thus requires a direct communication path.

#### **Access to an Akash blockchain RPC node**

### **Overview**

* The provider requires access to a Remote Procedure Call \(RPC\) node on the Akash network as the  provider does not directly participate in the blockchain network. 
* The provider utilizes an external RPC node to manage all interaction with the blockchain. 
* Any accessible RPC node in the Akash network may be utilized. 
* All Akash providers are strongly recommended to run a node on the Akash network co-located with the provider for a reduced communication path and reduced round trip communication delay. The node need not act as a validator. Multiple providers may access a single RPC node.

## **Kubernetes Cluster Setup**

### **Overview**

Akash workloads are deployed as Kubernetes pods as desperate clusters owned, managed, and maintained by the provider.  As the foundational element of the provider network the guide commences with the build of the provider’s Kubernetes control plane and worker nodes.

Akash workloads are deployed as Kubernetes pods as desperate clusters owned, managed, and maintained by the provider.  As the foundational element of the provider network the guide commences with the build of the provider’s Kubernetes control plane and worker nodes.

The setup of a Kubernetes cluster is the responsibility of the provider on the Akash network. This section of this document provides best practices and recommendations for setting up a Kubernetes cluster. This document is not a comprehensive guide to operating a Kubernetes cluster and assumes pre-existing Kubernetes knowledge and experience.

The setup of a Kubernetes cluster is the responsibility of the provider on the Akash network. This section of this document provides best practices and recommendations for setting up a Kubernetes cluster. This document is not a comprehensive guide to operating a Kubernetes cluster and assumes pre-existing Kubernetes knowledge and experience.  
****

### **Kubernetes Cluster Creation and Configuration Steps**

### **Kubernetes Cluster Creation and Configuration Steps**

Individual sections following offer guidance in the configuration of a Kubernetes cluster - prepared appropriately to offer Akash provider services - within the following framework and steps.

Individual sections following offer guidance in the configuration of a Kubernetes cluster - prepared appropriately to offer Akash provider services - within the following framework and steps.

The Kubernetes cluster deployment described in these steps utilize Kubespray to deploy the control plane and worker nodes.

The Kubernetes cluster deployment described in these steps utilize Kubespray to deploy the control plane and worker nodes.

**STEP1**:  Clone the Kubespray project

**STEP1**: Clone the Kubespray project

**STEP2**:  Install Ansible and configure Ansible inventory for the nodes in the cluster

**STEP2**: Install Ansible and configure Ansible inventory for the nodes in the cluster

**STEP3**:  Invoke the Kubernetes cluster provisioning using Ansible

**STEP3**: Invoke the Kubernetes cluster provisioning using Ansible

**STEP4**:  Add Akash's Custom Resource Definitions to Kubernetes

**STEP4**: Add Akash's Custom Resource Definitions to Kubernetes

**STEP5**:  Add a NGINX Ingress controller in the Kubernetes cluster for Akash

**STEP5**: Add a NGINX Ingress controller in the Kubernetes cluster for Akash  
****

With the conclusion of the aforementioned steps a Kubernetes cluster will be readied to assume the role of an Akash provider additional steps - provided in detail in a subsequent section of this document - are necessary to configure the provider and place onto the Akash network.

With the conclusion of the aforementioned steps a Kubernetes cluster will be readied to assume the role of an Akash provider additional steps - provided in detail in a subsequent section of this document - are necessary to configure the provider and place onto the Akash network.  
****

The subsections that follow deep dive into the referenced Kubernetes cluster creation step in detail and within an ordered methodology.

The subsections that follow deep dive into the referenced Kubernetes cluster creation step in detail and within an ordered methodology.  
****

### **Clone the Kubespray project**

### **Clone the Kubespray project**

#### **Cluster Creation Recommendations**

_**Cluster Creation Recommendations**_

The recommended method for setting up a Kubernetes cluster for Akash provider use is via the[ Kubespray](https://github.com/kubernetes-sigs/kubespray) project. A collection of ansible resources is provoked by Kubespray allowing Kubernetes cluster deployment with a minimized effort.

The recommended method for setting up a Kubernetes cluster for Akash provider use is via the[ Kubespray](https://github.com/kubernetes-sigs/kubespray) project. A collection of Ansible resources is provoked by Kubespray allowing Kubernetes cluster deployment with a minimized effort.

The recommended minimum number of compute nodes is three in the following footprint:

The recommended minimum number of compute nodes is three in the following footprint:

* One host maintains the role of  the Kubernetes master node & provider
* One host that serves as a redundant master node
* One host which facilitates the role of Kubernetes worker nodes and host deployed workloads triggered via the Akash provider

For experimentation and initial exposure it is possible to provision a single host Kubernetes cluster - control-plane, worker node, and Akash provider collapsed on a single node - but this configuration is not recommended for production usage.

* One host maintains the role of  the Kubernetes master node & provider
* One host that serves as a redundant master node
* One host which facilitates the role of Kubernetes worker nodes and host deployed workloads triggered via the Akash provider

For experimentation and initial exposure it is possible to provision a single host Kubernetes cluster - control-plane, worker node, and Akash provider collapsed on a single node - but this configuration is not recommended for production usage.

#### **Provoke Kubespray Project Clone**

Initiate the following commands to obtain Kubespray and navigate into the created local directory for subsequent steps readiness.

_Provoke Kubespray Project Clone_

Kubespray should be installed on a machine that has connectivity to the three hosts that will serve as the Kubernetes cluster.

Initiate the following commands to obtain Kubespray and navigate into the created local directory for subsequent steps readiness.

```text
git clone https://github.com/kubernetes-sigs/kubespray.git

cd kubespray
```

### **Install Ansible and configure Ansible inventory for the nodes in the cluster**

#### **Ansible Installation**

Kubespray utilized Ansible during Kubernetes cluster deployment and thus an Ansible installation serves as our next step.  Python version 3 and the associated PIP3 package management system will facilitate Ansible installation. 

Kubespray should be installed on a machine that has connectivity to the three hosts that will serve as the Kubernetes cluster.

The required Ansible version and additional/required Python dependencies are specified in a requirements.txt file which were pulled during the Kubespray clone and reside in the “kubespray” directory.  Recommendation would be to install Ansible and dependencies within a Python virtual environment created via the virtualenv tool and such techniques are included in scripted steps that follow.

```text
git clone 
https://github.com/kubernetes-sigs/kubespray.git

cd kubespray
```

### **Install Ansible and configure Ansible inventory for the nodes in the cluster**

_**Ansible Installation**_

* Note - depending on your operating system it may be necessary to update the OS, install pip3, and then install virtualenv prior to the primary steps in the section.  Example readiness commands are listed below in a “Optional Precursor Steps” outline.  _The example steps would be specifically relevant to an Ubuntu OS._

#### **Optional  Precursor Steps**

```text
sudo apt-get update

sudo apt-get install -y python3-pip

sudo apt install virtualenv
```

#### **Execute Commands Within kubespray Directory**

```text
virtualenv --python=python3 venv

source venv/bin/activate

pip3 install -r requirements.txt
```

#### **Ensuring Ansible Access of Intended Kubernetes Nodes**       

Ansible provokes remote host configuration via SSH. Each node in the intended Kubernetes cluster must be accessible by the Ansible host using SSH. The SSH user which connects remotely to Kubernetes host’s be root or is capable of escalating privileges to root using the sudo command.

Kubespray utilized Ansible during Kubernetes cluster deployment and thus an Ansible installation serves as our next step.  Python version 3 and the associated PIP3 package management system will facilitate Ansible installation. 

If you need to copy your SSH private key to the nodes you can do so using the ssh-copy-id command on most Linux machines.

The required Ansible version and additional/required Python dependencies are specified in a requirements.txt file which were pulled during the Kubespray clone and reside in the “kubespray” directory.  Recommendation would be to install Ansible and dependencies within a Python virtual environment created via the virtualenv tool and such techniques are included in scripted steps that follow.

_Conduct Following Steps on the Ansible Host_

* Note - depending on your operating system it may be necessary to update the OS, install pip3, and then install virtualenv prior to the primary steps in the section.  Example readiness commands are listed below in a “Optional Precursor Steps” outline.  The example steps would be specifically relevant to an Ubuntu OS.
* Generate a SSH public/private key pair.  Accept default naming convention to generate keys as the “id\_rsa” naming convention or change to a naming convention of your choice and then alter the steps that follow accordingly.

_Optional_ _Precursor_ _Steps_

```text
ssh-keygen
```

_Copy the Newly Generated Public Key to the Kubernetes Hosts \(Example Shown\)_ 

```text
sudo apt-get update

sudo apt-get install -y python3-pip

sudo apt install virtualenv
```

_Execute Commands Within kubespray Directory_

* Upon successful execution of this command a message should be received stating “Number of key\(s\) added” and instruction on how to test connection
* Enter password when prompted

```text
ssh-copy-id -i ~/.ssh/id_rsa root@10.0.10.27
```

_Test Connection Example_

```text
virtualenv --python=python3 venv

source venv/bin/activate

pip3 install -r requirements.txt
```

_**Ensuring Ansible Access of Intended Kubernetes Nodes**_       

* Execution should result in a SSH session established to the remote host without the need of password entry

```text
ssh-copy-id -i ~/.ssh/id_rsa root@10.0.10.27
```

_Repeat Steps Above for SSH Connections to all Kubernetes Hosts from Ansible Host_  


Ansible provokes remote host configuration via SSH. Each node in the intended Kubernetes cluster must be accessible by the Ansible host using SSH. The SSH user which connects remotely to Kubernetes host’s be root or is capable of escalating privileges to root using the sudo command.

#### **Ansible Inventory Configuration**   

Inventory file population will dictate the hosts in the Kubernetes cluster Ansible will attempt to configure . Inventory configuration files for Ansible may be created in multiple formats.  This guide will focus on inventory definition via a YAML file. 

If you need to copy your SSH private key to the nodes you can do so using the ssh-copy-id command on most Linux machines.

Example YAML inventory definitions are provided subsequently pertaining to the following scenarios:

_Conduct Following Steps on the Ansible Host_

* Single node Kubernetes cluster
* Multiple node Kubernetes cluster \(two masters and one worker node\)

Utilize only the scenario and associated YAML definition file relevant to your desired topology.  


#### **Single Node Kubernetes Cluster \(Not Recommended for Production Use\)**

* Execute the following commands to configure the Ansible inventory
* Explanation of commands in order provided:
  * Within the kubespray directory an inventory/sample directory containing variables and ini files used by Ansible for inventory purposes exist.  The sample directory is copied into a custom directory.
  * An IPS variable is declared with a list of IP addresses for the Ansible inventory \(in this case only a single address\)
  * A Python inventory builder script is called with a reference to the IP address list for injection into the script

_Execute Commands within the “kubespray” Directory_

* Generate a SSH public/private key pair. Accept default naming convention to generate keys as the “id\_rsa” naming convention or change to a naming convention of your choice and then alter the steps that follow accordingly.

```text
ssh-keygen
```

```text
cp -rfp inventory/sample inventory/akash

###Replace IP address with Kubernetes node address in your environment
declare -a IPS=(10.0.10.88)
CONFIG_FILE=inventory/akash/hosts.yaml python3 contrib/inventory_builder/inventory.py ${IPS[@]}
```

_Copy the Newly Generated Public Key to the Kubernetes Hosts \(Example Shown\)_ 

* Following the successful execution of the above commands the referenced hosts.yaml file will be created within the kubespray/inventory/akash directory 

_Manual Edits/Insertions of the hosts.yaml Inventory File_

* Upon successful execution of this command a message should be received stating “Number of key\(s\) added” and instruction on how to test connection
* Enter password when prompted

```text
ssh-copy-id -i ~/.ssh/id_rsa root@10.0.10.27
```

_Test Connection Example_

* Execution should result in a SSH session established to the remote host without the need of password entry

```text
ssh -i ~/.ssh/id_rsa root@10.0.10.27
```

_Repeat Steps Above for SSH Connections to all Kubernetes Hosts from Ansible Host_

* The following instructions facilitate necessary additions to the Ansible Inventory file

_Execute Commands within the “kubespray” Directory_

```text
cd inventory/akash
```

* Open the hosts.yaml file in VI \(Visual Editor\) or nano to make the following file updates to the hosts.yaml file
* Within the YAML file’s “all” stanza and prior to the “hosts” sub-stanza level and at prior to the “hosts” sub-stanza level - insert the following vars stanza
* Reference the full YAML file depiction provided subsequently in this section to ensure proper placement and indentation

```text
vars:
  cluster_id: "1.0.0.1"
  ansible_user: root
  gvisor_enabled: true
```

**Granular Review of Ansible Inventory File Elements and Associated Function** 

_**Ansible Inventory Configuration**_   

The Ansible inventory file associated with the single node Kubernetes implementation defines the node as a host named node1. 

Inventory file population will dictate the hosts in the Kubernetes cluster Ansible will attempt to configure . Inventory configuration files for Ansible may be created in multiple formats.  This guide will focus on inventory definition via a YAML file. 

* The node1 name is internally assigned by Ansible to the node. The value specified in the key ansible\_host  under the node name defines how the host is reached by Ansible. In this example the node's IP address is utilized but a hostname may be used alternatively.
* The host is placed into the groups of kube\_control\_plane, kube\_node, etcd, and calico-rr. All hosts in those groups are then placed into the k8s\_cluster group. This is similar to a standard configuration for a Kubernetes cluster.
* The Calico CNI is the only networking solution for Kubernetes clusters officially supported by Akash at this time.

_Calico Container Network Interface \(CNI\) Detail_

Example YAML inventory definitions are provided subsequently pertaining to the following scenarios:

* One important detail is the value cluster\_id which is assigned to all nodes by using the all group under vars in the YAML file.
* This value is used by Calico to uniquely identify a set of resources. 
* For a more in depth explanation[ see this document](https://hub.docker.com/r/calico/routereflector/).

_Completed/Expected Ansible Inventory File_

* Single node Kubernetes cluster
* Multiple node Kubernetes cluster \(two masters and one worker node\)

Utilize only the scenario and associated YAML definition file relevant to your desired topology.

![](https://lh3.googleusercontent.com/mccuNWwCKcPouAX8CgEvFxrY3UUnQo4L-t8LKIpZvrRNvjz-rEoax1fK2ZWw3tf1yFAjGJxt70UV7EDHNxJtINLjggLLzXyg4NlpZ68Aeq7wUFKdNWfHHi_VbimbW2XaPW2abRwB=s0)



#### **Single Node Kubernetes Cluster \(Not Recommended for Production Use\)**

* Execute the following commands to configure the Ansible inventory
* Explanation of commands in order provided:
  * Within the kubespray directory an inventory/sample directory containing variables and ini files used by Ansible for inventory purposes exist.  The sample directory is copied into a custom directory.
  * An IPS variable is declared with a list of IP addresses for the Ansible inventory \(in this case only a single address\)
  * A Python inventory builder script is called with a reference to the IP address list for injection into the script
* Execute Commands within the “kubespray” Directory

```text
cp -rfp inventory/sample inventory/akash

#Replace IP address with Kubernetes node address in your environment
declare -a IPS=(10.0.10.88)

CONFIG_FILE=inventory/akash/hosts.yaml python3 contrib/inventory_builder/inventory.py ${IPS[@]}
```

* Following the successful execution of the above commands the referenced hosts.yaml file will be created within the kubespray/inventory/akash directory 

_Manual Edits/Insertions of the hosts.yaml Inventory File_  


#### **Multiple Node Kubernetes Cluster**                               

* Execute the following commands to configure the Ansible inventory
* Explanation of commands in order provided:
  * Within the kubespray directory an inventory/sample directory containing variables and ini files used by Ansible for inventory purposes exist.  The sample directory is copied into a custom directory.
  * An IPS variable is declared with a list of IP addresses for the Ansible inventory \(in this case three addresses\)
  * A Python inventory builder script is called with a reference to the IP address list for injection into the script

_Execute Commands within the “kubespray” Directory_  


```text
cp -rfp inventory/sample inventory/akash

###Replace IP address with Kubernetes node addresses in your environment

declare -a IPS=(10.0.10.27 10.0.10.113 10.0.10.132)

CONFIG_FILE=inventory/akash/hosts.yaml python3 contrib/inventory_builder/inventory.py ${IPS[@]}
```

* Following the successful execution of the above commands the referenced hosts.yaml file will be created within the kubespray/inventory/akash directory

_Manual Edits/Insertions of the hosts.yaml Inventory File_

* **The** following **instructions facilitate necessary additions to the Ansible Inventory file**

<table>
  <thead>
    <tr>
      <th style="text-align:left">
        <p><b>Execute Commands within the &#x201C;kubespray&#x201D; Directory<br /></b>
        </p>
        <p><b>cd inventory/akash<br /></b>
        </p>
        <ul>
          <li>Open the hosts.yaml file in VI (Visual Editor) or nano to make the following
            file updates to the hosts.yaml file</li>
          <li>Within the YAML file&#x2019;s &#x201C;all&#x201D; stanza and prior to
            the &#x201C;hosts&#x201D; sub-stanza level and at prior to the &#x201C;hosts&#x201D;
            sub-stanza level - insert the following vars stanza</li>
          <li>Reference the full YAML file depiction provided subsequently in this section
            to ensure proper placement and indentation</li>
        </ul>
        <p></p>
        <p><b>vars:</b>
        </p>
        <p><b>  cluster_id: &quot;1.0.0.1&quot;</b>
        </p>
        <p><b>  ansible_user: root</b>
        </p>
        <p><b>  gvisor_enabled: true</b>
        </p>
      </th>
    </tr>
  </thead>
  <tbody></tbody>
</table>

**Granular Review of Ansible Inventory File Elements and Associated Function** 

* The following instructions facilitate necessary additions to the Ansible Inventory file

_Execute Commands within the “kubespray” Directory_

* The Ansible inventory file associated with the single node Kubernetes implementation defines the node as a host named node1. 
* The node1 name is internally assigned by Ansible to the node. The value specified in the key ansible\_host  under the node name defines how the host is reached by Ansible. In this example the node's IP address is utilized but a hostname may be used alternatively.
* The host is placed into the groups of kube\_control\_plane, kube\_node, etcd, and calico-rr. All hosts in those groups are then placed into the k8s\_cluster group. This is similar to a standard configuration for a Kubernetes cluster.
* The Calico CNI is the only networking solution for Kubernetes clusters officially supported by Akash at this time.

**Calico Container Network Interface \(CNI\) Detail**

* One important detail is the value cluster\_id which is assigned to all nodes by using the all group under vars in the YAML file.
* This value is used by Calico to uniquely identify a set of resources. 
* For a more in depth explanation[ see this document](https://hub.docker.com/r/calico/routereflector/).

**Completed/Expected Ansible Inventory File**  


```text
cd inventory/akash
```

![](https://lh3.googleusercontent.com/QlP526rad_URtIGa290z7tINI5YLjP0Wk8pIeBGKzF6pJkPHsry2Uor6JnHFltzTHIJNaMyQU4BAHC4yrVt2KPmkWkviNjtQWrIcfUckT9-2wOYmDyMA4AzKzU6kDnRNutZD9sHu=s0)

#### **Multiple Node Kubernetes Cluster**                               

* Execute the following commands to configure the Ansible inventory
* Explanation of commands in order provided:
  * Within the kubespray directory an inventory/sample directory containing variables and ini files used by Ansible for inventory purposes exist.  The sample directory is copied into a custom directory.
  * An IPS variable is declared with a list of IP addresses for the Ansible inventory \(in this case three addresses\)
  * A Python inventory builder script is called with a reference to the IP address list for injection into the script

<table>
  <thead>
    <tr>
      <th style="text-align:left">
        <p><b>Execute Commands within the &#x201C;kubespray&#x201D; Directory<br /></b>
        </p>
        <p><b>cp -rfp inventory/sample inventory/akash<br /></b>
        </p>
        <ul>
          <li>Replace IP address with Kubernetes node addresses in your environment</li>
        </ul>
        <p><b>declare -a IPS=(10.0.10.27 10.0.10.113 10.0.10.132)<br /></b>
        </p>
        <p><b>CONFIG_FILE=inventory/akash/hosts.yaml python3 contrib/inventory_builder/inventory.py ${IPS[@]}<br /></b>
        </p>
      </th>
    </tr>
  </thead>
  <tbody></tbody>
</table>

* Following the successful execution of the above commands the referenced hosts.yaml file will be created within the kubespray/inventory/akash directory 

**Manual Edits/Insertions of the hosts.yaml Inventory File**

* Open the hosts.yaml file in VI \(Visual Editor\) or nano to make the following file updates to the hosts.yaml file
* Within the YAML file’s “all” stanza and prior to the “hosts” sub-stanza level and at prior to the “hosts” sub-stanza level - insert the following vars stanza
* Reference the full YAML file depiction provided subsequently in this section to ensure proper placement and indentation

```text
vars:
  cluster_id: "1.0.0.1"
  ansible_user: root
  gvisor_enabled: true
```

_Granular Review of Ansible Inventory File Elements and Associated Function_ 

* The multiple node Kubernetes cluster’s Ansible YAML file example defines 3 separate hosts node1, node2, and node3.
* The node names \(node1, node2, node3\) are internally assigned by Ansible. The value specified in the key ansible\_host under each node name defines how the host is reached by Ansible. In this example the node's IP address is utilized but a hostname may be used alternatively.

![](https://lh4.googleusercontent.com/8XFo2vthPA2ul6nuYtiGxqXShNT5e4IcfC-lK4ZYjQD4hdnqG0vUH9rbRlMSiyyRsUcuOwH48F_hbM30fI25U3ZcWPOnJXBQWxK0SmhYpTXHPuhBGtVINbuo7ZzGsGv-JXLH_MOH=s0)



#### **Enablement of gVisor**

* The following activities are applicable to both the single and multiple node Kubernetes implementation scenarios
* The gvisor\_enabled key has been set to true in the kubespray inventory file within the vars stanza
* Enablement of [ gVisor](https://gvisor.dev/) support limits the attack surface of the host
* gVisor requires the containerd container engine
* Modify k8s-cluster.yml and etcd.yml files to enable gVisor per the steps that follow

_From the kubespray directory:_

```text
cd inventory/akash/group_vars/k8s_cluster
```

* The following instructions facilitate necessary additions to the Ansible Inventory file

<table>
  <thead>
    <tr>
      <th style="text-align:left">
        <p><b>Execute Commands within the &#x201C;kubespray&#x201D; Directory<br /></b>
        </p>
        <p><b>cd inventory/akash<br /></b>
        </p>
        <ul>
          <li>Open the hosts.yaml file in VI (Visual Editor) or nano to make the following
            file updates to the hosts.yaml file</li>
          <li>Within the YAML file&#x2019;s &#x201C;all&#x201D; stanza and prior to
            the &#x201C;hosts&#x201D; sub-stanza level and at prior to the &#x201C;hosts&#x201D;
            sub-stanza level - insert the following vars stanza</li>
          <li>Reference the full YAML file depiction provided subsequently in this section
            to ensure proper placement and indentation</li>
        </ul>
        <p><b>vars:</b>
        </p>
        <p><b>  cluster_id: &quot;1.0.0.1&quot;</b>
        </p>
        <p><b>  ansible_user: root</b>
        </p>
        <p><b>  gvisor_enabled: true</b>
        </p>
      </th>
    </tr>
  </thead>
  <tbody></tbody>
</table>

**Granular Review of Ansible Inventory File Elements and Associated Function** 

_Using VI or nano update the k8s-cluster.yml file with the following key-value pair to the value below_

```text
container_manager: containerd
```

_From the kubespray directory:_

```text
cd inventory/akash/group_vars
```

_Using VI or nano update the etcd.yml file with the following key-value pair to the value below_

* The multiple node Kubernetes cluster’s Ansible YAML file example defines 3 separate hosts node1, node2, and node3.
* The node names \(node1, node2, node3\) are internally assigned by Ansible. The value specified in the key ansible\_host under each node name defines how the host is reached by Ansible. In this example the node's IP address is utilized but a hostname may be used alternatively.

![](https://lh4.googleusercontent.com/EiDdS3Ohz308BzRnOAYNRRmHGgH87DhYLe2bnLqhIyVKSj__ZJr-Rerr6D6kx2RyDDEcxT5E1m9jJHaBiGuPjvVjn6FzRWvJm9ctRgXyQoBPeXX15Z9QfnYM3mvbNkX8T8anWxBm=s0)

#### **Enablement of gVisor**

```text
etcd_deployment_type: host
```

### **Invoke the Kubernetes cluster provisioning using Ansible**

* The following activities are applicable to both the single and multiple node Kubernetes implementation scenarios
* The gvisor\_enabled key has been set to true in the kubespray inventory file within the vars stanza
* Enablement of [ gVisor](https://gvisor.dev/) support limits the attack surface of the host
* gVisor requires the containerd container engine
* Modify k8s-cluster.yml and etcd.yml files to enable gVisor per the steps that follow

<table>
  <thead>
    <tr>
      <th style="text-align:left">
        <p><b>From the kubespray directory:<br /></b>
        </p>
        <p><b>cd inventory/akash/group_vars/k8s_cluster<br /></b>
        </p>
        <ul>
          <li>Using VI or nano update the k8s-cluster.yml file with the following key-value
            pair to the value below</li>
        </ul>
        <p><b>container_manager: containerd<br /></b>
        </p>
        <p><b>From the kubespray directory:<br /></b>
        </p>
        <p><b>cd inventory/akash/group_vars<br /></b>
        </p>
        <ul>
          <li>Using VI or nano update the etcd.yml file with the following key-value
            pair to the value below</li>
        </ul>
        <p><b>etcd_deployment_type: host</b>
        </p>
      </th>
    </tr>
  </thead>
  <tbody></tbody>
</table>

### **Invoke the Kubernetes cluster provisioning using Ansible**

#### **Cluster Build Primary Steps**

Assuming the Ansible inventory file has been created properly and placed within  inventory/akash/hosts.yaml - as detailed in preceding sections of this guide - the Kubernetes cluster build via Kubespray may commence via an Ansible playbook as per the instructions that follow.

**Notes regarding the ansible-playbook invoke**

* The --private-key option informs Ansible of the SSH private key to authenticate with. If a different private key was created and distributed to the hosts in the “Ensuring Ansible Access of Intended Kubernetes Nodes” section of this guide - update this parameter to point at the location of the private key used to access all hosts in the cluster.
* The Ansible playbook YAML file of cluster.yml contains all the necessary steps to build the Kubernetes cluster. 
* When the Kubernetes cluster build is completed by Ansible - the Kubernetes master node should have a  file stored at the location of /root/.kube/config which is used to connect to and authenticate with Kubernetes. Treat the file as a secret password and do not share. A copy of this file must be used to configure the Akash provider.

**Dense Provider Considerations**

Kubernetes utilizes a networking model which assigns a single, unique IP address to deployed pods. A node in the Kubernetes cluster manages a pool of available IP addresses for pod assignment. The node’s available IP address pool introduces a limit to the number of pods that may be hosted on that single node.

Providers hosting small nodes would have no pods per node limit concern as the default IP address pool should suffice for deployed workloads.  However providers running nodes with dense compute configurations \(I.e. multi-core CPU servers\) the address pool may become a limiting factor in utilization of the node in a scenario in which the number of pods that could be deployed is greater than the number of addresses in the pool.

To increase the pods per node limit, 3 steps should be taken:

Settings, key-value pairs detailed would exists and may be configured in the following file if following this deployment guide strictly:

 _****kubespray/inventory/akash/group\_vars/k8s\_cluster/k8s-cluster.yml_

1. Increase kube\_network\_node\_prefix to assign additional lIP addresses to the node pool available for pod assignment
2. Increase kube\_pods\_subnet to allow more pods in the kubernetes cluster
3. Increase kube\_service\_addresses as more services would be expected on the dense provider node instance

**Known Kubespray Issues**

* **Kubespray will utilize Calico for Kubernetes in this deployment.** 
* **An extremely common error encountered involves Kubespray failing on a step in which a script named calioctl.sh is executed.** 
* **The issue appears to be a bug in Kubespray. The only solution known at this time is to wait approximately 3 minutes and then rerun Kubespray. On the second execution, Kubespray will complete successfully.**

**Execution of Kubernetes Cluster Build via Kubespray**

<table>
  <thead>
    <tr>
      <th style="text-align:left">
        <p><b>From the kubespray directory execute the following command<br /></b>
        </p>
        <ul>
          <li>Note - completion of this execution will span several minutes</li>
        </ul>
        <p><b>ansible-playbook -i inventory/akash/hosts.yaml -b -v --private-key=~/.ssh/id_rsa cluster.yml</b>
        </p>
      </th>
    </tr>
  </thead>
  <tbody></tbody>
</table>

**Validation of Kubernetes Cluster Installation**  


<table>
  <thead>
    <tr>
      <th style="text-align:left">
        <p><b>Kubectl commands may be run from a Kubernetes control-plane server or from a local origination point with context configured<br /></b>
        </p>
        <p><b>kubectl get nodes<br /></b>
        </p>
        <p><b>kubectl get pods -n kube-system<br /></b>
        </p>
      </th>
    </tr>
  </thead>
  <tbody></tbody>
</table>

* Expected output
* Note  - the expected output example provided pertains to the multiple control-plane, work node scenario

#### **Cluster Build Primary Steps**

![](https://lh6.googleusercontent.com/I1HlVdf9m1cuifUdQF_MbZa3xDG-RpHKsZ3jmStRwQs047GBUg81pNxn-qyQQWN0jPW9wxbf583hukiPv2S1OV7Ma9Do1_ocTwN1c8PhysCu0uSrREiNVvi4ECKz8GE7t33mlGqs=s0)

### **Add Akash's Custom Resource Definitions to Kubernetes**

Assuming the Ansible inventory file has been created properly and placed within  inventory/akash/hosts.yaml - as detailed in preceding sections of this guide - the Kubernetes cluster build via Kubespray may commence via an Ansible playbook as per the instructions that follow.

#### **Cursory Steps to Allow Local Kubectl Communication to Cluster**

Assuming completion of a fully functional Kubernetes cluster based on prior execution steps, access a control-plane instance to complete the following capture.

* Navigate to the /root/.kube \(known as the “kubeconfig” file\) and open config using your preferred editor. 
* Ensure that the server field in this file is populated with the server’s IP \(including port number\).   Kubespray often incorrectly fills populates this with 127.0.0.1 \(localhost\) address.
* An example of the field’s value properly configured is depicted below \(output truncated to only include relevant capture.
* Save the file if edit was necessary.

_Notes regarding the ansible-playbook invoke_

* The --private-key option informs Ansible of the SSH private key to authenticate with. If a different private key was created and distributed to the hosts in the “Ensuring Ansible Access of Intended Kubernetes Nodes” section of this guide - update this parameter to point at the location of the private key used to access all hosts in the cluster.
* The Ansible playbook YAML file of cluster.yml contains all the necessary steps to build the Kubernetes cluster. 
* When the Kubernetes cluster build is completed by Ansible - the Kubernetes master node should have a  file stored at the location of /root/.kube/config which is used to connect to and authenticate with Kubernetes. Treat the file as a secret password and do not share. A copy of this file must be used to configure the Akash provider.

_Dense Provider Considerations_

Kubernetes utilizes a networking model which assigns a single, unique IP address to deployed pods. A node in the Kubernetes cluster manages a pool of available IP addresses for pod assignment. The node’s available IP address pool introduces a limit to the number of pods that may be hosted on that single node.

![](https://lh3.googleusercontent.com/ajGHXzmp1PCzxmIzyfjc-HBNsWylWP4qFMS9t6gVKZliOKgVjjTXCemVUX4ak2K-we_Y84APs0i28qtrOAUaDz89O8_itxCHIL9nELrRlu81cGs3EQAILeCoAxLsjrVxsQXBoRrP=s0)

Providers hosting small nodes would have no pods per node limit concern as the default IP address pool should suffice for deployed workloads.  However providers running nodes with dense compute configurations \(I.e. multi-core CPU servers\) the address pool may become a limiting factor in utilization of the node in a scenario in which the number of pods that could be deployed is greater than the number of addresses in the pool.

**Copy of kubeconfig file for local provoke of Custom Resource Definition build**

To increase the pods per node limit, 3 steps should be taken:

* Note - the following steps assume kubectl is installed on your local machine and will walk the user through the configuration of the context configuration to access the provider Kubernetes cluster.  For a through discussion of kubectl installation and use of the referenced environmental variable discussed below - please reference the following document:
  * [https://rancher.com/learning-paths/how-to-manage-kubernetes-with-kubectl](https://rancher.com/learning-paths/how-to-manage-kubernetes-with-kubectl)
* To allow creation of the Customer Resource Definition \(CRD\) the config file referenced/manipulated in the prior step will be copied from the Kubernetes master/control-plane instance to your local machine where the kubectl command shall be executed.
* Copy the entire content of the updated kubeconfig file from the master node \(file location - /root/.kube/config\)
* Save a copy of this file on your local machine.
* On your local machine set the KUBECONFIG environmental variable to the path of the config file saved locally.

Settings, key-value pairs detailed would exists and may be configured in the following file if following this deployment guide strictly:

#### **Creation of the Custom Resource Definition \(CRD\)**

*  kubespray/inventory/akash/group\_vars/k8s\_cluster/k8s-cluster.yml

Akash uses a Custom Resource Definition to store each deployment in Kubernetes. 

Increase kube\_network\_node\_prefix to assign additional lIP addresses to the node pool available for pod assignment

* To initiate the CRD creation in Kubernetes download the following file on your local machine
* Steps provided subsequently to both download and install the CRD

1. Increase kube\_pods\_subnet to allow more pods in the kubernetes cluster
2. Increase kube\_service\_addresses as more services would be expected on the dense provider node instance

[**https://raw.githubusercontent.com/ovrclk/akash/master/pkg/apis/akash.network/v1/crd.yaml**](https://raw.githubusercontent.com/ovrclk/akash/master/pkg/apis/akash.network/v1/crd.yaml)  
****

_Known Kubespray Issues_

<table>
  <thead>
    <tr>
      <th style="text-align:left">
        <ul>
          <li>Download the CRD YAML and apply/install the CRD into the Kubernetes cluster</li>
        </ul>
        <p><b>wget https://raw.githubusercontent.com/ovrclk/akash/master/pkg/apis/akash.network/v1/crd.yaml<br /></b>
        </p>
        <p><b>kubectl apply -f ./crd.yaml</b>
        </p>
      </th>
    </tr>
  </thead>
  <tbody></tbody>
</table>

* Kubespray will utilize Calico for Kubernetes in this deployment. 
* An extremely common error encountered involves Kubespray failing on a step in which a script named calioctl.sh is executed. 
* The issue appears to be a bug in Kubespray. The only solution known at this time is to wait approximately 3 minutes and then rerun Kubespray. On the second execution, Kubespray will complete successfully.

**Possible Error Condition Encountered During CRD Creation:**

_Execution of Kubernetes Cluster Build via Kubespray_

* If the following error is encountered - the KUBECONFIG environment variable is likely incorrectly configured

Error message - The connection to the server 127.0.0.1:34473 was refused - did you specify the right host or port?

### **Add a NGINX Ingress controller in the Kubernetes cluster for Akash**

#### **Akash Network Configuration Addition**

**Prerequisites**

Section assumes the steps detailed in the Akash CRD section for the kubeconfig file edit, copy, and local configuration have been completed  


**Network Configuration Overview**

Akash supplies a network configuration which must be applied to the Kubernetes cluster. The application of the network configuration will be accomplished by downloading the network policy YAML manifest and applying the manifest through kubectl from your local machine.

**Application of the Network Profile**

* To initiate the network profile creation in Kubernetes download the following file on your local machine
* Steps provided subsequently to both download and install the network profile

[**https://raw.githubusercontent.com/ovrclk/akash/master/\_docs/kustomize/networking/network-policy-default-ns-deny.yaml**](https://raw.githubusercontent.com/ovrclk/akash/master/_docs/kustomize/networking/network-policy-default-ns-deny.yaml)  
****

<table>
  <thead>
    <tr>
      <th style="text-align:left">
        <ul>
          <li><b>Download the YAML file and apply/install into the Kubernetes cluster</b>
          </li>
        </ul>
        <p><b>wget https://raw.githubusercontent.com/ovrclk/akash/master/_docs/kustomize/networking/network-policy-default-ns-deny.yaml<br /></b>
        </p>
        <p><b>kubectl apply -f ./network-policy-default-ns-deny.yaml<br /></b>
        </p>
      </th>
    </tr>
  </thead>
  <tbody></tbody>
</table>

#### **Akash Ingress Controller**

* From the kubespray directory execute the following command
* Note - completion of this execution will span several minutes

```text
ansible-playbook -i inventory/akash/hosts.yaml -b -v --private-key=~/.ssh/id_rsa cluster.yml
```

_Validation of Kubernetes Cluster Installation_

* Kubectl commands may be run from a Kubernetes control-plane server or from a local origination point with context configured

```text
kubectl get nodes

kubectl get pods -n kube-system
```

* Expected output
* Note  - the expected output example provided pertains to the multiple control-plane, work node scenario

![](https://lh5.googleusercontent.com/7N3gvr6Oajn3o_tGjPBtXAEJyzOWiVRxC9QVAOijtD3csMHOctY7n3nXoRWHA4q3Vl4p3RjOCtANHapDrpBKrM_gLU3YiSqsQHuKTPiAKziP3GiJHPVlPFWPbMffEEWdfxTnyg3W=s0)

### **Add Akash's Custom Resource Definitions to Kubernetes**

#### _Cursory Steps to Allow Local Kubectl Communication to Cluster_

Assuming completion of a fully functional Kubernetes cluster based on prior execution steps, access a control-plane instance to complete the following capture.

* Navigate to the /root/.kube \(known as the “kubeconfig” file\) and open config using your preferred editor. 
* Ensure that the server field in this file is populated with the server’s IP \(including port number\).   Kubespray often incorrectly fills populates this with 127.0.0.1 \(localhost\) address.
* An example of the field’s value properly configured is depicted below \(output truncated to only include relevant capture.
* Save the file if edit was necessary.

![](https://lh6.googleusercontent.com/bSXrIAnghE-blMvACqjMkfMWeISD6ObzaYJsCuXDxRjohcXToDqUqJQvafP0rDsLQbhHrlkgNY8MU4FacRP33yXdMr_2Oq6aVKziy4t85Q32roejWC2bZcOVk80LTUKqMUtMybXE=s0)

_Copy of kubeconfig file for local provoke of Custom Resource Definition build_

**Prerequisites**

* Note - the following steps assume kubectl is installed on your local machine and will walk the user through the configuration of the context configuration to access the provider Kubernetes cluster.  For a through discussion of kubectl installation and use of the referenced environmental variable discussed below - please reference the following document:
  * [https://rancher.com/learning-paths/how-to-manage-kubernetes-with-kubectl](https://rancher.com/learning-paths/how-to-manage-kubernetes-with-kubectl)
* To allow creation of the Customer Resource Definition \(CRD\) the config file referenced/manipulated in the prior step will be copied from the Kubernetes master/control-plane instance to your local machine where the kubectl command shall be executed.
* Copy the entire content of the updated kubeconfig file from the master node \(file location - /root/.kube/config\)
* Save a copy of this file on your local machine.
* On your local machine set the KUBECONFIG environmental variable to the path of the config file saved locally.



#### **Creation of the Custom Resource Definition \(CRD\)**

Akash uses a Custom Resource Definition to store each deployment in Kubernetes. 

Section assumes the steps detailed in the Akash CRD section for the kubeconfig file edit, copy, and local configuration have been completed

* To initiate the CRD creation in Kubernetes download the following file on your local machine
* Steps provided subsequently to both download and install the CRD

[**https://raw.githubusercontent.com/ovrclk/akash/master/pkg/apis/akash.network/v1/crd.yaml**](https://raw.githubusercontent.com/ovrclk/akash/master/pkg/apis/akash.network/v1/crd.yaml)

**Ingress Controller Overview**

* Download the CRD YAML and apply/install the CRD into the Kubernetes cluster

```text
wget https://raw.githubusercontent.com/ovrclk/akash/master/pkg/apis/akash.network/v1/crd.yaml

kubectl apply -f ./crd.yaml
```

_Potential Error Condition Encountered During CRD Creation:_

The Akash provider requires an ingress controller which must be created in the Kubernetes cluster. The application of the ingress controller will be accomplished by downloading the controller’s YAML manifest and applying the manifest through kubectl from your local machine.

* If the following error is encountered - the KUBECONFIG environment variable is likely incorrectly configured  _Error message - The connection to the server 127.0.0.1:34473 was refused - did you specify the right host or port?_

### **Add a NGINX Ingress controller in the Kubernetes cluster for Akash**

#### **Akash Network Configuration Addition**

_Prerequisites_

**Creation of the Ingress Controller**

Section assumes the steps detailed in the Akash CRD section for the kubeconfig file edit, copy, and local configuration have been completed

* To initiate the ingress controller creation in Kubernetes download the following file on your local machine
* Steps provided subsequently to both download and install the ingress controller

[**https://raw.githubusercontent.com/ovrclk/akash/master/\_run/ingress-nginx.yaml**](https://raw.githubusercontent.com/ovrclk/akash/master/_run/ingress-nginx.yaml)

_Network Configuration Overview_

<table>
  <thead>
    <tr>
      <th style="text-align:left">
        <ul>
          <li>Download the YAML file and apply/install into the Kubernetes cluster</li>
        </ul>
        <p><b>wget https://raw.githubusercontent.com/ovrclk/akash/master/_run/ingress-nginx.yaml<br /></b>
        </p>
        <p><b>kubectl apply -f ./ingress-nginx.yaml<br /></b>
        </p>
      </th>
    </tr>
  </thead>
  <tbody></tbody>
</table>

**Apply Node Label for Ingress Controller**  


Akash supplies a network configuration which must be applied to the Kubernetes cluster. The application of the network configuration will be accomplished by downloading the network policy YAML manifest and applying the manifest through kubectl from your local machine.

One node should be labeled with a label specific to this ingress declaration.

_Application of the Network Profile_

The label will cause the NGINX ingress to live only on the labeled node. When the wildcard domain is created subsequently the pointers should be to the labeled node's IP address.

* To initiate the network profile creation in Kubernetes download the following file on your local machine
* Steps provided subsequently to both download and install the network profile

[**https://raw.githubusercontent.com/ovrclk/akash/master/\_docs/kustomize/networking/network-policy-default-ns-deny.yaml**](https://raw.githubusercontent.com/ovrclk/akash/master/_docs/kustomize/networking/network-policy-default-ns-deny.yaml)

Additional nodes may be labeled to load balance the ingress network.

| **kubectl label nodes node3 akash.network/role=ingress** |
| :--- |


## **Akash Provider Implementation and Configuration**

### **Overview**

An Akash provider is started by running the command  “akash provider run” - as detailed subsequently in this section - on a system on which the Akash software package has been installed previously. The command is configurable entirely through the command line switches. For each relevant command line switch, an associated environmental variable may also be used alternatively and the use of such variables is encouraged for production operations.

_Download the YAML file and apply/install into the Kubernetes cluster_

Guidance for environmental variable use in subsequent instructions in this guide using a prominent example:

```text
wget https://raw.githubusercontent.com/ovrclk/akash/master/_docs/kustomize/networking/network-policy-default-ns-deny.yaml

kubectl apply -f ./network-policy-default-ns-deny.yaml
```

* The Akash provider supports the command line switch --chain-id
* The environmental variable equivalent is derived via:
  * Removing the leading dashes 
  * All other dashes become underscores
  * All characters are converted to uppercase
  * The prefix AKASH\_ is added
*  Thus the resultant environmental variable - utilized in place of the command line switch --chain-id would be:
  * AKASH\_CHAIN\_ID

### **Akash Provider Creation and Configuration Steps Overview**

_**The necessary steps to host an Akash provider include:**_

#### **Akash Ingress Controller**

_Prerequisites_

**STEP1**: Select a host to run the Akash provider \(Kubernetes master node co-residency option acceptable if desired\)

Section assumes the steps detailed in the Akash CRD section for the kubeconfig file edit, copy, and local configuration have been completed

**STEP2**: Install the Akash software on selected provider host

_Ingress Controller Overview_

The Akash provider requires an ingress controller which must be created in the Kubernetes cluster. The application of the ingress controller will be accomplished by downloading the controller’s YAML manifest and applying the manifest through kubectl from your local machine.

_Creation of the Ingress Controller_

* To initiate the ingress controller creation in Kubernetes download the following file on your local machine
* Steps provided subsequently to both download and install the ingress controller

[**https://raw.githubusercontent.com/ovrclk/akash/master/\_run/ingress-nginx.yaml**](https://raw.githubusercontent.com/ovrclk/akash/master/_run/ingress-nginx.yaml)

_Download the YAML file and apply/install into the Kubernetes cluster_

```text
wget https://raw.githubusercontent.com/ovrclk/akash/master/_run/ingress-nginx.yaml

kubectl apply -f ./ingress-nginx.yaml
```

**STEP3**: Import/Create provider account

_Apply Node Label for Ingress Controller_

**STEP4**: Domain name considerations

One node should be labeled with a label specific to this ingress declaration.

**STEP5**: Configure/Create the Akash Provider

The label will cause the NGINX ingress to live only on the labeled node. When the wildcard domain is created subsequently the pointers should be to the labeled node's IP address.

**STEP6**: Create a TLS certificate for the provider on chain

Additional nodes may be labeled to load balance the ingress network.

```text
kubectl label nodes node3 akash.network/role=ingress
```

## **Akash Provider Implementation and Configuration**

### **Overview**

An Akash provider is started by running the command  “akash provider run” - as detailed subsequently in this section - on a system on which the Akash software package has been installed previously. The command is configurable entirely through the command line switches. For each relevant command line switch, an associated environmental variable may also be used alternatively and the use of such variables is encouraged for production operations.

Guidance for environmental variable use in subsequent instructions in this guide using a prominent example:

* The Akash provider supports the command line switch --chain-id
* The environmental variable equivalent is derived via:
  * Removing the leading dashes 
  * All other dashes become underscores
  * All characters are converted to uppercase
  * The prefix AKASH\_ is added
*  Thus the resultant environmental variable - utilized in place of the command line switch --chain-id would be:
  * AKASH\_CHAIN\_ID

### **Akash Provider Creation and Configuration Steps Overview**

_The necessary steps to host an Akash provider include:_

**STEP1:**  Select a host to run the Akash provider \(Kubernetes master node co-residency option acceptable if desired\)

**STEP2:**  Install the Akash software on selected provider host

**STEP3:**  Import/Create provider account

**STEP4:**  Domain name considerations

**STEP5:**  Configure/Create the Akash Provider

**STEP6:**  Create a TLS certificate for the provider on chainSTEP7: Starting the provider

**STEP7:**  Starting the provider

This section documents configuration that should be considered in customization during Akash provider creation. The Akash provider process may be provoked and executed via any means preferred in your unique environment. Akash has built Ansible playbooks to assist the user in the steps necessary to run the provider if this path is desired and preferred.

### **Select a host to run the Akash provider**

The Akash provider may be co-resident on a Kubernetes master/node or on a separate host.  The installation of the provider will be conducted on a Kubernetes master within the steps of this guide.

### **Install the Akash Software on Selected Provider Host**

The installation of Akash software is covered in detail and should be referenced in full at the following Akash documentation locations:

* Deploy on Akash &gt; Quick Start Guide - guide may be found within the following URL:
  * [https://docs.akash.network/guides/deploy](https://docs.akash.network/guides/deploy)
* Deploy on Akash &gt; Install Akash - guide may be found within the following URL:
  * [https://docs.akash.network/guides/install](https://docs.akash.network/guides/install)

#### **Linux Installation Reference**

As a matter of quick reference the following Akash software installation pertaining to a Linux server implementation is provided and utilizing the Godownloader methodology.

_Configure the Akash version_

```text
AKASH_VERSION="$(curl -s "https://raw.githubusercontent.com/ovrclk/net/master/mainnet/version.txt")"
```

_Install Akash software on host_

```text
curl https://raw.githubusercontent.com/ovrclk/akash/master/godownloader.sh | sh -s -- "v$AKASH_VERSION"
```

_Add the Akash binary to the user/shell path \(note - the technique provided is only relevant to Ubuntu Linux.  Refer to the referenced installation sections provide previously for additional path configuration needs\)_

```text
vi /etc/environment
```

_Edit/add the path to the Akash binary \(I.e. /root/bin\) to the PATH variable_

**STEP7**: Starting the provider

### **Import/Create Provider Account**

The creation of an Akash account is covered in detail and should be referenced in full at the following Akash documentation locations:

This section documents configuration that should be considered in customization during Akash provider creation. The Akash provider process may be provoked and executed via any means preferred in your unique environment. Akash has built Ansible playbooks to assist the user in the steps necessary to run the provider if this path is desired and preferred.

* Deploy on Akash &gt; Create Account - guide may be found within the following URL:
  * [https://docs.akash.network/guides/wallet](https://docs.akash.network/guides/wallet)

_Note Pertaining to the Keyring Backend Specification_

### **Select a host to run the Akash provider**

The Akash provider may be co-resident on a Kubernetes master/node or on a separate host.  The installation of the provider will be conducted on a Kubenetes master within the steps of this guide.

During the processes of provider creation and bringing the provider into an active run state the Akash keyring must be available and referenced within a local directory/file.  Thus in the creation of the Akash account ensure that the Key Ring Backend is stored in a file and not in the OS \(which is the default\).  This may be accomplished by using the following variable during account creation.  The account’s wallet and key will then be stored in the $HOME/.akash directory.

### **Install the Akash Software on Selected Provider Host**

The installation of Akash software is covered in detail and should be referenced in full at the following Akash documentation locations:

​​AKASH\_KEYRING\_BACKEND=file

_Wallet Funding Requirement - Minimum of 50 AKT_

* Deploy on Akash &gt; Quick Start Guide - guide may be found within the following URL:
  * [https://docs.akash.network/guides/deploy](https://docs.akash.network/guides/deploy)
* Deploy on Akash &gt; Install Akash - guide may be found within the following URL:
  * [https://docs.akash.network/guides/install](https://docs.akash.network/guides/install)

#### **Linux Installation Reference**

As a matter of quick reference the following Akash software installation pertaining to a Linux server implementation is provided and utilizing the Godownloader methodology.

The account must be adequately funded as detailed prior.  To reiterate the provider account’s requirements:

* An associated, available wallet must have sufficient funding, as placing a bid on an order on the blockchain requires a 50 AKT deposit. This deposit is fully refunded after the bid is won/lost.
  * The precise minimum funding requirement of the wallet is marginally greater than 50 AKT as tiny amounts \(about 0.001\) of AKT is utilized by the Akash provider to commit transactions on the Akash blockchain.
  * Reference [https://docs.akash.network/guides/funding](https://docs.akash.network/guides/funding)  as a purchasing guide of AKT and[ https://docs.akash.network/guides/deploy](https://docs.akash.network/guides/deploy) Akash CLI wallet install.

<table>
  <thead>
    <tr>
      <th style="text-align:left">
        <ul>
          <li>Configure the Akash version</li>
        </ul>
        <p><b>AKASH_VERSION=&quot;$(curl -s &quot;https://raw.githubusercontent.com/ovrclk/net/master/mainnet/version.txt&quot;)&quot;<br /></b>
        </p>
        <ul>
          <li>Install Akash software on host</li>
        </ul>
        <p><b>curl https://raw.githubusercontent.com/ovrclk/akash/master/godownloader.sh | sh -s -- &quot;v$AKASH_VERSION&quot;<br /></b>
        </p>
        <ul>
          <li>Add the Akash binary to the user/shell path (note - the technique provided
            is only relevant to Ubuntu Linux. Refer to the referenced installation
            sections provide previously for additional path configuration needs)</li>
        </ul>
        <p><b>vi /etc/environment<br /></b>
        </p>
        <ul>
          <li>Edit the path to the Akash binary (I.e. /root/bin) to the PATH variable</li>
        </ul>
      </th>
    </tr>
  </thead>
  <tbody></tbody>
</table>

### **Import/Create Provider Account**

The creation of an Akash account is covered in detail and should be referenced in full at the following Akash documentation locations:

* Deploy on Akash &gt; Create Account - guide may be found within the following URL:
  * [**https://docs.akash.network/guides/wallet**](https://docs.akash.network/guides/wallet)

_Note Pertaining to the Keyring Backend Specification_  


Ensure completion of the “Connect to the Network” portion of the Deploy guide which is titled “Part 4. Connect to the Network” - which would be necessary to complete the account funding process - as detailed in the previously listed deploy guide URL \([https://docs.akash.network/guides/deploy](https://docs.akash.network/guides/deploy)\).  


During the processes of provider creation and bringing the provider into an active run state the Akash keyring must be available and referenced within a local directory/file.  Thus in the creation of the Akash account ensure that the Key Ring Backend is stored in a file and not in the OS \(which is the default\).  This may be accomplished by using the following variable during account creation.  The account’s wallet and key will then be stored in the $HOME/.akash directory.

#### **Validate Account Funding**

Validate account funding minimum requirements levels by issuing the following command

```text
akash query bank balances --node $AKASH_NODE $AKASH_ACCOUNT_ADDRESS
```

**​​**AKASH\_KEYRING\_BACKEND=file

### **Domain Name Considerations**

#### **Public Domain Name Configuration**

Prior to commencing with the Provider creation and initiation - a discussion of necessary public domain name’s is provided in this section to ensure readiness for subsequent steps.

Wallet Funding Requirement - Minimum of 50 AKT

_Provider Host_

* The provider host is the publicly accessible domain name of the provider
* The domain name will be  specified in the Akash Provider YAML configuration file using the key of host
*  The associated YAML file is utilized during “akash tx provider create” and “akash tx provider update” are executed as detailed in subsequent sections
* The provider host value is stored on the blockchain and is used whenever a lease owner needs to communicate directly with the provider for activities such as sending a manifest or fetching a lease status

The account must be adequately funded as detailed prior.  To reiterate the provider account’s requirements:

* An associated, available wallet must have sufficient funding, as placing a bid on an order on the blockchain requires a 50 AKT deposit. This deposit is fully refunded after the bid is won/lost.
  * The precise minimum funding requirement of the wallet is marginally greater than 50 AKT as tiny amounts \(about 0.001\) of AKT is utilized by the Akash provider to commit transactions on the Akash blockchain.
  * Reference [https://docs.akash.network/guides/funding](https://docs.akash.network/guides/funding)  as a purchasing guide of AKT and[ https://docs.akash.network/guides/deploy](https://docs.akash.network/guides/deploy) Akash CLI wallet install.
  * Ensure completion of the “Connect to the Network” portion of the Deploy guide which is titled “Part 4. Connect to the Network” - which would be necessary to complete the account funding process - as detailed in the previously listed deploy guide URL \([https://docs.akash.network/guides/deploy](https://docs.akash.network/guides/deploy)\).

#### **Validate Account Funding**

Validate account funding minimum requirements levels by issuing the following command

_Kubernetes Ingress Controller Host_

| **akash query bank balances --node $AKASH\_NODE $AKASH\_ACCOUNT\_ADDRESS**  |
| :--- |


### **Domain Name Considerations**

#### _Public Domain Name Configuration_

Prior to commencing with the Provider creation and initiation - a discussion of necessary public domain name’s is provided in this section to ensure readiness for subsequent steps.

* The Kubernetes ingress controller host is the publicly accessible domain name of the Kubernetes cluster. 
* The Kubernetes cluster hosts an Ingress Controller and serves as the mechanism to expose Akash leases to the outside world. 
* The current recommendation is to[ assign](https://github.com/ovrclk/docs/blob/master/guides/provider.md#Create-Kubernetes-Ingress-Controller) exactly one node in your cluster to the Ingress Controller role.
* At this time only HTTP is supported for the Ingress Controller. 
* The hostname should resolve to an IP which directs traffic to the Kubernetes ingress controller IP on your network. 
* The domain name value is specified via the --deployment-ingress-domain switch when the “akash provider run” command activates the provider instance as detailed in a subsequent section. 
* The value is not stored on the blockchain.

_Kubernetes Cluster Public Hostname_

_**Provider Host**_

* The cluster public hostname is the publicly accessible hostname of the Kubernetes cluster. 
* No requirement exists - nor is it desirable -  to expose an entire Kubernetes cluster to the internet. 
* The Kubernetes cluster supports a feature called a "NodePort" service. This allows UDP and TCP traffic to be forwarded from the cluster directly to a container on any node in the cluster. By default Kubernetes uses the port range 30000-32767 for the NodePort service. The recommendation would be to allow outside traffic only to the NodePort range. 
* The associated domain name should resolve to an IP address that directs traffic to any of the nodes in the Kubernetes cluster. Kubernetes then automatically routes the IP traffic to the correct container. 
* The domain name value is specified via the --cluster-public-hostname switch when the “akash provider run” command activates the provider instance as detailed in a subsequent section. 
* The value may be different than that of the Kubernetes ingress controller host  but this is not required and the domain names may be identical.
* The value is not stored on the blockchain.

#### **Blocking Hostnames**

An additional topic of discussion prior to the creation of the Akash provide instance pertains to the use of hostnames requested during lease creation.

_Lease Hostname Overview_

* The provider host is the publicly accessible domain name of the provider
* The domain name will be  specified in the Akash Provider YAML configuration file using the key of host
*  The associated YAML file is utilized during “akash tx provider create” and “akash tx provider update” are executed as detailed in subsequent sections
* The provider host value is stored on the blockchain and is used whenever a lease owner needs to communicate directly with the provider for activities such as sending a manifest or fetching a lease status
* A Kubernetes ingress controller is utilized to expose HTTP traffic from an Akash lease to the outside world. 
* By default the lease may request any hostname desired.
* The hostname is published in the DNS entries maintained by Kubernetes. 
* However there may be a desire to block some domains in lease use.

_**Kubernetes Ingress Controller Host**_

* The Kubernetes ingress controller host is the publicly accessible domain name of the Kubernetes cluster. 
* The Kubernetes cluster hosts an Ingress Controller and serves as the mechanism to expose Akash leases to the outside world. 
* The current recommendation is to[ assign](https://github.com/ovrclk/docs/blob/master/guides/provider.md#Create-Kubernetes-Ingress-Controller) exactly one node in your cluster to the Ingress Controller role.
* At this time only HTTP is supported for the Ingress Controller. 
* The hostname should resolve to an IP which directs traffic to the Kubernetes ingress controller IP on your network. 
* The domain name value is specified via the --deployment-ingress-domain switch when the “akash provider run” command activates the provider instance as detailed in a subsequent section. 
* The value is not stored on the blockchain.

**Kubernetes Cluster Public Hostname**

* The cluster public hostname is the publicly accessible hostname of the Kubernetes cluster. 
* No requirement exists - nor is it desirable -  to expose an entire Kubernetes cluster to the internet. 
* The Kubernetes cluster supports a feature called a "NodePort" service. This allows UDP and TCP traffic to be forwarded from the cluster directly to a container on any node in the cluster. By default Kubernetes uses the port range 30000-32767 for the NodePort service. The recommendation would be to allow outside traffic only to the NodePort range. 
* The associated domain name should resolve to an IP address that directs traffic to any of the nodes in the Kubernetes cluster. Kubernetes then automatically routes the IP traffic to the correct container. 
* The domain name value is specified via the --cluster-public-hostname switch when the “akash provider run” command activates the provider instance as detailed in a subsequent section. 
* The value may be different than that of the Kubernetes ingress controller host  but this is not required and the domain names may be identical.
* The value is not stored on the blockchain.

#### **Blocking Hostnames**

An additional topic of discussion prior to the creation of the Akash provide instance pertains to the use of hostnames requested during lease creation.

_Blocking Specific Domains/Hostnames for Lease Use_

* The command line switch --deployment-blocked-hostnames command line switch - which may be included the “akash provider run” command detailed subsequently - allows blocking of a domain. 
* To block a single domain, specify it exactly. For example:
  * --deployment-blocked-hostnames=akash.network blocks a lease from requesting a hostname of akash.network. 
* To block a domain and all subdomains, precede the hostname with the dot character. For example:
  *  --deployment-blocked-hostnames=.bobsdeficloud.com would block bobsdeficloud.com, www.bobsdeficloud.com as well as any other subdomains.
* The  --deployment-blocked-hostnames command line switch may be provided any number of times within a single “akash provider run” command to provoke multiple domain name blocks.

### **Configure/Create the Akash Provider**

_The activities in this section may be conducted on any Kubernetes host or remote machine with kubectl installed and configured with a context for the Akash Kubenetes cluster._

**Lease Hostname Overview**

#### **Creation of Akash Provider via YAML File Populated with Provider Specific Details**

PROVIDER\_DOMAIN Environment Variable Creation

* A Kubernetes ingress controller is utilized to expose HTTP traffic from an Akash lease to the outside world. 
* By default the lease may request any hostname desired.
* The hostname is published in the DNS entries maintained by Kubernetes. 
* However there may be a desire to block some domains in lease use.
* Create an environment variable of PROVIDER\_DOMAIN
* This environment variable was detailed previously in the Public Domain Name Configuration &gt; Provider Host section and should be the domain name of the selected Akash provider host

**Blocking Specific Domains/Hostnames for Lease Use**

```text
export PROVIDER_DOMAIN=<provider-host-domain-name>
```

_Creation of the “provider.yaml” Configuration File_

* The command line switch --deployment-blocked-hostnames command line switch - which may be included the “akash provider run” command detailed subsequently - allows blocking of a domain. 
* To block a single domain, specify it exactly. For example:
  * --deployment-blocked-hostnames=akash.network blocks a lease from requesting a hostname of akash.network. 
* To block a domain and all subdomains, precede the hostname with the dot character. For example:
  *  --deployment-blocked-hostnames=.bobsdeficloud.com would block bobsdeficloud.com, www.bobsdeficloud.com as well as any other subdomains.
* The  --deployment-blocked-hostnames command line switch may be provided any number of times within a single “akash provider run” command to provoke multiple domain name blocks.
* Create a file with the name of - provider.yaml - and populate the following key-value pairs with edits made as necessary
* **IMPORTANT:** If an IP address is utilized instead of the FQDN hostname \(not recommended\), an broadcast update via the “akash tx provider” command will be required each time the IP changes.

### **Configure/Create the Akash Provider**

The activities in this section may be conducted on any Kubernetes host or remote machine with kubectl installed and configured with a context for the Akash Kubenetes cluster.

```text
host: https://$PROVIDER_DOMAIN:8443
attributes:
  - key: region
    value: us-west
  - key: host
    value: <nameOfYourOrganization>
```

_Create the Akash Provider_

* Register provider on the Akash Network
* Ensure that all environment variables referenced are created prior to execution
* For additional guidance the following list demonstrates command/example values for each variable:
  * AKASH\_PROVIDER\_KEY=alice
    * Must match key that was used during account creation
  * AKASH\_HOME=/root/.akash
    * Must match the directory location of the wallet stored via when the backend was specified as file and the provider account was created.  Location as shown above is likely.
  * AKASH\_KEYRING\_BACKEND=file
  * AKASH\_NODE=[http://135.181.60.250:26657](http://135.181.60.250:26657)
  * AKASH\_CHAIN\_ID=akashnet-2

```text
akash tx provider create provider.yaml --from $AKASH_PROVIDER_KEY --home=$AKASH_HOME --keyring-backend=$AKASH_KEYRING_BACKEND --node=$AKASH_NODE --chain-id=$AKASH_CHAIN_ID --fees 5000uakt
```

### **Create a TLS certificate for the provider on chain**

* Issue a transaction to the blockchain to create a certificate associated with your provider.

```text
akash tx cert create server $PROVIDER_DOMAIN --chain-id $AKASH_CHAIN_ID --keyring-backend $AKASH_KEYRING_BACKEND --from $AKASH_PROVIDER_KEY --home=$AKASH_HOME --node=$AKASH_NODE --fees 5000uakt
```

### **Starting the Provider**

#### **Mandatory provider configuration**

The following parameters must be specified when starting the Akash provider.  Notes of interest pertaining to the parameter provided for reference.  As shown in the subsequent example command syntax - previously discussed and provoked environment variables should be used for many of the key values.

* --home
  * Location of the CLI wallet manifest during account creation and when the backend was specified as file.  Likely location would be $HOME/.akash \(I.e. /root/akash\).
* --chain-id
* --keyring-backend 
  * Should always be set to test
* --fees
* --kubeconfig
* --cluster-k8s
  * Should always be set to test
* --deployment-ingress-domain
* --deployment-ingress-static-hosts
  * Should always be set to test
* --cluster-public-hostname
* --node
* --from

_Example command to start a provider:_

* Note - the “bid-price” options included in this example are detailed in a subsequent section of this guide

```text
akash provider run \
  --home $AKASH_HOME \
  --chain-id $AKASH_CHAIN_ID \
  --node $AKASH_NODE \
  --keyring-backend=file \
  --from $AKASH_PROVIDER_KEY \
  --fees 1000uakt \
  --kubeconfig $KUBECONFIG \
  --cluster-k8s true \
  --deployment-ingress-domain $PROVIDER_DOMAIN \
  --deployment-ingress-static-hosts true \
  --bid-price-strategy scale \
  --bid-price-cpu-scale 0.001 \
  --bid-price-memory-scale 0.001 \
  --bid-price-storage-scale 0.00001 \
  --bid-price-endpoint-scale 0 \
  --bid-deposit 5000000uakt \
  --cluster-node-port-quantity 1000 \
  --cluster-public-hostname $PROVIDER_DOMAIN
```

#### **Kubernetes Cluster Resource Overcommit Options**

_The options detailed in this section are optional parameters of the “akash provider run” command_

* By default the akash provider asks Kubernetes to reserve all resources on a 1 for 1 basis. Since not all leases are expected to see 100% resource utilization, it makes sense to allow resource overcommit. The following flags may be set
  * --overcommit-pct-cpu - CPU overcommit percentage
  * --overcommit-pct-mem - Memory overcommit percentage
  * --overcommit-pct-storage - Storage overcommit percentage
* Any flag not specified is equivalent to having a value of zero.
* Each flag must be a positive integer number. The number provided would become the percentage of overcommit to consider when making bids. 
* Example:
  *  --overcommit-pct-cpu=50 
  * Instructs the Akash provider to commit 50% more CPU than is actually available.

#### **Bid Pricing Options**

_The options detailed in this section are optional parameters of the “akash provider run” command_

When the Akash provider considers bidding on a lease, the provider instance must compute a bid price. The bid pricing strategy is set with the switch:

* --bid-price-strategy

By default the scale strategy is used. This strategy computes bid prices using a set of linear scales and computed via the requested CPU, memory, and storage levels.

When the scale strategy is used, at least one of the following command line switches must be set:

* --bid-price-memory-scale - memory pricing scale in uakt per megabyte \(default "0"\)
* --bid-price-cpu-scale - cpu pricing scale in uakt per millicpu \(default "0"\)
* --bid-price-storage - storage pricing scale in uakt per megabyte \(default "0"\)
* --bid-price-endpoint-scale - endpoint pricing scale in uakt \(default "0", must be a whole number\)

The actual bid price is computed by multiplying the configured scale with the resources requested in the lease.

The scale strategy is not likely to be sufficient for all providers. Since some providers may want to use complex pricing strategies \(or not bid at all\) the script strategy can be used. The script strategy invokes an external script to compute a bid price and uses that as a result. A Python script example is provided subsequently.  The following command line switches are used to control the script invocation:

* --bid-price-script-path - Path to executable script, must be set
* --bid-price-script-process-limit - Maximum number of concurrent executions of the script
* --bid-price-script-process-timeout - Timeout on bid pricing script configuration

The pricing configuration script must be a file on the same filesystem as the provider and be marked as executable. The script must do the following:

#### Creation of Akash Provider via YAML File Populated with Provider Specific Details

PROVIDER\_DOMAIN Environment Variable Creation

1. Read all available data from standard in
2. Parse this data as JSON
3. Uses the data to compute the bid price
4. Write the bid price to standard out as a single JSON number

_The data written to standard out has the following structure:_

```text
[
   {
   "memory": 2048
   "cpu": 333
   "storage": 100
   "count": 1
   "endpoint-quantity": 1
   }
]
```

This data is a list of JSON objects, with each JSON object in the list describing a resource that is fulfilled as part of the lease.

The following units are used:

* Create an environment variable of PROVIDER\_DOMAIN
* This environment variable was detailed previously in the Public Domain Name Configuration &gt; Provider Host section and should be the domain name of the selected Akash provider host
* "memory" - bytes
* "cpu" - millicpu
* "storage" - bytes

| **export PROVIDER\_DOMAIN=&lt;provider-host-domain-name&gt;** |
| :--- |


**Creation of the “provider.yaml” Configuration File**

* Create a file with the name of - provider.yaml - and populate the following key-value pairs with edits made as necessary
* IMPORTANT: If an IP address is utilized instead of the FQDN hostname \(not recommended\), an broadcast update via the “akash tx provider” command will be required each time the IP changes.

<table>
  <thead>
    <tr>
      <th style="text-align:left">
        <p><b>host: https://$PROVIDER_DOMAIN:8443</b>
        </p>
        <p><b>attributes:</b>
        </p>
        <p><b>  - key: region</b>
        </p>
        <p><b>    value: us-west</b>
        </p>
        <p><b>  - key: host</b>
        </p>
        <p><b>    value: &lt;nameOfYourOrganization&gt;</b>
        </p>
      </th>
    </tr>
  </thead>
  <tbody></tbody>
</table>

**Create the Akash Provider**

The key "endpoint-quantity" defines the number of exposed ports the lease is requesting. The "count" key is used when more than 1 instance of an identical set of resources is bid on.

* Register provider on the Akash Network
* Ensure that all environment variables referenced are created prior to execution
* For additional guidance the following list demonstrates command/example values for each variable:
  * AKASH\_PROVIDER\_KEY=alice
    * Must match key that was used during account creation
  * AKASH\_HOME=/root/.akash
    * Must match the directory location of the wallet stored via when the backend was specified as file and the provider account was created.  Location as shown above is likely.
  * AKASH\_KEYRING\_BACKEND=file
  * AKASH\_NODE=[http://135.181.60.250:26657](http://135.181.60.250:26657)
  * AKASH\_CHAIN\_ID=akashnet-2

| **akash tx provider create provider.yaml --from $AKASH\_PROVIDER\_KEY --home=$AKASH\_HOME --keyring-backend=$AKASH\_KEYRING\_BACKEND --node=$AKASH\_NODE --chain-id=$AKASH\_CHAIN\_ID --fees 5000uakt** |
| :--- |


### **Create a TLS certificate for the provider on chain**

* Issue a transaction to the blockchain to create a certificate associated with your provider.

| **akash tx cert create server $PROVIDER\_DOMAIN --chain-id $AKASH\_CHAIN\_ID --keyring-backend $AKASH\_KEYRING\_BACKEND --from $AKASH\_PROVIDER\_KEY --home=$AKASH\_HOME --node=$AKASH\_NODE --fees 5000uakt** |
| :--- |


### **Starting the Provider**

#### **Mandatory provider configuration**

The following parameters must be specified when starting the Akash provider.  Notes of interest pertaining to the parameter provided for reference.  As shown in the subsequent example command syntax - previously discussed and provoked environment variables should be used for many of the key values.

The pricing script may make any computations it needs to compute a price. The price is written to standard out as a JSON number. This should be a whole number, representing the bid quantity in uakt. If the decision is made that no bid should be placed, the number 0 should be used for the bid quantity.

* --home
  * Location of the CLI wallet manifest during account creation and when the backend was specified as file.  Likely location would be $HOME/.akash \(I.e. /root/akash\).
* --chain-id
* --keyring-backend 
  * Should always be set to test
* --fees
* --kubeconfig
* --cluster-k8s
  * Should always be set to test
* --deployment-ingress-domain
* --deployment-ingress-static-hosts
  * Should always be set to test
* --cluster-public-hostname
* --node
* --from

**Example command to start a provider:**

#### **Example Python Script for Bid Price Computation**

_The Python script detailed below provides the example referenced in the previous section for granular control of bid price computation._

* Note - the “bid-price” options included in this example are detailed in a subsequent section of this guide

<table>
  <thead>
    <tr>
      <th style="text-align:left">
        <p><b>akash provider run \</b>
        </p>
        <p><b>  --home $AKASH_HOME \</b>
        </p>
        <p><b>  --chain-id $AKASH_CHAIN_ID \</b>
        </p>
        <p><b>  --node $AKASH_NODE \</b>
        </p>
        <p><b>  --keyring-backend=file \</b>
        </p>
        <p><b>  --from $AKASH_PROVIDER_KEY \</b>
        </p>
        <p><b>  --fees 1000uakt \</b>
        </p>
        <p><b>  --kubeconfig $KUBECONFIG \</b>
        </p>
        <p><b>  --cluster-k8s true \</b>
        </p>
        <p><b>  --deployment-ingress-domain $PROVIDER_DOMAIN \</b>
        </p>
        <p><b>  --deployment-ingress-static-hosts true \</b>
        </p>
        <p><b>  --bid-price-strategy scale \</b>
        </p>
        <p><b>  --bid-price-cpu-scale 0.001 \</b>
        </p>
        <p><b>  --bid-price-memory-scale 0.001 \</b>
        </p>
        <p><b>  --bid-price-storage-scale 0.00001 \</b>
        </p>
        <p><b>  --bid-price-endpoint-scale 0 \</b>
        </p>
        <p><b>  --bid-deposit 5000000uakt \</b>
        </p>
        <p><b>  --cluster-node-port-quantity 1000 \</b>
        </p>
        <p><b>  --cluster-public-hostname $PROVIDER_DOMAIN<br /></b>
        </p>
      </th>
    </tr>
  </thead>
  <tbody></tbody>
</table>

#### **Kubernetes Cluster Resource Overcommit Options**

The options detailed in this section are optional parameters of the “akash provider run” command

* The following script shows an example implementation of a bid pricing using the Python 3 language.

```text
#!/usr/bin/env python3

import math
import sys
import json

# Read JSON from standard input
order_data = json.load(sys.stdin)

bid = True # Flag determining whether or not to bid
bid_price = 0 # Total bid price
memory_cutoff = 4*(1024**3) # Limit for the amount of memory any one container can request (e.g. 4G RAM max)

bid_price_memory_scale = 0.001
bid_price_storage_scale = 0.0002
bid_price_cpu_scale = 0.001

MEGA = 1024 ** 2

for group in order_data:
  # Compute total cost for this container
  group_count = group['count']
  price = group['cpu'] * bid_price_cpu_scale + group['memory']/MEGA * bid_price_memory_scale + group['storage']/MEGA * bid_price_storage_scale
  bid_price += group['count'] * price

  # Disable bidding if there is a large container
  if group['memory'] > memory_cutoff:
    bid = False

bid_price = math.ceil(bid_price) # Convert bid to an integer  

# A result must always be written to standard out
if bid:
    json.dump(bid_price, sys.stdout)
else:
    # Indicate not to bid
    json.dump(0, sys.stdout)

```

* By default the akash provider asks Kubernetes to reserve all resources on a 1 for 1 basis. Since not all leases are expected to see 100% resource utilization, it makes sense to allow resource overcommit. The following flags may be set
  * --overcommit-pct-cpu - CPU overcommit percentage
  * --overcommit-pct-mem - Memory overcommit percentage
  * --overcommit-pct-storage - Storage overcommit percentage
* Any flag not specified is equivalent to having a value of zero.
* Each flag must be a positive integer number. The number provided would become the percentage of overcommit to consider when making bids. 
* Example:
  *  --overcommit-pct-cpu=50 
  * Instructs the Akash provider to commit 50% more CPU than is actually available.

#### **Bid Pricing Options**

The options detailed in this section are optional parameters of the “akash provider run” command

When the Akash provider considers bidding on a lease, the provider instance must compute a bid price. The bid pricing strategy is set with the switch:

* --bid-price-strategy. 

By default the scale strategy is used. This strategy computes bid prices using a set of linear scales and computed via the requested CPU, memory, and storage levels.

When the scale strategy is used, at least one of the following command line switches must be set:

* --bid-price-memory-scale - memory pricing scale in uakt per megabyte \(default "0"\)
* --bid-price-cpu-scale - cpu pricing scale in uakt per millicpu \(default "0"\)
* --bid-price-storage - storage pricing scale in uakt per megabyte \(default "0"\)
* --bid-price-endpoint-scale - endpoint pricing scale in uakt \(default "0", must be a whole number\)

The actual bid price is computed by multiplying the configured scale with the resources requested in the lease.

The scale strategy is not likely to be sufficient for all providers. Since some providers may want to use complex pricing strategies \(or not bid at all\) the script strategy can be used. The script strategy invokes an external script to compute a bid price and uses that as a result. A Python script example is provided subsequently.  The following command line switches are used to control the script invocation:

* --bid-price-script-path - Path to executable script, must be set
* --bid-price-script-process-limit - Maximum number of concurrent executions of the script
* --bid-price-script-process-timeout - Timeout on bid pricing script configuration

The pricing configuration script must be a file on the same filesystem as the provider and be marked as executable. The script must do the following:

1. Read all available data from standard in
2. Parse this data as JSON
3. Uses the data to compute the bid price
4. Write the bid price to standard out as a single JSON number

The data written to standard out has the following structure:  
****

<table>
  <thead>
    <tr>
      <th style="text-align:left">
        <p><b>[</b>
        </p>
        <p><b>   {</b>
        </p>
        <p><b>   &quot;memory&quot;: 2048</b>
        </p>
        <p><b>   &quot;cpu&quot;: 333</b>
        </p>
        <p><b>   &quot;storage&quot;: 100</b>
        </p>
        <p><b>   &quot;count&quot;: 1</b>
        </p>
        <p><b>   &quot;endpoint-quantity&quot;: 1</b>
        </p>
        <p><b>   }</b>
        </p>
        <p><b>]</b>
        </p>
      </th>
    </tr>
  </thead>
  <tbody></tbody>
</table>

This data is a list of JSON objects, with each JSON object in the list describing a resource that is fulfilled as part of the lease.

The following units are used:

* "memory" - bytes
* "cpu" - millicpu
* "storage" - bytes

The key "endpoint-quantity" defines the number of exposed ports the lease is requesting. The "count" key is used when more than 1 instance of an identical set of resources is bid on.

The pricing script may make any computations it needs to compute a price. The price is written to standard out as a JSON number. This should be a whole number, representing the bid quantity in uakt. If the decision is made that no bid should be placed, the number 0 should be used for the bid quantity.

* The container requesting 0.5 CPU, 2G RAM, 32G storage would be quoted with a price of 10 uakt which is $11.22 a month if we assume 1 AKT price is $2.56. 
* The Akash providers can always adjust the bid prices whenever they want, which creates great competition!

```text
$ cat order-data.sample
[
    {
    "memory": 2147483648,
    "cpu": 500,
    "storage": 34359738368,
    "count": 1,
    "endpoint-quantity": 1
    }
]

$ python3 ./bid-price-script.py < order-data.sample ; echo
10

$ echo "((10*((60/6)*60*24*30.436875))/10^6)*2.56" | bc -l
11.22024960000000000000
```

#### Example Python Script for Bid Price Computation

## **Additional Resources**

The Python script detailed below provides the example referenced in the previous section for granular control of bid price computation.  


* The following script shows an example implementation of a bid pricing using the Python 3 language.

<table>
  <thead>
    <tr>
      <th style="text-align:left">
        <p><b>$ cat bid-price-script.py</b>
        </p>
        <p><b>#!/usr/bin/env python3<br /></b>
        </p>
        <p><b>import math</b>
        </p>
        <p><b>import sys</b>
        </p>
        <p><b>import json<br /></b>
        </p>
        <p><b># Read JSON from standard input</b>
        </p>
        <p><b>order_data = json.load(sys.stdin)<br /></b>
        </p>
        <p><b>bid = True # Flag determining whether or not to bid</b>
        </p>
        <p><b>bid_price = 0 # Total bid price</b>
        </p>
        <p><b>memory_cutoff = 4*(1024**3) # Limit for the amount of memory any one container can request (e.g. 4G RAM max)<br /></b>
        </p>
        <p><b>bid_price_memory_scale = 0.001</b>
        </p>
        <p><b>bid_price_storage_scale = 0.0002</b>
        </p>
        <p><b>bid_price_cpu_scale = 0.001<br /></b>
        </p>
        <p><b>MEGA = 1024 ** 2<br /></b>
        </p>
        <p><b>for group in order_data:</b>
        </p>
        <p><b>  # Compute total cost for this container</b>
        </p>
        <p><b>  group_count = group[&apos;count&apos;]</b>
        </p>
        <p><b>  price = group[&apos;cpu&apos;] * bid_price_cpu_scale + group[&apos;memory&apos;]/MEGA * bid_price_memory_scale + group[&apos;storage&apos;]/MEGA * bid_price_storage_scale</b>
        </p>
        <p><b>  bid_price += group[&apos;count&apos;] * price<br /></b>
        </p>
        <p><b>  # Disable bidding if there is a large container</b>
        </p>
        <p><b>  if group[&apos;memory&apos;] &gt; memory_cutoff:</b>
        </p>
        <p><b>    bid = False<br /></b>
        </p>
        <p><b>bid_price = math.ceil(bid_price) # Convert bid to an integer  <br /></b>
        </p>
        <p><b># A result must always be written to standard out</b>
        </p>
        <p><b>if bid:</b>
        </p>
        <p><b>    json.dump(bid_price, sys.stdout)</b>
        </p>
        <p><b>else:</b>
        </p>
        <p><b>    # Indicate not to bid</b>
        </p>
        <p><b>    json.dump(0, sys.stdout)<br /></b>
        </p>
      </th>
    </tr>
  </thead>
  <tbody></tbody>
</table>

* The container requesting 0.5 CPU, 2G RAM, 32G storage would be quoted with a price of 10 uakt which is $11.22 a month if we assume 1 AKT price is $2.56. 
* The Akash providers can always adjust the bid prices whenever they want, which creates great competition!

<table>
  <thead>
    <tr>
      <th style="text-align:left">
        <p><b>$ cat order-data.sample</b>
        </p>
        <p><b>[</b>
        </p>
        <p><b>    {</b>
        </p>
        <p><b>    &quot;memory&quot;: 2147483648,</b>
        </p>
        <p><b>    &quot;cpu&quot;: 500,</b>
        </p>
        <p><b>    &quot;storage&quot;: 34359738368,</b>
        </p>
        <p><b>    &quot;count&quot;: 1,</b>
        </p>
        <p><b>    &quot;endpoint-quantity&quot;: 1</b>
        </p>
        <p><b>    }</b>
        </p>
        <p><b>]<br /></b>
        </p>
        <p><b>$ python3 ./bid-price-script.py &lt; order-data.sample ; echo</b>
        </p>
        <p><b>10<br /></b>
        </p>
        <p><b>$ echo &quot;((10*((60/6)*60*24*30.436875))/10^6)*2.56&quot; | bc -l</b>
        </p>
        <p><b>11.22024960000000000000<br /></b>
        </p>
      </th>
    </tr>
  </thead>
  <tbody></tbody>
</table>

## **Additional Resources**

* Deploying Akash Provider without kubespray [https://nixaid.com/deploy-akash-provider-with-kubeadm](https://nixaid.com/deploy-akash-provider-with-kubeadm)​

Deploying Akash Provider without kubespray [https://nixaid.com/deploy-akash-provider-with-kubeadm](https://nixaid.com/deploy-akash-provider-with-kubeadm)**​**

