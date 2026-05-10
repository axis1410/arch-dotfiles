#!/usr/bin/env bash

BINDS_FILE="$HOME/.config/hypr/modules/binds.conf"

describe() {
    local action="$1" arg="$2"
    case "$action" in
        exec)
            # shorten known scripts
            arg="${arg##*/}"
            arg="${arg%.sh}"
            echo "Run: $arg" ;;
        killactive)         echo "Close window" ;;
        togglefloating)     echo "Toggle floating" ;;
        togglespecialworkspace) echo "Toggle scratchpad ($arg)" ;;
        movetoworkspace)    echo "Move window → workspace $arg" ;;
        workspace)          echo "Switch workspace $arg" ;;
        movefocus)
            case "$arg" in
                l) echo "Focus left" ;;
                r) echo "Focus right" ;;
                u) echo "Focus up" ;;
                d) echo "Focus down" ;;
                *) echo "Focus $arg" ;;
            esac ;;
        layoutmsg)          echo "Layout: $arg" ;;
        pseudo)             echo "Toggle pseudo tiling" ;;
        *)                  echo "$action${arg:+ $arg}" ;;
    esac
}

parse_binds() {
    while IFS= read -r line; do
        [[ "$line" =~ ^[[:space:]]*(#|$|\$|bindm) ]] && continue
        [[ "$line" =~ ^[[:space:]]*bind ]] || continue

        line="${line#*=}"
        line="${line#"${line%%[! ]*}"}"

        IFS=',' read -r mods key action arg <<< "$line"
        mods="${mods// /}"
        key="${key// /}"
        action="${action// /}"
        arg="${arg## }"
        arg="${arg%% *}"   # first word only

        mods="${mods/\$mainMod/Super}"
        mods="${mods/SHIFT/ Shift}"
        mods="${mods## }"

        [[ -n "$mods" ]] && combo="$mods + $key" || combo="$key"

        label="$(describe "$action" "$arg")"
        printf '%-32s  %s\n' "$combo" "$label"
    done < "$BINDS_FILE"
}

parse_binds | rofi -dmenu -p "󰌌  Keybinds" -i -no-custom \
    -theme-str '
        window    { width: 640px; }
        listview  { lines: 18; }
        entry     { placeholder: "Filter..."; }
    '
