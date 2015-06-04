#!/bin/bash
##########################################################################################################################################################################################
set -e -u
loadkeys uk;
setfont Lat2-Terminus16;
locale-gen;
ln -sf /usr/share/zoneinfo/UTC /etc/localtime
##########################################################################################################################################################################################
chmod 700 /root
chmod 750 /etc/sudoers.d
chmod 440 /etc/sudoers.d/*
chmod -R 700 /etc/iptables
chmod -R 700 /boot
##########################################################################################################################################################################################
useradd -m -g users -s /bin/bash user;
ssh-keygen -t ecdsa -b 521 -C "user@archiso" -f /home/user/.ssh/id_ecdsa -N ""
cat /home/user/.ssh/id_ecdsa.pub >> /home/user/.ssh/authorized_keys
chown -R user:users /home/user;
chmod -R 700 /home/user
##########################################################################################################################################################################################
useradd -m -g wheel -s /bin/bash admin;
ssh-keygen -t ecdsa -b 521 -C "admin@archiso" -f /home/admin/.ssh/id_ecdsa -N ""
cat /home/admin/.ssh/id_ecdsa.pub >> /home/user/.ssh/authorized_keys
cat /home/admin/.ssh/id_ecdsa.pub >> /home/admin/.ssh/authorized_keys
chown -R admin:wheel /home/admin;
chmod -R 700 /home/admin
##########################################################################################################################################################################################
chmod 700 /etc/shadow
SPAREPROJECT=""
while [[ ${#SPAREPROJECT} -lt 1000 ]];do SPAREPROJECT+=`cat /dev/random | fold -w 1024 | head -n 1`;done
SPAREPROJECT=`echo ${SPAREPROJECT} | sha512sum | sed -r 's/...$//'`
sed -i "s/user:\!/user:\$6\$rounds=65536\$$SPAREPROJECT/g" /etc/shadow
unset SPAREPROJECT
ADMIN=""
while [[ ${#ADMIN} -lt 1000 ]];do ADMIN+=`cat /dev/random | fold -w 1024 | head -n 1`;done
ADMIN=`echo ${ADMIN} | sha512sum | sed -r 's/...$//'`
sed -i "s/admin:\!/admin:\$6\$rounds=65536\$$ADMIN/g" /etc/shadow
unset ADMIN
ROOT=""
while [[ ${#ROOT} -lt 1000 ]];do ROOT+=`cat /dev/random | fold -w 1024 | head -n 1`;done
ROOT=`echo ${ROOT} | sha512sum | sed -r 's/...$//'`
sed -i "s/root:/root:\$6\$rounds=65536\$$ROOT/g" /etc/shadow
unset ROOT
chmod 000 /etc/shadow
##########################################################################################################################################################################################
sed -i "s/#Server/Server/g" /etc/pacman.d/mirrorlist
##########################################################################################################################################################################################
#rm /usr/lib/systemd/system/systemd-timesyncd.service
#rm /usr/lib/systemd/system/systemd-resolved.service
#rm /usr/lib/systemd/system/remote-fs.target
#rm /usr/lib/systemd/system/remote-fs-pre.target
#rm /usr/lib/systemd/system/systemd-networkd.service
#rm /usr/lib/systemd/system/machines.target
##########################################################################################################################################################################################
pacman -Rns dhcpcd
pacman -Rns jfsutils
pacman -Rns licenses
pacman -Rns iputils
pacman -Rns nano
pacman -Rns pcmciautils
pacman -Rns netctl
pacman -Rns reiserfsprogs
pacman -Rns s-nail
pacman -Rns vi
pacman -Rns xfsprogs
pacman -Rns which
pacman -Rns logrotate
pacman -Rns lvm2
pacman -Rns file
pacman -Rns systemd-sysvcompat
pacman -Rnsdd lynx
##########################################################################################################################################################################################
rm /etc/systemd/system/multi-user.target.wants/remote-fs.target
##########################################################################################################################################################################################
pacman -U /root/abs/dwm/dwm-6.0-2-x86_64.pkg.tar.xz
##########################################################################################################################################################################################
systemctl enable iptables.service
systemctl enable ip6tables.service
systemctl enable haveged.service
systemctl enable hostname.service
systemctl enable macchanger.service
systemctl enable nat-bridge.service
systemctl enable systemd-networkd.service
systemctl enable dhcpd4.service
systemctl enable dnscrypt-proxy.service
systemctl enable pacman-init.service
##########################################################################################################################################################################################
if [[ -f /usr/bin/pinentry ]];then rm /usr/bin/pinentry;ln -s /usr/bin/pinentry-curses /usr/bin/pinentry;else ln -s /usr/bin/pinentry-curses /usr/bin/pinentry;fi
pacman -Rns linux
