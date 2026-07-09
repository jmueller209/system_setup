#!/bin/bash

options="🔒 Lock Screen\n󰐥 Shutdown\n󰑓 Reboot"

chosen=$(echo -e "$options" | wofi \
  --dmenu \
  --prompt "⚡ Power Menu:" \
  --width 350 \
  --height 200 \
  --insensitive \
  --no-actions)

case "$chosen" in
    *Lock*)
        hyprlock
        ;;
    *Shutdown*)
        confirm=$(echo -e "❌ Cancel\n✅ Yes, Shut Down" | wofi \
          --dmenu \
          --prompt "Are you sure?" \
          --width 300 \
          --height 150 \
          --insensitive \
          --no-actions)
        if [[ "$confirm" == *"Yes"* ]]; then
            shutdown now
        fi
        ;;
    *Reboot*)
        confirm=$(echo -e "❌ Cancel\n✅ Yes, Restart" | wofi \
          --dmenu \
          --prompt "Are you sure?" \
          --width 300 \
          --height 150 \
          --insensitive \
          --no-actions)
        if [[ "$confirm" == *"Yes"* ]]; then
            reboot
        fi
        ;;
esac
