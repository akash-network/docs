# STEP 6 - DNS Configuration

## Upstream DNS Servers

Add  `upstream_dns_servers` in your Ansible inventory

> _**NOTE**_ - the steps in this section should be conducted on the Kubespray host

```
cd ~/kubespray
```

### Verify Current Upstream DNS Server Config

```
kubespray$ grep -A2 upstream_dns_servers inventory/akash/group_vars/all/all.yml
```

_**Expected/Example Output**_

* Note that in the default configuration of a new Kubespray host the Upstream DNS Server settings are commented out via the `#` prefix.

```
#upstream_dns_servers:
  #- 8.8.8.8
  #- 8.8.4.4
```

### Update Upstream DNS Server Config

```
vim inventory/akash/group_vars/all/all.yml
```

* Uncomment the `upstream_dns_servers` and the public DNS server line entries.
* When complete the associated lines should appears as:

```
## Upstream dns servers
upstream_dns_servers:
  - 8.8.8.8
  - 8.8.4.4
```
