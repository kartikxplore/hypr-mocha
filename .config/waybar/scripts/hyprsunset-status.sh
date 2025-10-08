#!/bin/bash

if pgrep -x "hyprsunset" > /dev/null; then
    # If hyprsunset is running, show an "on" icon
    ICON="󰌵" # Icon for "on" or "active" (e.g., theme-light-dark)
    TOOLTIP="Hyprsunset is active. Click to disable."
    CLASS="active"
else
    # If hyprsunset is not running, show an "off" icon
    ICON="󰌶" # Icon for "off" or "inactive"
    TOOLTIP="Hyprsunset is inactive. Click to enable."
    CLASS="inactive"
fi

# Output JSON for Waybar
printf '{"text": "%s", "tooltip": "%s", "class": "%s"}\n' "$ICON" "$TOOLTIP" "$CLASS"
