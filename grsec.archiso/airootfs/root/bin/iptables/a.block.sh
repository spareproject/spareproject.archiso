#!/bin/env bash
IPADDR=$1
echo $IPADDR
iptables -A BLOCKED -s $IPADDR -j DROP

