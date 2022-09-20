#!/bin/bash

#!/bin/bash
ARG=( "${@}" )
tmp=""
for i in ${ARG[@]}; do
   tmp="$tmp $i" 
done
echo $tmp > /home/lipu/crossChain2.1_with_foundry/eth-contracts/contracts/core/cross_chain_manager/logic/Const.sol



