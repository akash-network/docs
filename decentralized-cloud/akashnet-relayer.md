# Inter-Blockchain Connections \(IBC\)

This guide will give you information about IBC connections between Akashnet-2 and other Cosmos SDK based networks.

Please check [relayer repo](https://github.com/cosmos/relayer) for installation and starting relayer instructions.

Below tables represent information of path config with client, connection and channel identifiers between `akashnet-2` and other network.

You can add path between two chains using relayer by running this command:

```bash
rly paths add [src-chain-id] [dst-chain-id] [path-name]
```

And it will prompt for path config values. Please enter below values based on destination chain with `akashnet-2`.

## akashnet-2 &lt;&gt; cosmoshub-4 \(Akash Network and Cosmos Hub\)

Here source chain is `akashnet-2` and destination chain is `cosmoshub-4`.

| Key | Value | Description |
| :--- | :--- | :--- |
| `chain-id` | akashnet-2 | Chain-ID of source chain. |
| `client-id` | 07-tendermint-14 | Client-ID of source chain. |
| `connection-id` | connection-7 | Connection-ID of source chain. |
| `channel-id` | channel-5 | Channel-ID of source chain. |
| `port-id` | transfer | Port-ID of source chain. |
| `order` | unordered | Order of source chain. |
| `version` | ics20-1 | Version of source chain. |
| `chain-id` | cosmoshub-4 | Chain-ID of destination chain. |
| `client-id` | 07-tendermint-180 | Client-ID of destination chain. |
| `connection-id` | connection-219 | Connection-ID of destination chain. |
| `channel-id` | channel-116 | Channel-ID of destination chain. |
| `port-id` | transfer | Port-ID of destination chain. |
| `order` | unordered | Order of destination chain. |
| `version` | ics20-1 | Version of destination chain. |
| `strategy.type` | naive | Strategy type of path. |

Above path config values in `yaml` format:

```text
    src:
      chain-id: akashnet-2
      client-id: 07-tendermint-14
      connection-id: connection-7
      channel-id: channel-5
      port-id: transfer
      order: unordered
      version: ics20-1
    dst:
      chain-id: cosmoshub-4
      client-id: 07-tendermint-180
      connection-id: connection-219
      channel-id: channel-116
      port-id: transfer
      order: unordered
      version: ics20-1
    strategy:
      type: naive
```

## akashnet-2 &lt;&gt; core-1 \(Akash Network and Persistence Network\)

Here source chain is `akashnet-2` and destination chain is `core-1`.

| Key | Value | Description |
| :--- | :--- | :--- |
| `chain-id` | akashnet-2 | Chain-ID of source chain. |
| `client-id` | 07-tendermint-15 | Client-ID of source chain. |
| `connection-id` | connection-8 | Connection-ID of source chain. |
| `channel-id` | channel-6 | Channel-ID of source chain. |
| `port-id` | transfer | Port-ID of source chain. |
| `order` | unordered | Order of source chain. |
| `version` | ics20-1 | Version of source chain. |
| `chain-id` | cosmoshub-4 | Chain-ID of destination chain. |
| `client-id` | 07-tendermint-5 | Client-ID of destination chain. |
| `connection-id` | connection-4 | Connection-ID of destination chain. |
| `channel-id` | channel-5 | Channel-ID of destination chain. |
| `port-id` | transfer | Port-ID of destination chain. |
| `order` | unordered | Order of destination chain. |
| `version` | ics20-1 | Version of destination chain. |
| `strategy.type` | naive | Strategy type of path. |

Above path config values in `yaml` format:

```text
    src:
      chain-id: akashnet-2
      client-id: 07-tendermint-15
      connection-id: connection-8
      channel-id: channel-6
      port-id: transfer
      order: unordered
      version: ics20-1
    dst:
      chain-id: core-1
      client-id: 07-tendermint-5
      connection-id: connection-4
      channel-id: channel-5
      port-id: transfer
      order: unordered
      version: ics20-1
    strategy:
      type: naive
```

