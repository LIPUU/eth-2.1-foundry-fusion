#!/bin/bash

#!/bin/bash
ARG=( "${@}" )
for i in ${ARG[@]}; do
    echo $i > ../contracts/core/cross_chain_manager/logic/Const.sol
done



