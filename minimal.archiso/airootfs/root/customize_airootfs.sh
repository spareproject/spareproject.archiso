#!/bin/bash
###############################################################################################################################################################################################################
#MISC
###############################################################################################################################################################################################################
set -e -u
loadkeys uk;
setfont Lat2-Terminus16;
locale-gen;
ln -sf /usr/share/zoneinfo/UTC /etc/localtime
if [[ -f /usr/bin/pinentry ]];then rm /usr/bin/pinentry;ln -s /usr/bin/pinentry-curses /usr/bin/pinentry;else ln -s /usr/bin/pinentry-curses /usr/bin/pinentry;fi
###############################################################################################################################################################################################################
#USERS
###############################################################################################################################################################################################################
chmod 700 /root
#chmod 750 /etc/sudoers.d
#chmod 440 /etc/sudoers.d/*
chmod -R 700 /etc/iptables
chmod -R 700 /boot
passwd -l root
###############################################################################################################################################################################################################
useradd -m -g users -s /bin/bash user;
cp /etc/ssh/sshd_config_user /home/user/sshd/sshd_config
ssh-keygen -t ecdsa -b 521 -C "user@archiso" -f /home/user/.ssh/id_ecdsa -N ""
cat /home/user/.ssh/id_ecdsa.pub >> /home/user/.ssh/authorized_keys
chown -R user:users /home/user;
chmod -R 700 /home/user
passwd -l user
###############################################################################################################################################################################################################
#useradd -m -g wheel -s /bin/bash admin;
#cp /etc/ssh/sshd_config_admin /home/admin/sshd/sshd_config
#ssh-keygen -t ecdsa -b 521 -C "admin@archiso" -f /home/admin/.ssh/id_ecdsa -N ""
#cat /home/admin/.ssh/id_ecdsa.pub >> /home/user/.ssh/authorized_keys
#cat /home/admin/.ssh/id_ecdsa.pub >> /home/admin/.ssh/authorized_keys
#chown -R admin:wheel /home/admin;
#chmod -R 700 /home/admin
#passwd -l admin
###############################################################################################################################################################################################################
#PACKAGES / PACMAN
###############################################################################################################################################################################################################
sed -i "s/#Server/Server/g" /etc/pacman.d/mirrorlist
pacman -Rns diffutils
pacman -Rns gettext
pacman -Rns dhcpcd
pacman -Rns jfsutils
pacman -Rns licenses
pacman -Rns iputils
pacman -Rns sysfsutils
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
###############################################################################################################################################################################################################
#BOOT - SERVICES
###############################################################################################################################################################################################################
rm /etc/systemd/system/multi-user.target.wants/remote-fs.target
systemctl enable iptables.service
systemctl enable ip6tables.service
systemctl enable haveged.service
systemctl enable systemd-networkd.service
systemctl enable dhcpd4.service
systemctl enable dnscrypt-proxy.service
systemctl enable pacman-init.service
systemctl enable sshdgenkeys@user.service
systemctl enable sshdgenkeys@admin.service
systemctl enable combine.service
###############################################################################################################################################################################################################
#NON-REPO PACKAGES
###############################################################################################################################################################################################################
pacman -U /root/abs/dwm/dwm-6.0-2-x86_64.pkg.tar.xz
###############################################################################################################################################################################################################

