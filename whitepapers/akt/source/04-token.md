# AKT: The Akash Network Token

The primary functions of AKT are in staking (which provides security to the network), lease settlement, and in acting as a unit of measure for pricing all currencies supported by the marketplace. Although AKT can be used for settling transactions in the marketplace, the leases can be settled using a multitude of tokens as described in later sections of this paper. However, transaction fees and block rewards are denominated in AKT. The income stakers earn is proportional to the tokens staked and length of staking commitment. That said, AKT performs three main functions: Resolve, Reward, and Reserve.

## Resolve
Akash relies on a blockchain where a set of validators vote on proposals. Each proposal is weighed by the proposer’s voting power, which is the total tokens they staked and the tokens bonded to them (stakers can delegate voting power to validators).

## Reward
Users of AKT stake tokens to subsidize operating and capital expenditures. Stakers are rewarded proportional to the number of tokens staked, the length of lockup time, and the overall tokens staked in the system. Lock up times can vary anywhere from one month to one year. Flexibility in lockup encourages stakers that stake for shorter periods (bear markets), in a self-adjusting inflationary system that is designed to optimize for lower price pressure during bear markets.

## Reserve
Fees on Akash can be settled using a multitude of currencies along with AKT, however, the market order book uses Akash Token (AKT) as the reserve currency of the ecosystem. AKT provides a novel settlement option to lock in an exchange rate between AKT and the settlement currency. This way, providers and tenants are protected from the price volatility of AKT expected to result from its low liquidity. In this section, we also present a mechanism “Transaction Ordering using Consensus Weighted Median” as described in [@sec:txordering] to establish exchange rates without the need for an oracle.

# Settlement and Fees {#sec:settlement}

This section describes various fees the incurred by users of Akash Network.

## Take Fee {#sec:take-fee}

For every successful lease, a portion of the lease amount (*Take Fee*) goes to a *Take Income Pool*. The Take Income Pool is later distributed to stakers based on their stake weight (amount staked and time remaining to unlock, described in detail in the following sections). The *Take Rate* depends on currency used for settlement. The proposed take rates at Genesis when using AKT (`TokenTakeRate`) is *10%* and *20%* when any other currency(`TakeRate`) is used. The `TokenTakeRate` and `TakeRate` parameters is subject to community consensus managed by the governance.

## Settlement with Exchange Rate Lockin

The lease fees are denominated in AKT, but they can be settled using any whitelisted tokens. There is an option to lock in an exchange rate between AKT and the settlement currency. This way providers and tenants are protected from the price volatility of AKT expected to result from its low liquidity.

For example, suppose a lease is set to $10~AKTs$ and locks an exchange rate of $1~AKT = 0.2~BTC$. If the price of AKT doubles, i.e., $1~AKT = 0.4~BTC$, the tenant is required to pay $5~AKT$. Conversely, if the price of BTC doubles while keeping the price of AKT same, i.e., $1~AKT = 0.1~BTC$, then the tenant is required to pay $20~AKT$.

## Fees Using a Multitude of Tokens

In order to avoid issues of network abuse (e.g. DOS attacks), all transactions and leases on Akash are subject to fees. Every transaction has a specific associated fee, `GasLimit`, for processing the transaction, as long as it does not exceed `BlockGasLimit.`

The `GasLimit` is the amount of gas which is deducted from the sender’s account balance to issue a transaction.

Unlike most other blockchain platforms, such as Ethereum [@ethereum], Bitcoin [@bitcoin], and Neo [@neo], Akash accepts a multitude of tokens for fees, whereas the mentioned platforms require fees to be paid in the platform's native cryptocurrency. Each validator and provider on Akash can choose to accept any currency or a combination of currencies as fees.

The resulting transaction fees, minus a network tax that goes into a reserve pool, are split among validators and delegators based on their stake (amount and length).

## Transaction Ordering using Consensus Weighted Median {#sec:txordering}

In order to prioritize transactions when multiple tokens are used, validators need a mechanism to determine the *relative value* of the transaction fee. For example, let us assume we had a perfect oracle to inform us that the relative value of BTC is 200 AKT, and that of ETH is 0.4 AKT. Suppose we have two transactions of equal gas cost, and the transaction fees on them are 10 BTC and 6000 ETH, respectively. The first transaction's fee is equivalent to 2000 (10 x 200) AKT and the second transaction's fee is equivalent to 2400 (6000 x 0.4) AKT. Then the second transaction will have a higher priority.

In order to get these relative values without using an oracle, we can employ a *Consensus Weighted Median using Localized Validator Configuration* [@cosmosEcon] mechanism.

In this method, each validator maintains a local view of the relative values of the tokens in a config file which is periodically updated, and the relative value is achieved by using a weighted mean, meaning they submit their "votes" for the value of each token on-chain as a transaction.

Lets say for example, there are five validators $\{A,B,C,D,E$} with powers $\{0.3,0.3,0.1,0.1,0.2\}$ respectively. They submit the following votes for their personal views of each token:

$\mathbf{A}: \mathsf{AKT} = 1, \mathsf{BTC} = 0.2$

$\mathbf{B}: \mathsf{AKT} = 2, \mathsf{BTC} = 0.4$

$\mathbf{C}: \mathsf{AKT} = 12, \mathsf{BTC} = 2$

$\mathbf{D}: \mathsf{AKT} = 4, \mathsf{BTC} = 1$

$\mathbf{E}: \mathsf{AKT} = 1.5, \mathsf{BTC} = 0.5$

These values are stored on-chain in a ordered list along with their validator that placed the vote.

$\mathsf{AKT}: [1_\mathbf{A},1.5_\mathbf{E},2_\mathbf{B},4_\mathbf{D},12_\mathbf{C}]$

$\mathsf{BTC}: [0.2_\mathbf{A},0.4_\mathbf{B},0.5_\mathbf{E},1_\mathbf{D},2_\mathbf{C}]$

The proposer takes a weighted mean (by stake) of the votes for each whitelisted token to determine a consensus relative value of each token, where $\bar{w}(x_n) = WeightedMean(x_n)$ :

$\mathsf{AKT}: \bar{w}([1,0.3],[1.5,0.2],[2,0.3],[4,0.1],[12,0.1])$

$\mathsf{BTC}: \bar{w}([0.2,0.3],[0.4,0.2],[0.5,0.2],[1,0.1],[2,0.2])$

which give us the relative value for each token: $\mathsf{AKT}= 2.8$ and $\mathsf{BTC}= 0.58$ respectively.

## Maker and Taker Fee Schedule

Leasing compute is either zero-fee or for a small fee, depending on the user's activity in the last 30 days. Lease fees have a distinction of a `Maker` fee or a `Taker` fee. A ***taker fee*** is paid when you add computing capacity to Akash network by fulfilling an order in the order book when the lease is created. A ***maker fee*** is paid when you request computing capacity from Akash by placing an order in the book when the lease is created.

For a lease $l$, the *aggregate trade activity factor* of the stakeholder of the lease for a given time $t$ is defined by:

$$
\kappa_l = \frac{\sum_{t=1}^{T_a} l(1-t)}{\sum_{t=1}^{T_a} L(1-t)},
$$

where $L(t)$ is the aggregate trade activity of the network and ${T_a = 30~days}$.

Assuming that $\mathcal{P}_l = 0.5$ is the *fee distribution factor*, the maker fee $R_{mk}(l)$ will be:

$$
R_{mk}(l)
=
\frac{10^{1 - 4\mathcal{P}_{l}}}
{\log(10^{4\mathcal{P}_{l}})}
\cdot
\log \left(\frac{\mathcal{P}_l}{\min (\kappa_{l},\mathcal{P}_l)}\right),
$$

and the taker fee $R_{tk}(l)$ will be:

$$
R_{tk}(l)
=
\frac{10^{1 - \frac{7\mathcal{P}_l}{2}}}
{\log\left({10^\frac{7\mathcal{P}_l}{2}}\right)}
\cdot
\log \left(\frac{\mathcal{P}_l}{\min (\kappa_{l},\mathcal{P}_l)}\right).
$$
