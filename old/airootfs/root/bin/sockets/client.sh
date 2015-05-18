#!/bin/env bash
read nc -vulnp 12724
#nc -vulnp 12724 | while read line 
#do
#  RESPONSE=$line
#done
while [[ -z RESPONSE ]]; do
  sleep 4;
  echo "request" > /dev/udp/localhost/12722
  echo $RESPONSE
done
