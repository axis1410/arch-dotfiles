#!/usr/bin/env bash

# ── helpers ────────────────────────────────────────────────
notify() { notify-send "Network" "$1" --icon=network-wireless; }

connected_ssid() {
    nmcli -t -f active,ssid dev wifi 2>/dev/null | awk -F: '/^yes/{print $2}'
}

connected_iface() {
    nmcli -t -f device,type,state dev 2>/dev/null | awk -F: '$3=="connected"{print $1; exit}'
}

# ── scan & build menu ──────────────────────────────────────
nmcli dev wifi rescan 2>/dev/null &

CURRENT=$(connected_ssid)
IFACE=$(connected_iface)

# Build list: connected network first with a marker, then the rest
WIFI_LIST=$(nmcli -t -f ssid,signal,security dev wifi list 2>/dev/null \
    | awk -F: '!seen[$1]++ && $1!=""' \
    | while IFS=: read -r ssid signal sec; do
        lock=""
        [[ "$sec" != "--" && -n "$sec" ]] && lock=" 󰌾"
        bar="▂▄▆█"
        idx=$(( (signal * 4 / 101) ))
        [[ $idx -gt 3 ]] && idx=3
        strength="${bar:$idx:1}"
        if [[ "$ssid" == "$CURRENT" ]]; then
            printf "󰖩  %-32s %s%s  [connected]\n" "$ssid" "$strength" "$lock"
        else
            printf "   %-32s %s%s\n" "$ssid" "$strength" "$lock"
        fi
    done)

# Extra actions at the bottom
ACTIONS=""
if [[ -n "$IFACE" ]]; then
    ACTIONS=$'\n'"󰖪  Disconnect"
fi
ACTIONS+=$'\n'"󰑓  Rescan"

MENU="${WIFI_LIST}${ACTIONS}"

# ── rofi prompt ────────────────────────────────────────────
CHOICE=$(printf "%s" "$MENU" | rofi -dmenu -p "Network" \
    -theme-str '
        window  { width: 420px; location: northeast; anchor: northeast; x-offset: -12px; y-offset: 46px; }
        listview { lines: 10; }
    ')

[[ -z "$CHOICE" ]] && exit 0

# ── actions ────────────────────────────────────────────────
case "$CHOICE" in
    *"Disconnect")
        nmcli dev disconnect "$IFACE" && notify "Disconnected from $CURRENT"
        ;;
    *"Rescan")
        nmcli dev wifi rescan && notify "Rescanned networks"
        ;;
    *)
        # Extract SSID (strip leading icon + spaces)
        SSID=$(echo "$CHOICE" | sed 's/^[^ ]* *//' | sed 's/  .*//' | xargs)
        if [[ "$SSID" == "$CURRENT" ]]; then
            notify "Already connected to $SSID"
            exit 0
        fi
        # Try saved connection first, else prompt for password
        if nmcli con up "$SSID" 2>/dev/null; then
            notify "Connected to $SSID"
        else
            PASS=$(rofi -dmenu -p "Password for $SSID" \
                -theme-str 'window { width: 360px; location: northeast; anchor: northeast; x-offset: -12px; y-offset: 46px; } listview { lines: 0; }' \
                -password)
            [[ -z "$PASS" ]] && exit 0
            if nmcli dev wifi connect "$SSID" password "$PASS"; then
                notify "Connected to $SSID"
            else
                notify "Failed to connect to $SSID"
            fi
        fi
        ;;
esac
