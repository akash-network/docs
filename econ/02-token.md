# The Akash Token Model

## Native Token (AKT)

The primary utility for AKT is staking (providing security to the network) and act as a base denominator for the marketplace. Although AKT can be used for settlement in marketplace, it is not intended to be used to pay a fee or used as a currency because of the highly illiquid nature. AKT however gives you the ability to earn transaction fees and the block rewards. The income stakers generate is proportional to the tokens staked and length of staking commitment.

## Settlement & Price Volatility Protection

The lease fee is denominated in AKT tokens but can be settled using any whitelisted tokens along with an option to lock-in an exchange rate between AKT and settlement currency. This way providers and tenants are protected from the price volatility of AKT (considering AKT will be increasing illiquid due to earning potential from staking rewards)

For example, if the lease is set to $10~AKTs$ and locks an exchange rate of $1~AKT = 0.2~BTC$. If the price of AKT doubles, i.e., $1~AKT = 0.4~BTC$, the tenant is required to pay $5~AKT$. Conversely, if the price of BTC doubles while keeping the price of AKT same, i.e., $1~AKT = 0.1~BTC$, then the tenant is required to pay $20~AKT$.
		
## Fees using Multitude of Tokens

In order to avoid issues of network abuse (spam), all *transactions* and *leases* on Akash are subject to a fee. Every transaction has a specific amount of gas associated with it: `GasLimit` for processing the transaction as long as it does not exceed `BlockGasLimit.`

The `GasLimit` is the amount of gas which is implicitly purchased from the sender’s account balance. All leases (purchases) require the tenant (buyer) to pay `TakeFee` and the seller (provider) to pay a `MakeFee.` 

Unlike, most other platforms such as ETH in Ethereum [@ethereum], BTC in Bitcoin [@bitcoin], and GAS in Neo [@neo], Akash accepts a multitude of tokens for fees. Each validator and provider on Akash can choose to accept any currency or a combination of currencies as fees.

Resulting transaction fees, minus a network tax that goes into a reserve pool are split among validators and delegators based on their stake (amount and length).

## Transaction Ordering using Consensus Weighted Median

In order to prioritize transactions, validators need a mechanism to determine the *relative value* of the transaction fee (when multiple tokens are used). For example, let us assume we had a perfect oracle to inform us of a relative value of BTC is 200, and ETH is 0.4. Let us say, we have two transactions of equal gas cost, and the transaction fee on them are 10 BTC and 6000 ETH. The first transaction's fee is worth 2000 (10 x 200) and the second transaction's value will be 2400 (6000 x 0.4). Then, the second transaction will have a higher priority.

In order to get these relative values with out using an oracle, we can employ a *Consensus Weighted Median using Localized Validator Configuration* [@cosmosEcon] mechanism.

In this method, each validator maintains a local view of the relative values of the tokens (in a config file that is periodically updated) and the relative value is achieved by using a weighted mean, meaning they submit their "votes" for the value of each token on-chain as a transaction.

Lets say for example, there are five validators $\{A,B,C,D,E$} with powers $\{0.3,0.3,0.1,0.1,0.2\}$ respectively. They submit the following votes for their personal views of each token:

$\mathbf{A}: \mathsf{AKT} = 1, \mathsf{BTC} = 0.2$

$\mathbf{B}: \mathsf{AKT} = 2, \mathsf{BTC} = 0.4$

$\mathbf{C}: \mathsf{AKT} = 12, \mathsf{BTC} = 2$

$\mathbf{D}: \mathsf{AKT} = 4, \mathsf{BTC} = 1$

$\mathbf{E}: \mathsf{AKT} = 1.5, \mathsf{BTC} = 0.5$

These values are stored on-chain in a ordered list along with their validator that placed the vote.

$\mathsf{AKT}: [1_\mathbf{A},1.5_\mathbf{E},2_\mathbf{B},4_\mathbf{D},12_\mathbf{C}]$

$\mathsf{BTC}: [0.2_\mathbf{A},0.4_\mathbf{B},0.5_\mathbf{E},1_\mathbf{D},2_\mathbf{C}]$

The proposer takes a weighted mean  (by stake) of the votes for each fee token to determined an in-consensus relative value of each token, where $\bar{w}(x_n) = WeightedMean(x_n)$ :

$\mathsf{AKT}: \bar{w}([1,0.3],[1.5,0.2],[2,0.3],[4,0.1],[12,0.1])$

$\mathsf{BTC}: \bar{w}([0.2,0.3],[0.4,0.2],[0.5,0.2],[1,0.1],[2,0.2])$

which give us the relative value for each token: $\mathsf{AKT}= 2.8$ and $\mathsf{BTC}= 0.58$ respectively.

## Maker and Taker Fee Schedule

Leasing compute is either zero-fee or a small fee depending on the user's activity in the last 30 days. Lease fees have a distinction of a `Maker` fee or a `Taker` fee. A ***maker fee*** is paid when you add computing capacity to Akash network by fulfilling an order in the order book when the lease is created. A ***taker fee*** is paid when you remove computing capacity from Akash by placing an order in the book when the lease is created.

For a lease $l$, the *aggregate trade activity factor* of the a stakeholder of the lease for a  given time $t$ is defined by:

$$
\kappa_l = \frac{\sum_{t=1}^{T_a} l(1-t)}{\sum_{t=1}^{T_a} L(1-t)},
$$

where $L(t)$ is the aggregate trade activity of the network and ${T_a = 30~days}$. 

Given, $\mathcal{P}_l = 0.5$ is the *fee distribution factor*, for that, the maker fee $R_{mk}(l)$ will be:

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
