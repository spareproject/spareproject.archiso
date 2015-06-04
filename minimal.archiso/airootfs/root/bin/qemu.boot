#!/bin/env bash


#if the tap interface and bridge already exists you dont need root to execute any of this
qemu-system-x86_64 -enable-kvm -m 2048 -vga std -net nic,macaddr="de:ad:be:ef:c0:fe" -net tap,script="/etc/qemu-ifup",downscript="/etc/qemu-ifdown" -hda ${1}

