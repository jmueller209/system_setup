#!/bin/bash

raw_devices=$(wpctl status | sed -n '/Audio/,/Video/p' | grep -E "vol" | sed 's/^[ \t]*//')

formatted_list=""
while read -r line; do
    id=$(echo "$line" | grep -oE '[0-9]+' | head -n 1)
    name=$(echo "$line" | sed -E 's/[0-9]+\.//' | sed -E 's/\[vol.*//' | xargs)
    vol=$(echo "$line" | grep -oE 'vol=[0-9.]+' | cut -d= -f2)
    
    if echo "$line" | grep -q "\*"; then
        formatted_list+="(ACTIVE) $name [Vol: $vol] | ID:$id\n"
    else
        formatted_list+="$name [Vol: $vol] | ID:$id\n"
    fi
done <<< "$raw_devices"

chosen=$(echo -e "$formatted_list" | wofi \
  --dmenu \
  --prompt "󰕾 Select Audio Output:" \
  --width 550 \
  --height 220 \
  --insensitive \
  --no-actions \
  --matching fuzzy)

if [ -n "$chosen" ]; then
    target_id=$(echo "$chosen" | awk -F '| ID:' '{print $2}' | xargs)
    wpctl set-default "$target_id"
    notify-send "Audio Switched" "Active output changed" -i audio-speakers
fi
