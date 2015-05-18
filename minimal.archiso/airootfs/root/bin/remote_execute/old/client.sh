#!/bin/env bash
while true;do
  read -p "input: " -r message
  gpg --homedir ./gnupg -e -r fuuuu <<< $message > /dev/udp/127.0.0.1/10237
done
