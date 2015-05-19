#!/bin/env bash
# xf86-video-vesa - never got a none root update so havent touched qemu since it lost a display (and havent checked since)
qemu-system-x86_64 -enable-kvm -m 2048 -vga std -net nic,macaddr="de:ad:be:ef:c0:fe" -net tap,script="/etc/qemu-ifup",downscript="/etc/qemu-ifdown" -hda ${1}
