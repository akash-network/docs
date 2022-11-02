# Verify Validator Status

## Overview

* In this section we will verify the state of the Akash Validator following successful integration of TMKMS and Stunnel
* Use Cloudmos Deploy for the validations in this section

## Verify Stunnel Proxy Service

* Navigate into your Akash Validator deployment within Cloudmos
* Enter the `LOGS` tab of the deployment
* From the `Services` drop down menu > select `proxy`
* With Stunnel logs isolated we should see successful TLS connection messages such as the examples below

```
proxy: 2022.09.15 00:08:10 LOG7[12]: TLS state (accept): SSLv3/TLS write finished
proxy: 2022.09.15 00:08:10 LOG7[12]: TLS state (accept): TLSv1.3 early data
proxy: 2022.09.15 00:08:10 LOG7[12]: TLS state (accept): TLSv1.3 early data
proxy: 2022.09.15 00:08:10 LOG7[12]: TLS state (accept): SSLv3/TLS read finished
proxy: 2022.09.15 00:08:10 LOG7[12]:      8 server accept(s) requested
proxy: 2022.09.15 00:08:10 LOG7[12]:      2 server accept(s) succeeded
proxy: 2022.09.15 00:08:10 LOG7[12]:      0 server renegotiation(s) requested
proxy: 2022.09.15 00:08:10 LOG7[12]:      4 session reuse(s)
proxy: 2022.09.15 00:08:10 LOG7[12]:      1 internal session cache item(s)
proxy: 2022.09.15 00:08:10 LOG7[12]:      0 internal session cache fill-up(s)
proxy: 2022.09.15 00:08:10 LOG7[12]:      0 internal session cache miss(es)
proxy: 2022.09.15 00:08:10 LOG7[12]:      0 external session cache hit(s)
proxy: 2022.09.15 00:08:10 LOG7[12]:      0 expired session(s) retrieved
proxy: 2022.09.15 00:08:10 LOG7[12]: New session callback
proxy: 2022.09.15 00:08:10 LOG6[12]: No peer certificate received
proxy: 2022.09.15 00:08:10 LOG6[12]: Session id: A33315836C947E567A8BBA625BAB4C137F6B26DEAF54142D56E87775A44C26BA
proxy: 2022.09.15 00:08:10 LOG7[12]: TLS state (accept): SSLv3/TLS write session ticket
proxy: 2022.09.15 00:08:10 LOG6[12]: TLS accepted: previous session reused
proxy: 2022.09.15 00:08:10 LOG6[12]: TLSv1.3 ciphersuite: TLS_CHACHA20_POLY1305_SHA256 (256-bit encryption)
proxy: 2022.09.15 00:08:10 LOG7[12]: Compression: null, expansion: null
proxy: 2022.09.15 00:08:10 LOG6[12]: Session id: A33315836C947E567A8BBA625BAB4C137F6B26DEAF54142D56E87775A44C26BA
```

## Verify Validator Status

* Navigate into your Akash Validator deployment within Cloudmos
* Enter the `LOGS` tab of the deployment
* From the `Services` drop down menu > select `node`
* With Validator logs isolated we should see successful `executed block` and `committed state` messages such as those below

```
node: [90m1:19AM[0m [32mINF[0m executed block [36mheight=[0m7627065 [36mmodule=[0mstate [36mnum_invalid_txs=[0m0 [36mnum_valid_txs=[0m3
node: [90m1:19AM[0m [32mINF[0m commit synced [36mcommit=[0m436F6D6D697449447B5B32362031333220343820373520313930203320343720323238203136372038352031303520323520313533203539203630203234392031343720313236203938203136312032323220313620313336203230322032343220313137203139332032303620313234203830203131322032305D3A3734363133397D
node: [90m1:19AM[0m [32mINF[0m committed state [36mapp_hash=[0m1A84304BBE032FE4A7556919993B3CF9937E62A1DE1088CAF275C1CE7C507014 [36mheight=[0m7627065 [36mmodule=[0mstate [36mnum_txs=[0m3
node: [90m1:19AM[0m [32mINF[0m indexed block [36mheight=[0m7627065 [36mmodule=[0mtxindex
node: [90m1:19AM[0m [32mINF[0m Timed out [36mdur=[0m4875.841288 [36mheight=[0m7627066 [36mmodule=[0mconsensus [36mround=[0m0 [36mstep=[0m1
node: [90m1:19AM[0m [32mINF[0m received proposal [36mmodule=[0mconsensus [36mproposal=[0m{"Type":32,"block_id":{"hash":"EA1BA91C01F647AC96B855177BE4696FF8B5A470237598A87275B395A1E5C58B","parts":{"hash":"79AF71041EA62A35DA4507A32491F4EF0ADC4E570869E9A5406208A33818EC97","total":1}},"height":7627066,"pol_round":-1,"round":0,"signature":"PBwZZYMEehs/k5jv8RnPSSvYVnMdCHB4UylPnZuxmhL1146okZMaU+huMjJYV8sjAUR6JNoJC8wlwrKHQuUkCA==","timestamp":"2022-09-15T01:20:16.268331046Z"}
node: [90m1:20AM[0m [32mINF[0m received complete proposal block [36mhash=[0mEA1BA91C01F647AC96B855177BE4696FF8B5A470237598A87275B395A1E5C58B [36mheight=[0m7627066 [36mmodule=[0mconsensus
node: [90m1:20AM[0m [32mINF[0m finalizing commit of block [36mhash=[0mEA1BA91C01F647AC96B855177BE4696FF8B5A470237598A87275B395A1E5C58B [36mheight=[0m7627066 [36mmodule=[0mconsensus [36mnum_txs=[0m1 [36mroot=[0m1A84304BBE032FE4A7556919993B3CF9937E62A1DE1088CAF275C1CE7C507014
node: [90m1:20AM[0m [32mINF[0m minted coins from module account [36mamount=[0m4816074uakt [36mfrom=[0mmint [36mmodule=[0mx/bank
node: [90m1:20AM[0m [32mINF[0m executed block [36mheight=[0m7627066 [36mmodule=[0mstate [36mnum_invalid_txs=[0m0 [36mnum_valid_txs=[0m1
node: [90m1:20AM[0m [32mINF[0m commit synced [36mcommit=[0m436F6D6D697449447B5B31393520323430203835203130372032382034362035332032303720313735203232322039372031343420383220363720313731203137332031303420323130203135342035382032353420323431203231302032343420323120313431203137392033312034352031343120323438203134385D3A3734363133417D
node: [90m1:20AM[0m [32mINF[0m committed state [36mapp_hash=[0mC3F0556B1C2E35CFAFDE61905243ABAD68D29A3AFEF1D2F4158DB31F2D8DF894 [36mheight=[0m7627066 [36mmodule=[0mstate [36mnum_txs=[0m1
node: [90m1:20AM[0m [32mINF[0m indexed block [36mheight=[0m7627066 [36mmodule=[0mtxindex
```
