#!/usr/bin/env bash

DIRECTION=$1  # +1 for next, -1 for previous

# Get current workspace ID
CURRENT_WS=$(hyprctl activeworkspace | grep -oP 'workspace ID \K\d+')

# Calculate target workspace
TARGET_WS=$((CURRENT_WS + DIRECTION))

# Ensure target workspace is positive
if [ "$TARGET_WS" -lt 1 ]; then
  TARGET_WS=1
fi

# Move the active window to the target workspace
hyprctl dispatch movetoworkspace "$TARGET_WS"

# Follow the window to the target workspace
hyprctl dispatch workspace "$TARGET_WS"
