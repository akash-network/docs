
# Related Work

The majority of *proof of stake* network such as Ethereum 2.0 [@eth20], Tezos [@tezos], and Cardano [@cardano] all use a single token model. However, there seem to be networks that are experimenting with more novel models. In this section, we will review some of these systems and explore the differences with Akash's token model.

## Cosmos Hub

Akash and Cosmos Hub use Tendermint [@tendermint] Consensus Algorithm and share a core set of values with interoperability and user experience. Similar to Cosmos's Atom [@cosmosEcon], AKT's primary utility is to provide economic security to the network. However, Akash's model variously improves the Cosmos' model. Firstly, AKT provides a mechanism to normalize compute prices for the marketplace auction. Secondly, Akash introduces a mechanism to lock in an exchange rate to a reserve currency of choice to mitigate market drive volatility risk of AKT when leasing computing for more extended periods. Finally, Akash's block reward distribution is proportional to the time and amount of a stake, unlike Cosmos' model where the distribution is homogeneous for a fixed time. Cosmos imposes a 21-day "unbonding" period -- considered lock up -- and there is no incentive to commit for more extended periods. Whereas, stakers in Akash can choose to commit for one month to a year, for which they will receive ~54% and 100% compensation respectively.

## NEO

According to NEO's white paper [@neo]:

> NEO network has two tokens. NEO representing the right to manage NEO blockchain and GAS representing the right to use the NEO Blockchain.

At the surface, NEO's primary utility is a staking token and GAS is the fee token. However, after closer observation, NEO's model is very different from Akash's model.

Firstly, NEO is used as a mechanism to determine how many votes each NEO account gets without a requirement to stake tokens. Each account can vote for as many validator candidates as they wish and each validator candidate they vote for receives the number of votes equivalent to the amount of NEO in the voter's account.

With regards to the fee, NEO's chain only supports a single fee token, unlike Akash's multi-token model. Furthermore, unlike Akash, NEO does not provide volatility protection for the GAS tokens.

## EOS

EOS's *delegated proof of stake consensus* [@eos] has similarities with Akash's model but are extensively different. In EOS, each token holder can stake their tokens in order to vote for block producer and in return, rewarded in resource units such as CPU, RAM, and NET that can be spent for transactions on the network. However, like in NEO, the staking token EOS is not staked by the block producers, and it is not slashable in the case of misbehavior. 

In EOS, staking means, stakers are putting tokens in a lock-up period and not necessarily contributing to the functionality of the network. Stakers earn rewards in CPU, RAM, and NET that are used to purchase computational resources on the network. These resources are not transferrable. CPU and NET are only spendable by the receiver, whereas RAM can be traded with other users in a Bancor-style marketplace [@eosram].

EOS burns these resources upon spending, instead of giving them to block producers. The validator compensation model is unclear, considering transaction fees is not the primary mechanism. EOS is seemingly a single token network, despite having nuances and additional steps. 

# Conclusion

This paper explains the network and mining economics of Akash Network and presents various incentives and utilities of different tokens in the staking and fees mechanisms. The Akash Token (AKT) acts as staking token and reserve currency for the network while using a multitude of tokens for settlement.

