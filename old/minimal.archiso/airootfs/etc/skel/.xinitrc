xrdb ~/.Xresources
setxkbmap gb
conky | while read -r; do xsetroot -name "$REPLY"; done &
exec dwm
