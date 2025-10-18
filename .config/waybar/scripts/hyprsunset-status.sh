#!/bin/bash

if pgrep -x "hyprsunset" > /dev/null; then
    # If hyprsunset is running (filter ON), show moon
    ICON="󰖚" 
    TOOLTIP="Hyprsunset is active. Click to disable."
    CLASS="active"
else
    # If hyprsunset is not running (filter OFF), show sun
    ICON="󰖜"
    TOOLTIP="Hyprsunset is inactive. Click to enable."
    CLASS="inactive"
fi

# Output JSON for Waybar
printf '{"text": "%s", "tooltip": "%s", "class": "%s"}\n' "$ICON" "$TOOLTIP" "$CLASS"