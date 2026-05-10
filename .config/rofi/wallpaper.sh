#!/usr/bin/env bash

export WAYLAND_DISPLAY="${WAYLAND_DISPLAY:-wayland-1}"

if ! pgrep -x awww-daemon > /dev/null; then
    awww-daemon &
    sleep 0.5
fi

WALLPAPER_DIR="$HOME/Pictures/Wallpapers"

if [[ ! -d "$WALLPAPER_DIR" ]]; then
    notify-send "Wallpaper" "Directory not found: $WALLPAPER_DIR" --icon=dialog-error
    exit 1
fi

CHOICE=$(find "$WALLPAPER_DIR" -maxdepth 1 -type f \( \
    -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \
    -o -iname "*.gif" -o -iname "*.webp" \
  \) | sort | while read -r file; do
    printf '%s\0icon\x1f%s\n' "$(basename "$file")" "$file"
  done | rofi -dmenu -p "Wallpaper" -show-icons -theme-str '
    window { width: 600px; }
    listview { lines: 8; }
    element-icon { size: 4em; }
  ')

[[ -z "$CHOICE" ]] && exit 0

awww img "$WALLPAPER_DIR/$CHOICE" \
    --transition-type grow \
    --transition-pos center \
    --transition-duration 1 \
    --transition-fps 60
