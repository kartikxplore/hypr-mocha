#!/bin/bash

# --- TOGGLE LOGIC ---
if pgrep -x "rofi" > /dev/null; then
    pkill -x "rofi"
    exit 0
fi
# --- END TOGGLE LOGIC ---


# Directory where screenshots will be saved
save_dir="${HOME}/Pictures/Screenshots"
mkdir -p "$save_dir"

# Generate a filename with the current date and time
file_name="Screenshot_$(date +%Y-%m-%d_%H-%M-%S).png"
save_path="${save_dir}/${file_name}"

# --- Options with Nerd Font Icons ---
# You can find more icons at https://www.nerdfonts.com/cheat-sheet
fullscreen_icon="󰹑" # nf-md-fullscreen
area_icon="󰆞" # nf-md-crop

option1="$fullscreen_icon Fullscreen"
option2="$area_icon Selected Area"
options="$option1\n$option2"


# Use Rofi to present the screenshot options
choice=$(echo -e "$options" | rofi -dmenu -p "📷 Screenshot" -i -theme ~/.config/rofi/themes/catppuccin-mocha.rasi)

# Take action based on the user's choice
# IMPORTANT: The case statement now matches the options with icons
case $choice in
    "$option1")
        # Take a screenshot of the entire screen
        grim "$save_path"
        notify-send "Screenshot Saved" "$file_name"
        ;;
    "$option2")
        # Take a screenshot of a selected area
        grim -g "$(slurp)" "$save_path"
        if [ $? -eq 0 ]; then
            notify-send "Screenshot Saved" "$file_name"
        else
            notify-send "Screenshot Cancelled"
        fi
        ;;
    *)
        # If no choice is made, do nothing.
        ;;
esac