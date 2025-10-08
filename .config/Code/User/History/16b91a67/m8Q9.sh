#!/bin/bash

# Directory where screenshots will be saved
save_dir="${HOME}/Pictures/Screenshots"

# Create the directory if it doesn't exist
mkdir -p "$save_dir"

# Generate a filename with the current date and time
file_name="Screenshot_$(date +%Y-%m-%d_%H-%M-%S).png"
save_path="${save_dir}/${file_name}"

# Use Rofi to present the screenshot options with the Catppuccin Mocha theme
# IMPORTANT: Replace the path below with the correct path to YOUR theme file.
choice=$(echo -e "Fullscreen\nSelected Area" | rofi -dmenu -p "📷 Screenshot" -i -theme ~/.config/rofi/themes/catppuccin-mocha.rasi)

# Take action based on the user's choice
case $choice in
    "Fullscreen")
        # Take a screenshot of the entire screen
        grim "$save_path"
        notify-send "Screenshot Saved" "$file_name"
        ;;
    "Selected Area")
        # Take a screenshot of a selected area
        grim -g "$(slurp)" "$save_path"
        # Check if slurp was cancelled (grim returns a non-zero exit code)
        if [ $? -eq 0 ]; then
            notify-send "Screenshot Saved" "$file_name"
        else
            notify-send "Screenshot Cancelled"
        fi
        ;;
    *)
        # If no choice is made (e.g., user presses Esc), do nothing
        notify-send "Screenshot Cancelled"
        ;;
esac