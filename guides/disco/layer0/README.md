# Layer 0

Layer 0 includes core infrastructure scripts for managing physical machines such as terraform and related scripts. Layer 0 is organized in **profiles**.

The default profile `packet` provisions a single node on Packet and configures the DNS using Cloudflare.

To add profile create a directory under `layer0` with the name of the profile and create a `Make` file with the below tasks:

```
layer0-init
layer0-plan
layer0-apply
layer0-destroy
```

## Commands

### Usage:

```shell
make layer0-<action>-[stack]
```

Examples:

- Initiallize default stack, `packet`:
    ```shell
    make layer0-init
    ```
- Initiallize `akash-packet` stack
    ```shell
    make layer0-init-akash-packet 
    ```

### Available Commands

```shell
make layer0-init
make layer0-plan
make layer0-apply
make layer0-destroy
```

## Provision Resources

### 1. Setup Credentials

```shell
# packet api keys in profile
echo $PACKET_TOKEN > data/db/keys/packet.api.token

# packet project id in project home URL
echo $PACKET_PROJECT_ID > data/db/keys/packet.project.id

## cloudflare api keys in profile
echo $CLOUDFLARE_API_TOKEN > data/db/keys/cloudflare.api.token
```

### 2.Provision Machines

```
make layer0-init
make layer0-apply
```

### 3. Update Config DB

```
echo node1.${MACHINE_ZONE} > data/db/index/HOSTS
```
