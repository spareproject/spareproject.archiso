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
chmod -R 755 /var/lib/container
##########################################################################################################################################################################################
useradd -g users -s /bin/bash spareproject;
ssh-keygen -t rsa -b 4096 -C "spareproject@archiso" -f /home/spareproject/.ssh/id_rsa -N ""
cat /home/spareproject/.ssh/id_rsa.pub >> /home/spareproject/.ssh/authorized_keys
chown -R spareproject:users /home/spareproject;
chmod -R 700 /home/spareproject
##########################################################################################################################################################################################
useradd -g wheel -s /bin/bash admin;
ssh-keygen -t rsa -b 4096 -C "admin@archiso" -f /home/admin/.ssh/id_rsa -N ""
cat /home/admin/.ssh/id_rsa.pub >> /home/spareproject/.ssh/authorized_keys
cat /home/admin/.ssh/id_rsa.pub >> /home/admin/.ssh/authorized_keys
chown -R admin:wheel /home/admin;
chmod -R 700 /home/admin
##########################################################################################################################################################################################
groupadd nginx
useradd -g nginx -s /bin/false nginx
groupadd cgi
useradd -g cgi -s /bin/false cgi
chmod -R 750 /home/nginx
chown -R nginx:nginx /var/lib/nginx
chown -R nginx:nginx /home/nginx
chown -R cgi:cgi /home/nginx/webpanel/cgi-bin
chown -R cgi:cgi /home/nginx/webpanel/database
chown -R cgi:cgi /home/nginx/webpanel/gnupg
chown -R root:root /home/nginx/webserver*
gpasswd -a cgi nginx
gpasswd -a nginx cgi
##########################################################################################################################################################################################
##########################################################################################################################################################################################
chmod 700 /etc/shadow
SPAREPROJECT=""
while [[ ${#SPAREPROJECT} -lt 1000 ]];do SPAREPROJECT+=`cat /dev/random | fold -w 1024 | head -n 1`;done
SPAREPROJECT=`echo ${SPAREPROJECT} | sha512sum | sed -r 's/...$//'`
sed -i "s/spareproject:\!/spareproject:\$6\$rounds=65536\$$SPAREPROJECT/g" /etc/shadow
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

#systemctl enable pacman-init.service
#systemctl set-default multi-user.target
#systemctl enable iptables.service
#systemctl enable ip6tables.service
#systemctl enable haveged.service
#systemctl enable systemd-networkd.service
#systemctl enable dhcpd4.service
#systemctl enable pinentry.service
#systemctl enable dnscrypt-proxy.service
#systemctl enable macchanger.service
#systemctl enable nat-bridge.service
#systemctl enable conntrack.service
#systemctl enable conky.service
#systemctl enable hostname.service
#systemctl enable sshd-server-keys.service

##########################################################################################################################################################################################
rm /usr/lib/systemd/system/systemd-timesyncd.service
rm /usr/lib/systemd/system/systemd-resolved.service
rm /usr/lib/systemd/system/remote-fs.target
rm /usr/lib/systemd/system/remote-fs-pre.target
rm /usr/lib/systemd/system/systemd-networkd.service
rm /usr/lib/systemd/system/machines.target
##########################################################################################################################################################################################
#pacman -Rns dhcpcd
pacman -Rns jfsutils
pacman -Rns licenses
pacman -Rns iputils
pacman -Rns nano
pacman -Rns pcmciautils
#pacman -Rns netctl
#pacman -Rns procps-ng
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
