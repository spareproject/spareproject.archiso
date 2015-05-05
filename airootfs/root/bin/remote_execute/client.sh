#!/bin/env bash
SERVER=10.0.0.4
KNOCK=10237
EXEC=10239

nc -u ${SERVER} ${KNOCK} <<< fu > /home/admin/server_knock &
sleep 1
kill $! &>/dev/null

for i in $(gpg -d ./server_knock 2>/dev/null);do
  echo "debug: sending fu to /dev/udp/${SERVER}/${i}"
  echo fu > /dev/udp/${SERVER}/${i}
done

while true;do
  read -p "input: " -r message
  message+=""
  gpg -e -r spareproject <<< $message > /dev/udp/${SERVER}/${EXEC}
done
