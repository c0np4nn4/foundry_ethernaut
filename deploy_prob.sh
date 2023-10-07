#!/bin/bash

SOLUTION_DIRECTORY="./src/0_Solutions"
GREEN='\033[1;32m'
RED='\033[0;31m'
CYAN='\033[1;36m'
NC='\033[0m' # No Color

# ----- RUN Fresh anvil -----

# # find the PID of 'anvil'
# PIDS=$(ps -av | grep anvil | grep -v grep | awk '{print $1}')
# for PID in $PIDS
# do
#     kill -9 $PID
# done

# # sleep for sequential execution
# sleep 0.2

# # run anvil in background
# anvil &

# # sleep for sequential execution
# sleep 0.2

printf "\n\n======================================================\n"
printf "[${RED}*${NC}] ${GREEN}Availabe Problem list...${NC}\n"

for file in ./src/*_*/; do
    base_file=$(basename "$file")
    
    problem_title=${base_file#*_}
    problem_title=${problem_title%.sol}
    
    # 결과를 출력합니다.
    printf " - ${CYAN}$problem_title${NC}\n"
done

# # ----- choose the problem  -----
printf "\n\n======================================================\n"
printf "[${RED}*${NC}] ${GREEN}Availabe Solution list...${NC}\n"

for file in ./test/solutions/*_*.t.sol; do
    base_file=$(basename "$file")
    
    problem_title=${base_file#*_}
    problem_title=${problem_title%.t.sol}
    
    # 결과를 출력합니다.
    printf " - ${CYAN}$problem_title${NC}\n"
done


# echo "" # newline

# read -p "Choose one problem: " name

# forge test --match-contract $name
