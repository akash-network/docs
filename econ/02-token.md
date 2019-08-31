# The Akash Token Model

## Staking Token (AKT)

The primary utility for AKT is staking (providing security to the network) (similar to Atom token at Cosmos[@cosmosEcon]). Although AKT can be used in the marketplace (and elsewhere), it is not intended to be used to pay a fee or used as a currency and thus give you the ability to earn transaction fees and the block rewards. The income stakers generate is proportional to the tokens staked and length of staking commitment. 
		
## Transaction Fees using Multitude of Tokens

In order to avoid issues of network abuse (spam), all `transactions` and `leases` on Akash are subject to a fee. Every transaction has a specific amount of gas associated with it: `GasLimit` for processing the transaction as long as it does not exceed `BlockGasLimit.`  

The `GasLimit` is the amount of gas which is implicitly purchased from the sender’s account balance. All leases (purchases) require the tenant (buyer) to pay `TakeFee` and the seller (provider) to pay a `MakeFee.` 

Akash accepts a multitude of tokens for fees. Each validator and provider on Akash can choose to accept any currency or a combination of currencies as fees.

Resulting transaction fees, minus a network tax that goes into a reserve pool are split among validators and delegators based on their stake (amount and length).

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
