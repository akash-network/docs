# Persistent Storage SDL Deepdive

Our review highlights the persistent storage parameters within the larger SDL example.

## Resources Section <a href="#resources-section" id="resources-section"></a>

### Overview <a href="#overview" id="overview"></a>

Within the profiles > compute > \<profile-name> resources section of the SDL storage profiles are defined. Our review begins with an overview of the section and this is followed by a deep dive into the available parameters.

_**NOTE**_ - a maximum amount of two (2) volumes per profile may be defined. The storage profile could consist of:

* A mandatory local container volume which is created with only a size key in our example
* An optional persistent storage volume which is created with the persistent: true attribute in our example

### Name <a href="#name" id="name"></a>

Each storage profile has a new and optional field name. The name is used by services to link service specific storage parameters to the storage. It can be omitted for single value use case and default value is set to default.

### Attributes <a href="#attributes" id="attributes"></a>

A storage volume may have the following attributes.

_**persistent**_ - determines if the volume requires persistence or not. The default value is set to false.

_**class**_ - storage class for persistent volumes. Default value is set to default. NOTE - It is invalid to set storage class for non-persistent volumes. Storage volume class types are expanded upon in the subsequent section.

### Storage Class Types

The class allows selection of a storage type.  Only providers capable of delivering the storage type will bid on the lease.

| Class Name | Throughput/Approx matching device |
| ---------- | --------------------------------- |
| beta1      | hdd                               |
| beta2      | ssd                               |
| beta3      | NVMe                              |

```
profiles:
  compute:
    grafana-profile:
      resources:
        cpu:
          units: 1
        memory:
          size: 1Gi
        storage:
          - size: 512Mi
          - name: data
            size: 1Gi
            attributes:
              persistent: true
              class: beta2
```

## Services Section

### Overview

Within the services > \<service-name> section a new params section is introduced and is meant to define service specific settings.  Currently only storage related settings are available in params.  Our review begins with an overview of the section and this is followed by a deep dive into the use of storage params.

```
services:
  postgres:
    image: postgres
    params:
      storage:
        data:
          mount: /var/lib/postgres
```

### Params

Note that params is an optional section under the greater services section.  Additionally note that non-persistent storage should not be defined in the params section.  In this example profile section, two storage profiles are created.  The no name ephemeral storage is not mentioned in the services > params definition.  However the persistent storage profile, named data, is defined within services > params.

```
profiles:
  compute:
    grafana-profile:
      resources:
        cpu:
          units: 1
        memory:
          size: 1Gi
        storage:
          - size: 512Mi
          - name: data
            size: 1Gi
            attributes:
              persistent: true
              class: beta3
```

### Storage

The persistent volume is mounted within the container’s local /var/lib/postgres directory.

```
     params:
      storage:
        default:
          mount: /var/lib/postgres
```

## Alternative Uses of Params Storage

### Default Name Use

In this example the params > storage section is defined for a storage profile using the default (no name explicitly defined) profile

#### _**Services Section**_

```
services:
  postgres:
    image: postgres/postgres
    params:
      storage:
        data:
          mount: /var/lib/postgres
```

#### **Profiles Section**

```
profiles:
  compute:
    grafana-profile:
      resources:
        cpu:
          units: 1
        memory:
          size: 1Gi
        storage:
          - size: 512Mi
          - size: 1Gi
            attributes:
              persistent: true
              class: beta3
```
