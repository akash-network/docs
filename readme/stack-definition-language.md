# Stack Definition Language (SDL)

Customers / tenants define the deployment services, datacenters, requirements, and pricing parameters, in a "manifest" file (deploy.yaml). The file is written in a declarative language called Software Definition Language (SDL). SDL is a human friendly data standard for declaring deployment attributes. The SDL file is a "form" to request resources from the Network. SDL is compatible with the [YAML](http://www.yaml.org/start.html) standard and similar to Docker Compose files.

Configuration files may end in `.yml` or `.yaml`.

A complete deployment has the following sections:

* [version](stack-definition-language.md#version)
* [services](stack-definition-language.md#services)
* [profiles](stack-definition-language.md#profiles)
* [deployment](stack-definition-language.md#deployment)
* [persistent storage](../features/persistent-storage/)

An example deployment configuration can be found [here](https://github.com/ovrclk/docs/tree/62714bb13cfde51ce6210dba626d7248847ba8c1/sdl/deployment.yaml).

#### Networking

Networking - allowing connectivity to and between workloads - can be configured via the Stack Definition Language (SDL) file for a deployment. By default, workloads in a deployment group are isolated - nothing else is allowed to connect to them. This restriction can be relaxed.

## version

Indicates version of Akash configuration file. Currently only `"2.0"` is accepted.

## services

The top-level `services` entry contains a map of workloads to be ran on the Akash deployment. Each key is a service name; values are a map containing the following keys:

| Name         | Required | Meaning                                                                                                                                                          |
| ------------ | -------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `image`      | Yes      | <p>Docker image of the container<br><br>Best practices:</p><ul><li>avoid using <code>:latest</code> image tags as Akash Providers heavily cache images</li></ul> |
| `depends-on` | No       | _**NOTE - field is marked for future use and currently has no impact on deployments.**_                                                                          |
| `command`    | No       | Custom command use when executing container                                                                                                                      |
| `args`       | No       | Arguments to custom command use when executing the container                                                                                                     |
| `env`        | No       | Environment variables to set in running container. See [services.env](stack-definition-language.md#services.env)                                                 |
| `expose`     | No       | Entities allowed to connect to the services. See [services.expose](stack-definition-language.md#services.expose)                                                 |

### services.env

A list of environment variables to expose to the running container.

```yaml
env:
  - API_KEY=0xcafebabe
  - CLIENT_ID=0xdeadbeef
```

### services.expose

#### Notes Regarding Port Use in the Expose Stanza

* HTTPS is possible in Akash deployments but only self signed certs are generated.
* To implement signed certs the deployment must be front ended via a solution such as Cloudflare.  If interested in this path, we have created docs for [Cloudflare with Akash](../deploy/tls-termination-of-akash-deployments/).
* You can expose any other port besides 80 as the ingress port (HTTP, HTTPS) port using as: 80 directive if the app understands HTTP / HTTPS.  Example of exposing a React web app using this method:

```
      - port: 3000
        as: 80
        to:
          - global: true
        accept:
          - www.mysite.com
```

* In the SDL it is only necessary to expose port 80 for web apps. With this specification both ports 80 and 443 are exposed.

`expose` is a list describing what can connect to the service. Each entry is a map containing one or more of the following fields:

| Name     | Required | Meaning                                                                                                        |
| -------- | -------- | -------------------------------------------------------------------------------------------------------------- |
| `port`   | Yes      | Container port to expose                                                                                       |
| `as`     | No       | Port number to expose the container port as                                                                    |
| `accept` | No       | List of hosts to accept connections for                                                                        |
| `proto`  | No       | Protocol type (`tcp, udp, or http`)                                                                            |
| `to`     | No       | List of entities allowed to connect. See [services.expose.to](stack-definition-language.md#services.expose.to) |

The `as` value governs the default `proto` value as follows:

> _**NOTE**_ - when as is not set, it will default to the value set by the port mandatory directive.

> _**NOTE**_ - when one exposes as: 80 (HTTP), the Kubernetes ingress controler makes the application available over HTTPS as well, though with the default self-signed ingress certs.

| `port`     | `proto` default |
| ---------- | --------------- |
| 80         | http, https     |
| all others | tcp             |

### services.expose.to

`expose.to` is a list of clients to accept connections from. Each item is a map with one or more of the following entries:

| Name      | Value                        | Default | Description                                               |
| --------- | ---------------------------- | ------- | --------------------------------------------------------- |
| `service` | A service in this deployment |         | Allow the given service to connect                        |
| `global`  | `true` or `false`            | `false` | If true, allow connections from outside of the datacenter |

If no service is given and `global` is true, any client can connect from anywhere (web servers typically want this).

If a service name is given and `global` is `false`, only the services in the current datacenter can connect. If a service name is given and `global` is `true`, services in other datacenters for this deployment can connect.

If `global` is `false` then a service name must be given.

## profiles

The `profiles` section contains named compute and placement profiles to be used in the [deployment](stack-definition-language.md#deployment).

### profiles.compute

`profiles.compute` is map of named compute profiles. Each profile specifies compute resources to be leased for each service instance uses uses the profile.

Example:

This defines a profile named `web` having resource requirements of 2 vCPUs, 2 gigabytes of memory, and 5 gigabytes of storage space available.

```yaml
web:
  cpu: 2
  memory: "2Gi"
  storage: "5Gi"
```

`cpu` units represent a vCPU share and can be fractional. When no suffix is present the value represents a fraction of a whole CPU share. With a `m` suffix, the value represnts the number of milli-CPU shares (1/1000 of a CPU share).

Example:

| Value    | CPU-Share |
| -------- | --------- |
| `1`      | 1         |
| `0.5`    | 1/2       |
| `"100m"` | 1/10      |
| `"50m"`  | 1/20      |

`memory`, `storage` units are described in bytes. The following suffixes are allowed for simplification:

| Suffix | Value  |
| ------ | ------ |
| `k`    | 1000   |
| `Ki`   | 1024   |
| `M`    | 1000^2 |
| `Mi`   | 1024^2 |
| `G`    | 1000^3 |
| `Gi`   | 1024^3 |
| `T`    | 1000^4 |
| `Ti`   | 1024^4 |
| `P`    | 1000^5 |
| `Pi`   | 1024^5 |
| `E`    | 1000^6 |
| `Ei`   | 1024^6 |

### profiles.placement

`profiles.placement` is map of named datacenter profiles. Each profile specifies required datacenter attributes and pricing configuration for each [compute profile](stack-definition-language.md#profiles.compute) that will be used within the datacenter. It also specifies optional list of signatures of which tenants expects audit of datacenter attributes.

Example:

```yaml
westcoast:
  attributes:
    region: us-west
  signedBy:
    allOf:
      - "akash1vz375dkt0c60annyp6mkzeejfq0qpyevhseu05"
    anyOf:
      - "akash1vl3gun7p8y4ttzajrtyevdy5sa2tjz3a29zuah"
  pricing:
    web:
      denom: uakt
      amount: 8
    db:
      denom: uakt
      amount: 100
```

This defines a profile named `westcoast` having required attributes `{region="us-west"}`, and with a max price for the `web` and `db` [compute profiles](stack-definition-language.md#profiles.compute) of 8 and 15 `uakt` per block, respectively. It also requires that the provider's attributes have been [signed by](stack-definition-language.md#profiles.placement.signedby) the accounts `akash1vz375dkt0c60annyp6mkzeejfq0qpyevhseu05` and `akash1vl3gun7p8y4ttzajrtyevdy5sa2tjz3a29zuah`.

### profiles.placement.signedBy

**Optional**

The `signedBy` section allows you to state attributes that must be signed by one or more accounts of your choosing. This allows for requiring a third-party certification of any provider that you deploy to.

## deployment

The `deployment` section defines how to deploy the services. It is a mapping of service name to deployment configuration.

Each service to be deployed has an entry in the `deployment`. This entry is maps datacenter profiles to [compute profiles](stack-definition-language.md#profiles.compute) to create a final desired configuration for the resources required for the service.

Example:

```yaml
web:
  westcoast:
    profile: web
    count: 20
```

This says that the 20 instances of the `web` service should be deployed to a datacenter matching the `westcoast` datacenter profile. Each instance will have the resources defined in the `web` [compute profile](stack-definition-language.md#profiles.compute) available to it.
