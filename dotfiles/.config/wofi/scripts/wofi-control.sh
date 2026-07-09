#!/bin/bash

wifi_status=$(nmcli -t -f WIFI g | head -n 1)
[[ "$wifi_status" == "enabled" ]] && wifi_icon="󰖩  Wi-Fi: On" || wifi_icon="󰖪  Wi-Fi: Off"

active_sink=$(wpctl status | sed -n '/Audio/,/Video/p' | grep "\*" | sed -E 's/.*[0-9]+\.\s*//' | sed -E 's/\[vol.*//' | xargs)

options="${wifi_icon}\n󰓃  Select Audio Output (Active: ${active_sink})\n󰍬  Open App Volume Mixer\n🔒  Power & Session Menu"

chosen=$(echo -e "$options" | wofi \
  --dmenu \
  --prompt "" \
  --location 3 \
  --xoffset -20 \
  --yoffset 50 \
  --width 380 \
  --height 240 \
  --style ~/.config/wofi/control-style.css \
  --insensitive \
  --no-actions)

case "$chosen" in
    *Wi-Fi*)
        [[ "$wifi_status" == "enabled" ]] && nmcli radio wifi off || nmcli radio wifi on
        ;;
    *Audio*)
        ~/.config/wofi/scripts/wofi-audio.sh
        ;;
    *Volume*)
        pavucontrol --tab=3
        ;;
    *Power*)
        ~/.config/wofi/scripts/wofi-power.sh
        ;;
esac
