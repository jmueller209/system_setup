```bash
#!/bin/bash

# Hole die Liste aller Audio-Ausgänge (Sinks) von WirePlumber
devices=$(wpctl status | sed -n '/Audio/,/Video/p' | grep -E "vol" | sed 's/^[ \t]*//')

# Lass den Nutzer das Gerät über Rofi auswählen
chosen=$(echo "$devices" | rofi -dmenu -i -p "󰕾 Audio Output:" -theme-str 'window {width: 500px;}')

if [ [ -n "$chosen" ] ]; then
    # Extrahiere die ID des ausgewählten Geräts
    id=$(echo "$chosen" | grep -oE '[0-9]+' | head -n 1)
    
    # Setze das ausgewählte Gerät als Standard (Default Sink)
    wpctl set-default "$id"
    
    # Sende eine Benachrichtigung, welches Gerät jetzt aktiv ist
    name=$(echo "$chosen" | sed -E 's/[0-9]+\.//' | sed -E 's/\[vol.*//')
    notify-send "Audio gewechselt" "Aktiv: $name" -i audio-speakers
fi
