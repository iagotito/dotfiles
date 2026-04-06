#!/usr/bin/env bash

DIR=$1  # l r u d

# Get current monitor before focus change
BEFORE_MON=$(hyprctl activewindow -j | jq -r '.monitor')

# Move focus using hy3
hyprctl dispatch hy3:movefocus "$DIR"

# Small delay to let Hyprland update state
sleep 0.02

# Get monitor after focus change
AFTER_MON=$(hyprctl activewindow -j | jq -r '.monitor')

# If monitor changed, move cursor to center of focused window
if [ "$BEFORE_MON" != "$AFTER_MON" ]; then
    hyprctl dispatch movecursor 0 0
fi
