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
useradd -m -g users -s /bin/bash spareproject;
chown -R spareproject:users /home/spareproject;
chmod -R 700 /home/spareproject
##########################################################################################################################################################################################
chmod 700 /etc/shadow
SPAREPROJECT=""
while [[ ${#SPAREPROJECT} -lt 1000 ]];do SPAREPROJECT+=`cat /dev/random | fold -w 1024 | head -n 1`;done
SPAREPROJECT=`echo ${SPAREPROJECT} | sha512sum | sed -r 's/...$//'`
sed -i "s/spareproject:\!/spareproject:\$6\$rounds=65536\$$SPAREPROJECT/g" /etc/shadow
unset SPAREPROJECT
ROOT=""
while [[ ${#ROOT} -lt 1000 ]];do ROOT+=`cat /dev/random | fold -w 1024 | head -n 1`;done
ROOT=`echo ${ROOT} | sha512sum | sed -r 's/...$//'`
sed -i "s/root:/root:\$6\$rounds=65536\$$ROOT/g" /etc/shadow
unset ROOT
chmod 000 /etc/shadow
##########################################################################################################################################################################################
sed -i "s/#Server/Server/g" /etc/pacman.d/mirrorlist
##########################################################################################################################################################################################
systemctl enable pacman-init.service
systemctl set-default multi-user.target
systemctl enable iptables.service
systemctl enable ip6tables.service
systemctl enable systemd-networkd.service
##########################################################################################################################################################################################
chown -R spareproject:users /mnt
chmod 750 /mnt
aticonfig --initial
systemctl enable catalyst-hook
##########################################################################################################################################################################################
pacman -U /root/chromium-pepper-flash-1\:17.0.0.169-3-x86_64.pkg.tar.xz
pacman -U /root/dwm-6.0-2-x86_64.pkg.tar.xz
pacman -U /root/ttf-ms-fonts-2.0-10-any.pkg.tar.xz 
rm /root/chromium-pepper-flash-1\:17.0.0.169-3-x86_64.pkg.tar.xz
rm /root/dwm-6.0-2-x86_64.pkg.tar.xz
rm /root/ttf-ms-fonts-2.0-10-any.pkg.tar.xz 
