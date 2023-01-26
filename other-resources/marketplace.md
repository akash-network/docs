# Marketplace

Contents:

* [Overview](marketplace.md#overview)
* [Payments](marketplace.md#payments)
* [On-Chain Parameters](marketplace.md#on-chain-parameters)
* [Transactions](marketplace.md#transactions)
* [Models](marketplace.md#models)

## How does the Marketplace work?

The Akash Marketplace revolves around [Deployments](marketplace.md#deployment), which fully describe the resources that a tenant is requesting from the network. [Deployments](marketplace.md#deployment) contain [Groups](marketplace.md#group), which is a grouping of resources that are meant to be leased together from a single provider.

Deploying applications onto [Akash](https://github.com/ovrclk/akash) involves two types of users:

1. The **Tenant**: the entity that deploys the application.
2. The **Provider**: the entity that hosts the application.

### What is a Reverse Auction?

Akash uses a reverse auction. Tenants set the price and terms of their deployment, and the Cloud providers bid on the deployments.

In a very simple reverse auction:

1. A tenant creates orders.
2. Providers bid on orders.
3. Tenants choose winning bids and create leases.

A typical application deployment on Akash will follow this flow:

1. The tenant describes their desired deployment in \[SDL], called a [deployment](marketplace.md#deployment).
2. The tenant submits that definition to the blockchain.
3. Their submission generates an [order](marketplace.md#order) on the marketplace.
4. Providers that would like to fulfill that order [bid](marketplace.md#bid) on it.
5. After some period of time, a winning [bid](marketplace.md#bid) for the [order](marketplace.md#order) is chosen, and a [lease](marketplace.md#lease) is created.
6. Once a [lease](marketplace.md#lease) has been created, the tenant submits a [manifest](../readme/stack-definition-language.md) to the provider.
7. The provider executes workloads as instructed by the [manifest](../readme/stack-definition-language.md).
8. The workload is running - if it is a web application it can be visited
9. The provider or tenant eventually closes the [lease](marketplace.md#lease), shutting down the workload.

The general workflow is:

1. A tenant creates orders.
2. Providers bid on orders.
3. Tenants choose winning bids and create leases.

### Lifecycle of a Deployment

The lifecycle of a typical application deployment is as follows:

1. The tenant describes their desired deployment in \[SDL], called a [deployment](marketplace.md#deployment).
2. The tenant submits that definition to the blockchain.
3. Their submission generates an [order](marketplace.md#order) on the marketplace.
4. Providers that would like to fulfill that order [bid](marketplace.md#bid) on it.
5. After some period of time, a winning [bid](marketplace.md#bid) for the [order](marketplace.md#order) is chosen, and a [lease](marketplace.md#lease) is created.
6. Once a [lease](marketplace.md#lease) has been created, the tenant submits a [manifest](../readme/stack-definition-language.md) to the provider.
7. The provider executes workloads as instructed by the [manifest](../readme/stack-definition-language.md).
8. The workload is running - if it is a web application it can be visited
9. The provider or tenant eventually closes the [lease](marketplace.md#lease), shutting down the workload.

## Payments

Leases are paid from deployment owner (tenant) to the provider through a deposit & withdraw mechanism.

Tenants are required to submit a deposit when creating a deployment. Leases will be paid passively from the balance of this deposit. At any time, a lease provider may withdraw the balance owed to them from this deposit.

If the available funds in the deposit ever reaches zero, a provider may close the lease. A tenant can add funds to their deposit at any time. When a deployment is closed, the unspent portion of the balance will be returned to the tenant.

### Escrow Accounts

[Escrow accounts](escrow.md) are a mechanism that allow for time-based payments from one account to another without block-by-block micropayments. They also support holding funds for an account until an arbitrary event occurs.

Escrow accounts are necessary in akash for two primary reasons:

1. Leases in Akash are priced in blocks - every new block, a payment from the tenant (deployment owner) to the provider (lease holder) is due. Performance and security considerations prohibit the naive approach of transferring tokens on every block.
2. Bidding on an order should not be free (for various reasons, including performance and security). Akash requires a deposit for every bid. The deposit is returned to the bidder when the bid is closed.

## Bid Deposits

Bidding on an order requires a deposit to be made. The deposit will be returned to the provider account when the [bid](marketplace.md#bid) transitions to state `CLOSED`.

Bid deposits are implemented with an escrow account module. See [here](escrow.md) for more information.

## Audited Attributes

Audited attributes allow users deploying applications to be more selective about which providers can run their apps. Anyone on the Akash Network can assign these attributes to Providers via an on-chain transaction.

## On-Chain Parameters

| Name                     | Initial Value | Description                                        |
| ------------------------ | ------------- | -------------------------------------------------- |
| `deployment_min_deposit` | `5akt`        | Minimum deposit to make deployments. Target: \~$10 |
| `bid_min_deposit`        | `50akt`       | Deposit amount required to bid. Target: \~$100     |

## Transactions

### `DeploymentCreate`

Creates a [deployment](marketplace.md#deployment), and open [groups](marketplace.md#group) and [orders](marketplace.md#order) for it.

#### Parameters

| Name            | Description                                                    |
| --------------- | -------------------------------------------------------------- |
| `DeploymentID`  | ID of Deployment.                                              |
| `DepositAmount` | Deposit amount. Must be greater than `deployment_min_deposit`. |
| `Version`       | Hash of the manifest that is sent to the providers.            |
| `Groups`        | A list of [group](marketplace.md#group) descriptons.           |

### `DeploymentDeposit`

Add funds to a deployment's balance.

#### Parameters

| Name            | Description                                                   |
| --------------- | ------------------------------------------------------------- |
| `DeploymentID`  | ID of Deployment.                                             |
| `DepositAmount` | Deposit amount. Must be greater than `deployment_min_deposit` |

### `GroupClose`

Closes a [group](marketplace.md#group) and any [orders](marketplace.md#order) for it. Sent by the tenant.

#### Parameters

| Name | Description  |
| ---- | ------------ |
| `ID` | ID of Group. |

### `GroupPause`

Puts a `PAUSED` state, and closes any and [orders](marketplace.md#order) for it. Sent by the tenant.

#### Parameters

| Name | Description  |
| ---- | ------------ |
| `ID` | ID of Group. |

### `GroupStart`

Transitions a [group](marketplace.md#group) from state `PAUSED` to state `OPEN`. Sent by the tenant.

#### Parameters

| Name | Description  |
| ---- | ------------ |
| `ID` | ID of Group. |

### `BidCreate`

Sent by a provider to bid on an open [order](marketplace.md#order). The required deposit will be returned when the bid transitions to state `CLOSED`.

#### Parameters

| name      | description                                 |
| --------- | ------------------------------------------- |
| `OrderID` | ID of Order                                 |
| `TTL`     | Number of blocks this bid is valid for      |
| `Deposit` | Deposit amount. `bid_min_deposit` if empty. |

### `BidClose`

Sent by provider to close a bid or a lease from an existing bid.

When closing a lease, the bid's group will be put in state `PAUSED`.

#### Parameters

| name    | description |
| ------- | ----------- |
| `BidID` | ID of Bid   |

#### State Transitions

| Object | Previous State | New State |
| ------ | -------------- | --------- |
| Bid    | `ACTIVE`       | `CLOSED`  |
| Lease  | `ACTIVE`       | `CLOSED`  |
| Order  | `ACTIVE`       | `CLOSED`  |
| Group  | `OPEN`         | `PAUSED`  |

### `LeaseCreate`

Sent by tenant to create a lease.

1. Creates a `Lease` from the given [bid](marketplace.md#bid).
2. Sets all non-winning [bids](marketplace.md#bid) to state `CLOSED` (deposit returned).

#### Parameters

| name    | description                                      |
| ------- | ------------------------------------------------ |
| `BidID` | [Bid](marketplace.md#bid) to create a lease from |

### `MarketWithdraw`

This withdraws balances earned by providing for leases and deposits of bids that have expired.

#### Parameters

| name    | description                        |
| ------- | ---------------------------------- |
| `Owner` | Provider ID to withdraw funds for. |

## Models

### Deployment

| Name       | Description                                                                         |
| ---------- | ----------------------------------------------------------------------------------- |
| `ID.Owner` | account addres of tenant                                                            |
| `ID.DSeq`  | Arbitrary sequence number that identifies the deployment. Defaults to block height. |
| `State`    | State of the deployment.                                                            |
| `Version`  | Hash of the manifest that is sent to the providers.                                 |

#### State

| Name     | Description                      |
| -------- | -------------------------------- |
| `OPEN`   | Orders may be created.           |
| `CLOSED` | All groups are closed. Terminal. |

### Group

| Name              | Description                                                         |
| ----------------- | ------------------------------------------------------------------- |
| `ID.DeploymentID` | [Deployment](marketplace.md#deployment) ID of group.                |
| `ID.GSeq`         | Arbitrary sequence number. Internally incremented, starting at `1`. |
| `State`           | State of the group.                                                 |

#### State

| Name     | Description                               |
| -------- | ----------------------------------------- |
| `OPEN`   | Has an open or active order.              |
| `PAUSED` | Bid closed by provider. May be restarted. |
| `CLOSED` | No open or active orders. Terminal.       |

### Order

| Name         | Description                                                         |
| ------------ | ------------------------------------------------------------------- |
| `ID.GroupID` | [Group](marketplace.md#group) ID of group.                          |
| `ID.OSeq`    | Arbitrary sequence number. Internally incremented, starting at `1`. |
| `State`      | State of the order.                                                 |

#### State

| Name     | Description                                        |
| -------- | -------------------------------------------------- |
| `OPEN`   | Accepting bids.                                    |
| `ACTIVE` | Open lease has been created.                       |
| `CLOSED` | No active leases and not accepting bids. Terminal. |

### Bid

| Name          | Description                                                |
| ------------- | ---------------------------------------------------------- |
| `ID.OrderID`  | [Group](marketplace.md#group) ID of group.                 |
| `ID.Provider` | Account address of provider.                               |
| `State`       | State of the bid.                                          |
| `EndsOn`      | Height at which the bid ends if it is not already matched. |
| `Price`       | Bid price - amount to be paid on every block.              |

#### State

| Name     | Description                              |
| -------- | ---------------------------------------- |
| `OPEN`   | Awaiting matching.                       |
| `ACTIVE` | Bid for an active lease (winner).        |
| `CLOSED` | No active leases for this bid. Terminal. |

### Lease

| Name    | Description                                                 |
| ------- | ----------------------------------------------------------- |
| `ID`    | The same as the [bid](marketplace.md#bid) ID for the lease. |
| `State` | State of the bid.                                           |

#### State

| Name     | Description                                              |
| -------- | -------------------------------------------------------- |
| `ACTIVE` | Active lease - tenant is paying provider on every block. |
| `CLOSED` | No payments being made. Terminal.                        |
