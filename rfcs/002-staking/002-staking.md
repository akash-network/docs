---
title: Akash Staking Economics
author: Greg Osuri
draft: 0 (wip)
---

# Akash Network Staking Economics

Reference [AKT Paper](https://akash.network/econ-paper)

## Genesis Parameters

| Parameter | Description | Value |
| -- | -- | -- |
| initialTokenSupply | Initial Token (Circulating) Supply | 100,000,000 |
| initialInflation | Inflation at Genesis (Daily)	| 0.27% |
| inflationDecayFactor | Inflation Decay Factor (Halving Interval) in Days |	730 |
| networkReward | Network Reward (Mean) |	0.75 |
| stakedPercent | Total Staked Tokens (Percent) | 60% |

## Code

```javascript
function inflationRate(networkReward, initialInflation, inflationDecayFactor, t) {
  smax = tokenSupplyMax(networkReward, initialInflation, inflationDecayFactor)
  s = tokenSupplyAtTime(networkReward, initialInflation, inflationDecayFactor, t)
  return (Math.LN2/inflationDecayFactor)*(smax - s)
}

function tokenSupplyAtTime(networkReward, initialInflation, inflationDecayFactor,t) {
  tAvg = inflationDecayFactor /networkReward
  return 1 + (networkReward * initialInflation * tAvg / Math.LN2) * (1.0 - Math.pow(2, (- t / tAvg)));
}


function tokenSupplyMax(networkReward, initialInflation, inflationDecayFactor) {
  tAvg = inflationDecayFactor /networkReward
  return 1 + networkReward * initialInflation * tAvg / Math.LN2
}


function dailyCompRate(reward, stakedPercent, inflationDecayFactor, networkReward, initialInflation, t) {
  tAvg = inflationDecayFactor / networkReward
  s = tokenSupplyAtTime(networkReward, initialInflation, inflationDecayFactor, t)
  smax = tokenSupplyMax(networkReward, initialInflation, inflationDecayFactor)
  return reward * Math.LN2 / (stakedPercent * s * inflationDecayFactor) * (smax - s)
}

// annual compensation with constant reward
function annualCompRateCR(reward, stakedPercent, inflationDecayFactor, networkReward, initialInflation) {
  var t = 1;
  var rate = 0;
  while (t <= 356) {
    rate = rate + dailyCompRate(reward, stakedPercent, inflationDecayFactor, networkReward, initialInflation, t);
    t++;
  }
  return rate
}

function daysToReachMaxTokenSupply(initialTokenSupply, networkReward, initialInflation, inflationDecayFactor){
  var smax = Math.round(initialTokenSupply * tokenSupplyMax(networkReward, initialInflation, inflationDecayFactor))
  var t = 0;
  var s = initialTokenSupply;
  while (s < smax) {
    t = t+1;
    s = Math.round(initialTokenSupply * tokenSupplyAtTime(networkReward, initialInflation, inflationDecayFactor, t))
  }
  return t;
}
```
