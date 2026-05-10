#!/usr/bin/env bash

dir="$HOME/.config/rofi/applets/type-1"
theme='style-1'

prompt='Screenshot'
dir_save="$(xdg-user-dir PICTURES)/Screenshots"
mesg="DIR: $dir_save"

option_1=" Capture Desktop"
option_2=" Capture Area"
option_3=" Capture Window"
option_4=" Capture in 5s"
option_5=" Capture in 10s"

rofi_cmd() {
    rofi -theme-str 'window {width: 400px;}' \
        -theme-str 'listview {columns: 1; lines: 5;}' \
        -theme-str 'textbox-prompt-colon {str: "";}' \
        -dmenu \
        -p "$prompt" \
        -mesg "$mesg" \
        -theme ${dir}/${theme}.rasi
}

run_rofi() {
    echo -e "$option_1\n$option_2\n$option_3\n$option_4\n$option_5" | rofi_cmd
}

time_stamp="$(date +%Y-%m-%d_%H-%M-%S)"
file="$dir_save/Screenshot_${time_stamp}.png"

[[ ! -d "$dir_save" ]] && mkdir -p "$dir_save"

notify_view() {
    notify-send -u low "Screenshot" "Saved: $file"
}

countdown() {
    for sec in $(seq $1 -1 1); do
        notify-send -t 1000 "Screenshot" "Taking in: ${sec}s"
        sleep 1
    done
}

shotnow() {
    sleep 0.3 && grim - | tee "$file" | wl-copy
    notify_view
}

shot5() {
    countdown 5 && sleep 0.3 && grim - | tee "$file" | wl-copy
    notify_view
}

shot10() {
    countdown 10 && sleep 0.3 && grim - | tee "$file" | wl-copy
    notify_view
}

shotwin() {
    geo="$(hyprctl activewindow -j | jq -r '"\(.at[0]),\(.at[1]) \(.size[0])x\(.size[1])"')"
    grim -g "$geo" - | tee "$file" | wl-copy
    notify_view
}

shotarea() {
    grim -g "$(slurp)" - | tee "$file" | wl-copy
    notify_view
}

chosen="$(run_rofi)"
case ${chosen} in
    "$option_1") shotnow ;;
    "$option_2") shotarea ;;
    "$option_3") shotwin ;;
    "$option_4") shot5 ;;
    "$option_5") shot10 ;;
esac
