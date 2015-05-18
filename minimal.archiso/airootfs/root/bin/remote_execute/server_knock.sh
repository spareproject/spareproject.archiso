#!/bin/env bash
timestamp=0
RECIPIENT="2F41A8EB"
HOMEDIR="/home/spareproject/.gnupg"
PORT="10237"
trap "exit" INT
while true;do
  if [[ $(date +%s) -gt ${timestamp} ]];then
    if [[ -f /root/server_knock ]];then rm /root/server_knock;fi
    iptables -F KNOCK_ONE;iptables -F KNOCK_TWO;iptables -F KNOCK_THREE;iptables -F KNOCK_FOUR
    knock_one=$(shuf -i 1024-65000 | head -n 1)
    knock_two=$(shuf -i 1024-65000 | head -n 1)
    knock_three=$(shuf -i 1024-65000 | head -n 1)
    knock_four=$(shuf -i 1024-65000 | head -n 1)
    iptables -A KNOCK_ONE   -p udp --dport ${knock_one}   -m recent --set --name KNOCK_TWO
    iptables -A KNOCK_TWO   -p udp --dport ${knock_two}   -m recent --set --name KNOCK_THREE
    iptables -A KNOCK_THREE -p udp --dport ${knock_three} -m recent --set --name KNOCK_FOUR
    iptables -A KNOCK_FOUR  -p udp --dport ${knock_four}  -m recent --set --name SESSION
    timestamp=$(($(date +%s)+60))
    gpg --homedir $HOMEDIR -s -e -r $RECIPIENT <<< "${knock_one} ${knock_two} ${knock_three} ${knock_four}" 2>/dev/null >/root/server_knock
    nc -vulncp 10237 &>/dev/null < /root/server_knock
  else
    nc -vulncp 10237 &>/dev/null < /root/server_knock
  fi  
done
