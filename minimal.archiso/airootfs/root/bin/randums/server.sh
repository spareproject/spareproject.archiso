#!/bin/env bash
declare -a USED
declare -a CACHE
declare -A BLACKLIST
function populate_array { if [[ ! ${AVAILABLE} ]]; then for i in {12724..12800}; do AVAILABLE+=($i); done; fi; }
function listener { for (( ;; )); do nc -vulnzp 12722 > /dev/null 2>fifo; done; }

function reader {
  while true; do
    if read line <fifo; then
      REQUEST=`echo $line | sed -r 's/^.{21}//' | sed -r 's/:.*$//'`
      if [[ ${BLACKLIST[${REQUEST}]} ]]; then echo "${BLACKLIST[${REQUEST}]}" > /dev/udp/${REQUEST}/12724; continue; fi
      #######################################
      CACHE=()
      PORT=${AVAILABLE[0]}
      USED+=${#AVAILABLE[0]}
      for ((i=1;i<=${#AVAILABLE[@]};i++))
        do
          CACHE+=(${AVAILABLE[${i}]})
        done
      AVAILABLE=( "${CACHE[@]}" )
      CACHE=()
      #######################################
      BLACKLIST+=([$REQUEST]=${PORT})
      
      echo "${PORT}" > /dev/udp/127.0.0.1/12724
    fi
  done
}


populate_array
listener &
reader &
wait
#while read line
#  do
#    REQUESTEE=`echo $line | sed -r 's/^.{21}//' | sed -r 's/:.*$//'`
#    if [[ ! -z REQUESTEE ]]; then echo "response" > /dev/udp/${REQUESTEE}/12724; fi
#
#    #if [[ EVERY_OTHER == "true" ]]; then echo $line | sed -r 's/^.{21}//' | sed -r 's/:.*$//'; EVERY_OTHER=false; fi
#    #if [[ EVERY_OTHER == "false" ]]; then EVERY_OTHER=true; fi
#  done < fifo
