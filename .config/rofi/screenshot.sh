#!/usr/bin/env bash

SAVE_DIR="$HOME/Pictures/Screenshots"
FILE="$SAVE_DIR/$(date +%Y-%m-%d_%H-%M-%S).png"

CHOICE=$(printf "Region\nFullscreen\nWindow" | rofi -dmenu -p "Screenshot" -theme-str 'window { width: 220px; } listview { lines: 3; }')

case "$CHOICE" in
    Region)
        grim -g "$(slurp)" - | tee "$FILE" | wl-copy
        ;;
    Fullscreen)
        grim - | tee "$FILE" | wl-copy
        ;;
    Window)
        grim -g "$(hyprctl activewindow -j | jq -r '"\(.at[0]),\(.at[1]) \(.size[0])x\(.size[1])"')" - | tee "$FILE" | wl-copy
        ;;
    *)
        exit 0
        ;;
esac

notify-send "Screenshot saved" "$FILE" --icon=camera
