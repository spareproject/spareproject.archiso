#!/bin/env bash
iptables -D BLOCKED -s ${IPADDR} -j DROP

