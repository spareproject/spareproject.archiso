#!/bin/env bash
iptables -t nat -A OUTPUT -s localhost -d localhost -p udp --dport 53 -j REDIRECT --to-port 9053
