#!/bin/env bash
AVAILABLE=( "one" "two" "three" "four" "five" "six" "seven" )
USED=( )
CACHE=( )

function pop {
  CACHE=( )
  USED+=( ${AVAILABLE[0]} )
  unset AVAILABLE[0]
  for ((i=1;i<=${#AVAILABLE[@]};i++))
  do
    CACHE+=(${AVAILABLE[$i]})
  done
  AVAILABLE=( "${CACHE[@]}" )
}
function reclaim {
  CACHE=( )
  AVAILABLE+=( ${USED[0]} )
  unset USED[0]
  for ((i=1;i<=${#USED[@]};i++))
  do
    CACHE+=(${USED[@]})
  done
  USED=( "${CACHE[@]}" )
}
function printa {
  echo "###################################################"
  echo "length: ${#AVAILABLE[@]} AVAILABLE: ${AVAILABLE[@]}"
  echo "length: ${#USED[@]} USED: ${USED[@]}"
  echo "###################################################"
}

pop
printa
pop
printa
reclaim
printa
reclaim
printa


#####################################################
#TEST=( one two three )
#unset TEST[0]
#for i in ${TEST[@]}
#do
#  SECOND+=( $i )
#done
#echo ${SECOND[@]}
#echo "so this is still empty? ${SECOND[0]}"
#####################################################







