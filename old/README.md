# shiny-spice

lan facing bridge

internal ip nat forward bridge

tor ip nat forward bridge + forward all outbound tcp through TransPort & udp through DNSPort

started setting up nftables just to play with syntax added switch toggle to the fugly stuff that allows random machine-id on boot

got a decent copy that works with current setup but no recent module replacement so just stopped setting it up current version doesnt do anything was in ram : /

can mount /dev/sdX2 on the usb to the host system and shove a gnupg keyring in it for persistent goodness 9.9MB 

then QQ at gnupg till it lets me use a script that takes a random 4-6 digit pin on usb plugin, dd max legnth password availble into gpg-agent and unlock for given time

scatter password over a 16GB usb or stick the keyring on usb, with random algo takes 6 digit numeric pin 

for i in ( x z y );do PASSWD+=$(dd if=/dev/gnupg bs=AI count=1 skip=BI);done gpg-agent <<< ${PASSWD} 

just want a quick way to enforce max length password and none of it wants to work 

ive generally stopped caring about notes 
