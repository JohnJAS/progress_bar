#!/bin/bash
#set -x
arr=( "|" "/" "-" "\\" )
for((i=0;i < 100 ; i++))
do
    echo -e "\r"
    echo -e "${arr[$((i%4))]} \c" 
    usleep 30000    
done
