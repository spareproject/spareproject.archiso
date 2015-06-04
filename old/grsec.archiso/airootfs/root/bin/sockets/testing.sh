#!/bin/env bash


function testing {
  echo "one"
  echo "two"
  echo "exiting"
  return 1
  #KILL -INT $$
  echo "doesnt print"
}

#testing
#echo "three"

#TESTARRAY=( ["one"]="four" ["two"]="three" ["three"]="two" ["four"]="one" )
#echo ${TESTARRAY[@]}a

while true; do echo "some text pre break"; continue; echo "some text post break"; done

