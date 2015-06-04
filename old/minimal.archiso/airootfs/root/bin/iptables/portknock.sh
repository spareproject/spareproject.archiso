#!/bin/env bash
# doesnt do anything but its the iptables commands needed to make use of current iptables.rules... sort of
knock_one=`shuf -i 1025-65535 -n 1`
knock_two=`shuf -i 1025-65535 -n 1`
knock_three=`shuf -i 1025-65535 -n 1`
knock_four=`shuf -i 1025-65535 -n 1`
REMOTE_ADDR="0.0.0.0"
LOCAL_ADDR="0.0.0.0"
iptables -A KNOCK_ONE   -p udp -d ${LOCAL_ADDR} --dport ${knock_one}   -s ${REMOTE_ADDR} -m recent --set --name KNOCK_TWO
iptables -A KNOCK_TWO   -p udp -d ${LOCAL_ADDR} --dport ${knock_two}   -s ${REMOTE_ADDR} -m recent --set --name KNOCK_THREE
iptables -A KNOCK_THREE -p udp -d ${LOCAL_ADDR} --dport ${knock_three} -s ${REMOTE_ADDR} -m recent --set --name KNOCK_FOUR
iptables -A KNOCK_FOUR  -p udp -d ${LOCAL_ADDR} --dport ${knock_four}  -s ${REMOTE_ADDR} -m recent --set --name SESSION
iptables -A SESSION -p tcp -d ${LOCAL_ADDR} --dport 8080 -s ${REMOTE_ADDR} -j ACCEPT
iptables -A SESSION -p udp -d ${LOCAL_ADDR} --dport 8080 -s ${REMOTE_ADDR} -j ACCEPT
iptables -D KNOCK_ONE   -p udp -d 127.0.0.1 --dport ${knock_one}   -s ${REMOTE_ADDR} -m recent --set --name KNOCK_TWO
iptables -D KNOCK_TWO   -p udp -d 127.0.0.1 --dport ${knock_two}   -s ${REMOTE_ADDR} -m recent --set --name KNOCK_THREE
iptables -D KNOCK_THREE -p udp -d 127.0.0.1 --dport ${knock_three} -s ${REMOTE_ADDR} -m recent --set --name KNOCK_FOUR
iptables -D KNOCK_FOUR  -p udp -d 127.0.0.1 --dport ${knock_four}  -s ${REMOTE_ADDR} -m recent --set --name SESSION
iptables -D SESSION -p tcp -d ${LOCAL_ADDR} --dport 8080 -s ${REMOTE_ADDR} -j ACCEPT
iptables -D SESSION -p udp -d ${LOCAL_ADDR} --dport 8080 -s ${REMOTE_ADDR} -j ACCEPT
echo "fu" | nc -u ${LOCAL_ADDR} ${qspvariables[knock_one]}
echo "fu" | nc -u ${LOCAL_ADDR} ${qspvariables[knock_two]}
echo "fu" | nc -u ${LOCAL_ADDR} ${qspvariables[knock_three]}
echo "fu" | nc -u ${LOCAL_ADDR} ${qspvariables[knock_four]}

