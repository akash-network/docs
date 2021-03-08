# Marketplace

* [Overview](marketplace.md#overview)
* [Payments](marketplace.md#payments)
* [On-Chain Parameters](marketplace.md#on-chain-parameters)
* [Transactions](marketplace.md#transactions)
* [Models](marketplace.md#models)

The Akash Marketplace is an auction for compute resources. It is the mechanism by which users acquire resources on the Akash Platform.

## Overview

The Akash Marketplace revolves around [Deployments](marketplace.md#deployment), which fully describe the resources that a tenant is requesting from the network. [Deployments](marketplace.md#deployment) contain [Groups](marketplace.md#group), which is a grouping of resources that are meant to be leased together from a single provider.

The general workflow is:

1. A tenant creates orders.
2. Providers bid on orders.
3. Tenants choose winning bids and create leases.

## Payments

Leases are paid from deployment owner \(tenant\) to the provider through a deposit & withdraw mechanism.

Tenants are required to submit a deposit when creating a deployment. Leases will be paid passively from the balance of this deposit. At any time, a lease provider may withdraw the balance owed to them from this deposit.

If the available funds in the deposit ever reaches zero, a provider may close the lease.

A tenant can add funds to their deposit at any time.

When a deployment is closed, the unspent portion of the balance will be returned to the tenant.

Payments are implemented with an escrow account module. See [here](escrow.md) for more information.

## Bid Deposits

Bidding on an order requires a deposit to be made. The deposit will be returned to the provider account when the [bid](marketplace.md#bid) transitions to state `CLOSED`.

Bid deposits are implemented with an escrow account module. See [here](escrow.md) for more information.

## On-Chain Parameters

| Name | Initial Value | Description |
| :--- | :--- | :--- |
| `deployment_min_deposit` | `10akt` | Minimum deposit to make deployments.  Target: ~$10 |
| `bid_min_deposit` | `100akt` | Deposit amount required to bid.  Target: ~$100 |

## Transactions

### `DeploymentCreate`

Creates a [deployment](marketplace.md#deployment), and open [groups](marketplace.md#group) and [orders](marketplace.md#order) for it.

#### Parameters

| Name | Description |
| :--- | :--- |
| `DeploymentID` | ID of Deployment. |
| `DepositAmount` | Deposit amount.  Must be greater than `deployment_min_deposit`. |
| `Version` | Hash of the manifest that is sent to the providers. |
| `Groups` | A list of [group](marketplace.md#group) descriptons. |

### `DeploymentDeposit`

Add funds to a deployment's balance.

#### Parameters

| Name | Description |
| :--- | :--- |
| `DeploymentID` | ID of Deployment. |
| `DepositAmount` | Deposit amount.  Must be greater than `deployment_min_deposit` |

### `GroupClose`

Closes a [group](marketplace.md#group) and any [orders](marketplace.md#order) for it. Sent by the tenant.

#### Parameters

| Name | Description |
| :--- | :--- |
| `ID` | ID of Group. |

### `GroupPause`

Puts a `PAUSED` state, and closes any and [orders](marketplace.md#order) for it. Sent by the tenant.

#### Parameters

| Name | Description |
| :--- | :--- |
| `ID` | ID of Group. |

### `GroupStart`

Transitions a [group](marketplace.md#group) from state `PAUSED` to state `OPEN`. Sent by the tenant.

#### Parameters

| Name | Description |
| :--- | :--- |
| `ID` | ID of Group. |

### `BidCreate`

Sent by a provider to bid on an open [order](marketplace.md#order). The required deposit will be returned when the bid transitions to state `CLOSED`.

#### Parameters

| name | description |
| :--- | :--- |
| `OrderID` | ID of Order |
| `TTL` | Number of blocks this bid is valid for |
| `Deposit` | Deposit amount.  `bid_min_deposit` if empty. |

### `BidClose`

Sent by provider to close a bid or a lease from an existing bid.

When closing a lease, the bid's group will be put in state `PAUSED`.

#### Parameters

| name | description |
| :--- | :--- |
| `BidID` | ID of Bid |

#### State Transitions

| Object | Previous State | New State |
| :--- | :--- | :--- |
| Bid | `ACTIVE` | `CLOSED` |
| Lease | `ACTIVE` | `CLOSED` |
| Order | `ACTIVE` | `CLOSED` |
| Group | `OPEN` | `PAUSED` |

### `LeaseCreate`

Sent by tenant to create a lease.

1. Creates a `Lease` from the given [bid](marketplace.md#bid).
2. Sets all non-winning [bids](marketplace.md#bid) to state `CLOSED` \(deposit returned\).

#### Parameters

| name | description |
| :--- | :--- |
| `BidID` | [Bid](marketplace.md#bid) to create a lease from |

### `MarketWithdraw`

This withdraws balances earned by providing for leases and deposits of bids that have expired.

#### Parameters

| name | description |
| :--- | :--- |
| `Owner` | Provider ID to withdraw funds for. |

## Models

### Deployment

| Name | Description |
| :--- | :--- |
| `ID.Owner` | account addres of tenant |
| `ID.DSeq` | Arbitrary sequence number that identifies the deployment.  Defaults to block height. |
| `State` | State of the deployment. |
| `Version` | Hash of the manifest that is sent to the providers. |

#### State

| Name | Description |
| :--- | :--- |
| `OPEN` | Orders may be created. |
| `CLOSED` | All groups are closed. Terminal. |

### Group

| Name | Description |
| :--- | :--- |
| `ID.DeploymentID` | [Deployment](marketplace.md#deployment) ID of group. |
| `ID.GSeq` | Arbitrary sequence number.  Internally incremented, starting at `1`. |
| `State` | State of the group. |

#### State

| Name | Description |
| :--- | :--- |
| `OPEN` | Has an open or active order. |
| `PAUSED` | Bid closed by provider.  May be restarted. |
| `CLOSED` | No open or active orders.  Terminal. |

### Order

| Name | Description |
| :--- | :--- |
| `ID.GroupID` | [Group](marketplace.md#group) ID of group. |
| `ID.OSeq` | Arbitrary sequence number.  Internally incremented, starting at `1`. |
| `State` | State of the order. |

#### State

| Name | Description |
| :--- | :--- |
| `OPEN` | Accepting bids. |
| `ACTIVE` | Open lease has been created. |
| `CLOSED` | No active leases and not accepting bids. Terminal. |

### Bid

| Name | Description |
| :--- | :--- |
| `ID.OrderID` | [Group](marketplace.md#group) ID of group. |
| `ID.Provider` | Account address of provider. |
| `State` | State of the bid. |
| `EndsOn` | Height at which the bid ends if it is not already matched. |
| `Price` | Bid price - amount to be paid on every block. |

#### State

| Name | Description |
| :--- | :--- |
| `OPEN` | Awaiting matching. |
| `ACTIVE` | Bid for an active lease \(winner\). |
| `CLOSED` | No active leases for this bid. Terminal. |

### Lease

| Name | Description |
| :--- | :--- |
| `ID` | The same as the [bid](marketplace.md#bid) ID for the lease. |
| `State` | State of the bid. |

#### State

| Name | Description |
| :--- | :--- |
| `ACTIVE` | Active lease - tenant is paying provider on every block. |
| `CLOSED` | No payments being made. Terminal. |

