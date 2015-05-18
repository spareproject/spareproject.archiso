#!/bin/env bash
########################################################################################
# filter...   INPUT OUTPUT FORWARD
# nat...      PREROUTING OUTPUT POSTROUTING
# mangle...   PREROUTING OUTPUT INPUT FORWARD POSTROUTING
# raw...      PREROUTING OUTPUT
# security... INPUT OUTPUT FORWARD
########################################################################################
iptables -t filter -F
iptables -t filter -X
iptables -t nat -F
iptables -t nat -X
iptables -t mangle -F
iptables -t mangle -X
iptables -t raw -F
iptables -t raw -X
iptables -t security -F
iptables -t security -X
########################################################################################
iptables -P INPUT DROP
iptables -P OUTPUT ACCEPT
iptables -P FORWARD DROP
########################################################################################
iptables -N UDP
iptables -N TCP
iptables -N LO
########################################################################################
iptables -A INPUT -m conntrack --ctstate INVALID -j DROP
iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED --ctproto tcp -j ACCEPT
iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED --ctproto udp -j ACCEPT
########################################################################################
iptables -A INPUT -i lo  -m conntrack --ctstate NEW -j LO
iptables -A INPUT -p udp -m conntrack --ctstate NEW -j UDP
iptables -A INPUT -p tcp -m conntrack --ctstate NEW -j TCP
iptables -A INPUT -j LOG --log-prefix "DROPPED" --log-level 6
iptables -A INPUT -j DROP
########################################################################################
iptables -A LO -j ACCEPT
iptables -A TCP -j DROP
iptables -A UDP -j DROP
########################################################################################
