#!/bin/bash

# This script toggles a Rofi menu.
# It checks if Rofi is running with a specific theme/command.
# If it is, it kills Rofi. If not, it launches it.

LAUNCHER_SCRIPT="/home/kartik/.config/rofi/launchers/type-7/launcher.sh"

# Check if a rofi process that was started by our launcher is running
if pgrep -f "$LAUNCHER_SCRIPT" > /dev/null; then
    # If it's running, kill all rofi processes
    pkill rofi
else
    # If it's not running, launch it
    "$LAUNCHER_SCRIPT"
fi
