[[ $- != *i* ]] && return
echo 360 > /proc/sys/net/netfilter/nf_conntrack_tcp_timeout_established
