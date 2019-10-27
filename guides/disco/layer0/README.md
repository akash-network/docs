# Layer 0

Core Infrastructure scripts for managing physical machines. This module includes terraform and related scripts.

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
