#!/bin/bash

# --- TOGGLE LOGIC ---
# Check if Rofi is already running
if pgrep -x "rofi" > /dev/null; then
    # If it is, kill the Rofi process and exit the script
    pkill -x "rofi"
    exit 0
fi
# --- END TOGGLE LOGIC ---


# Directory where screenshots will be saved
save_dir="${HOME}/Pictures/Screenshots"

# Create the directory if it doesn't exist
mkdir -p "$save_dir"

# Generate a filename with the current date and time
file_name="Screenshot_$(date +%Y-%m-%d_%H-%M-%S).png"
save_path="${save_dir}/${file_name}"

# Use Rofi to present the screenshot options with the Catppuccin Mocha theme
# IMPORTANT: The path below is likely the cause of your theme issue.
# See the troubleshooting guide below the script.
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
        # Check if slurp was cancelled
        if [ $? -eq 0 ]; then
            notify-send "Screenshot Saved" "$file_name"
        else
            notify-send "Screenshot Cancelled"
        fi
        ;;
    *)
        # If no choice is made (e.g., user presses Esc or the toggle is used), do nothing.
        # We don't need a notification here because the toggle is silent.
        ;;
esac