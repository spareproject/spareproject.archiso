[[ $- != *i* ]] && return
#cp /root/systemd/* /usr/lib/systemd/system/
#systemctl set-default multi-user.target

while [[ $firewall != @(1|2) ]];do
  read -r -p "1 iptables 2 nftables: " firewall
  if [[ $firewall == 1 ]];then
    systemctl start iptables.service
    systemctl start ip6tables.service
  elif [[ $firewall == 2 ]];then
    # couldnt get logging to work : /
    #modprobe xt_LOG
    #echo "ipt_LOG" >/proc/sys/net/netfilter/nf_log/2
    systemctl start nftables.service
  else 
    echo "1 iptables or 2 nftables"
  fi
done

systemctl start haveged.service
systemctl start hostname.service
systemctl start sshd-server-keys.service
systemctl start pinentry.service
systemctl start conky.service
systemctl start macchanger.service
systemctl start nat-bridge.service

cp /root/systemd-networkd.service /usr/lib/systemd/system/
sleep 1
systemctl start systemd-networkd.service
systemctl start etc-pacman.d-gnupg.mount
systemctl start pacman-init.service
systemctl start dhcpd4.service
systemctl start dnscrypt-proxy.service

echo 360 > /proc/sys/net/netfilter/nf_conntrack_tcp_timeout_established

echo "" > /root/.bash_profile

