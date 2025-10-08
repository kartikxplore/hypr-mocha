#!/bin/bash

# A script to switch between desktop themes, including wallpapers.

# --- CONFIGURATION ---
# IMPORTANT: Update these paths to point to your actual wallpapers!
CATPPUCCIN_WALLPAPER="$HOME/Pictures/Wallpapers/cat2.png"
EVERFOREST_WALLPAPER="$HOME/Pictures/Wallpapers/walev.png"

# --- SCRIPT VARIABLES ---
THEME=$1
THEME_DIR="$HOME/.config/themes"

# Destination directories
HYPR_DIR="$HOME/.config/hypr"
WAYBAR_DIR="$HOME/.config/waybar"
ROFI_DIR="$HOME/.config/rofi"
DUNST_DIR="$HOME/.config/dunst"
KITTY_DIR="$HOME/.config/kitty"

# --- SCRIPT LOGIC ---

# Check if a theme name was provided.
if [ -z "$THEME" ]; then
    echo "❌ Error: No theme specified."
    echo "Usage: $0 [everforest|catppuccin]"
    exit 1
fi

# Check if the theme directory exists.
if [ ! -d "$THEME_DIR/$THEME" ]; then
    echo "❌ Error: Theme '$THEME' not found in $THEME_DIR"
    exit 1
fi

echo "🎨 Switching theme to: $THEME"

# --- FILE COPYING ---

echo "-> Applying Hyprland & Hyprlock themes..."
cp -rfv "$THEME_DIR/$THEME/hypr/"* "$HYPR_DIR/"

echo "-> Applying Waybar theme..."
cp -fv "$THEME_DIR/$THEME/waybar/style.css" "$WAYBAR_DIR/style.css"

echo "-> Applying Dunst theme..."
cp -fv "$THEME_DIR/$THEME/dunst/dunstrc" "$DUNST_DIR/dunstrc"

echo "-> Applying Rofi themes..."
cp -rfv "$THEME_DIR/$THEME/rofi/"* "$ROFI_DIR/"

echo "-> Applying Kitty theme..."
cp -fv "$THEME_DIR/$THEME/kitty/current-theme.conf" "$KITTY_DIR/current-theme.conf"


# --- RELOAD SERVICES & SET WALLPAPER ---
echo "-> Reloading services and setting wallpaper..."

# Select the correct wallpaper path based on the theme
if [ "$THEME" == "catppuccin" ]; then
    WALLPAPER=$CATPPUCCIN_WALLPAPER
elif [ "$THEME" == "everforest" ]; then
    WALLPAPER=$EVERFOREST_WALLPAPER
else
    echo "⚠️ Warning: No wallpaper defined for theme '$THEME'."
    exit 1 # Exit if no wallpaper is found to avoid issues
fi

# Set the new wallpaper
# killall swaybg stops the old wallpaper process.
# swaybg -i ... starts the new one in the background (&).
killall swaybg && swaybg -i "$WALLPAPER" -m fill &

# Reload Waybar
killall -SIGUSR2 waybar

# Reload Dunst
killall dunst && dunst &

# Reload colors in all running Kitty instances
kitty @ set-colors --all --configured "$KITTY_DIR/current-theme.conf"

echo "✅ Theme switch to '$THEME' complete!"
