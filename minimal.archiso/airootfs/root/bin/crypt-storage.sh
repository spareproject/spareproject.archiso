#!/bin/env bash

cryptsetup benchmark shows hash / cipher stats

HASH=sha512
CIPHER=twofish-xts-plain64
KEYFILE=
cryptsetup --hash=${HASH} --cipher=${CIPHER} --offset=0 --key-file=${KEYFILE} open --type=plain /dev/sda storage

