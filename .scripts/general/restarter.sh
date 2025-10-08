#!/bin/bash

component=$(printf "%s\n" \
  "dunst" \
  "waybar" \
  "hyprland" | rofi -dmenu -i -p "Restart..." -theme ~/.config/rofi/launchers/project/restart.rasi)

case $component in
  "dunst")
    pkill dunst && dunst & ;;
  "waybar")
    pkill waybar && waybar & ;;
  "hyprland")
    hyprctl reload ;;
esac

