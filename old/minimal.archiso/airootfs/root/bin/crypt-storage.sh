#!/bin/env bash

need to find a way to take a gnupg + usb 
either partitioning /dev/sda with 1G keys *G storage
and then create as many

HASH=sha512
CIPHER=twofish-xts-plain64
KEYFILE=
cryptsetup --hash=${HASH} --cipher=${CIPHER} --offset=0 --key-file=${KEYFILE} open --type=plain /dev/sda storage

