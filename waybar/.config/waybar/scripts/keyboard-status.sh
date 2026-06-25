#!/bin/bash

STATUS_FILE="${XDG_RUNTIME_DIR:-/run/user/$(id -u)}/keyboard_status"

get_status() {
    if [ -f "$STATUS_FILE" ]; then
        if [ "$(cat "$STATUS_FILE")" = "true" ]; then
            echo "enabled"
        else
            echo "disabled"
        fi
    else
        echo "enabled"  # defau
    fi
}

STATUS=$(get_status)

if [ "$STATUS" = "enabled" ]; then
    ICON="󰌌"
    CLASS="keyboard-enabled"
    TOOLTIP="Internal keyboard ENABLED\n\nCtrl + Esc + Delete → Disable"
else
    ICON="󰌐"
    CLASS="keyboard-disabled"
    TOOLTIP="Internal keyboard DISABLED\n\nCtrl + Esc + Delete → Enable"
fi

echo "{\"text\": \"$ICON\", \"class\": \"$CLASS\", \"tooltip\": \"$TOOLTIP\"}"
