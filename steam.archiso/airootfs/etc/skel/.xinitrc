pulseaudio --kill
pulseaudio --start
setxkbmap gb
conky | while read -r; do xsetroot -name "$REPLY"; done &
feh --bg-scale ~/.config/background &
exec dwm
