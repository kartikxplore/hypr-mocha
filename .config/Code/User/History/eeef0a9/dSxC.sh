#!/bin/bash

# Check if bluetooth is powered on
if bluetoothctl show | grep -q "Powered: yes"; then// ██╗    ██╗ █████╗ ██╗   ██╗██████╗  █████╗ ██████╗ 
// ██║    ██║██╔══██╗╚██╗ ██╔╝██╔══██╗██╔══██╗██╔══██╗
// ██║ █╗ ██║███████║ ╚████╔╝ ██████╔╝███████║██████╔╝
// ██║███╗██║██╔══██║  ╚██╔╝  ██╔══██╗██╔══██║██╔══██╗
// ╚███╔███╔╝██║  ██║   ██║   ██████╔╝██║  ██║██║  ██║
//  ╚══╝╚══╝ ╚═╝  ╚═╝   ╚═╝   ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝
{
    // "layer": "top", // Waybar at top layer
    // "position": "bottom", // Waybar position (top|bottom|left|right)
    // "height": 30, // Waybar height (to be removed for auto height)
    "margin": "10 10 0 10",
    // "width": 1280, // Waybar width
    // Choose the order of the modules
    "modules-left": [
        "hyprland/workspaces",
        "hyprland/window",
        "keyboard-state",
        "custom/pacman"
    ],
    "modules-center": [
        "clock"
    ],
    "modules-right": [
        "pulseaudio",
        "backlight",
        "custom/hyprsunset",
        "network",
        "custom/bluetooth"
    ],
    //***************************
    //* Modules configuration  *
    //***************************
    "hyprland/workspaces": {
        "persistent-workspaces": {
            "*": 5
        }
    },
    "hyprland/language": {
        "format": "{} 󰌓",
        "min-length": 5,
        "tooltip": false
    },
    "hyprland/window": {
        "max-length": 20
    },
    "keyboard-state": {
        //"numlock": true,
        "capslock": true,
        "format": "{name} {icon}",
        "format-icons": {
            "locked": "󰌾",
            "unlocked": "󰌿"
        }
    },
    "custom/pacman": {
        "format": "{} ",
        "interval": 7200, // every 2 hours
        "exec": "(checkupdates; yay -Qu) | wc -l",
        "exec-if": "which checkupdates && which yay",
        "on-click": "kitty --title 'System Update' -e sh -c 'yay -Syu; echo \"Done - Press enter to exit\"; read'",
        "tooltip": true
    },
    "clock": {
        // "timezone": "America/New_York",
        "tooltip-format": "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>",
        "format": "{:%a, %d %b, %I:%M %p}"
    },
    "pulseaudio": {
        // "scroll-step": 1, // %, can be a float
        "reverse-scrolling": 1,
        "format": "{volume}% {icon} {format_source}",
        "format-bluetooth": "{volume}% {icon}󰂯 {format_source}",
        "format-bluetooth-muted": "󰂲 {icon}󰂯 {format_source}",
        "format-muted": "󰸈 {format_source}",
        "format-source": "{volume}% 󰍬",
        "format-source-muted": "󰍭",
        "format-icons": {
            "headphone": "󰋋",
            "hands-free": "󰋎",
            "headset": "󰋎",
            "phone": "󰄜",
            "portable": "󰄜",
            "car": "󰄋",
            "default": [
                "󰕿",
                "󰖀",
                "󰕾"
            ]
        },
        "on-right-click": "pactl set-sink-mute @DEFAULT_SINK@ toggle",
        "on-scroll-up": "pactl set-sink-volume @DEFAULT_SINK@ +5%",
        "on-scroll-down": "pactl set-sink-volume @DEFAULT_SINK@ -5%",
        "on-click": "pavucontrol",
        "min-length": 13
    },
    "network": {
        "format-wifi": "{essid} ({signalStrength}%) 󰤨",
        "format-ethernet": "{ipaddr}/{cidr} 󰈀",
        "tooltip-format": "{ifname} via {gwaddr} 󰢳",
        "format-linked": "{ifname} (No IP) 󰌙",
        "format-disconnected": "Disconnected 󰤮",
        "on-click": "iwdgui"
    },
    "custom/bluetooth": {
        "format": "{}",
        "interval": 15,
        "exec": "~/.config/waybar/scripts/bluetooth.sh",
        "on-click": "overskride",
        "tooltip": true
    },
    "backlight": {
        "device": "intel_backlight",
        "format": "{percent}% {icon}",
        "format-icons": [
            "󰃞",
            "󰃞",
            "󰃝",
            "󰃝",
            "󰃚",
            "󰃚",
            "󰃛"
        ],
        "min-length": 7
    },
    "custom/hyprsunset": {
        "format": "{}",
        "exec": "~/.config/waybar/scripts/hyprsunset-status.sh", 
        "on-click": "~/.config/waybar/scripts/toggle-hyprsunset.sh && pkill -SIGRTMIN+8 waybar", 
        "interval": 5,
        "tooltip": true 
    },
    // "battery": {
    //     "bat": "BAT0",
    //     "states": {
    //         "warning": 30,
    //         "critical": 15
    //     },
    //     "format": "{capacity}% {icon}",
    //     "format-charging": "{capacity}% 󰂄",
    //     "format-plugged": "{capacity}% 󰚥",
    //     "format-alt": "{time} {icon}",
    //     "format-icons": ["󰂎", "󰁺", "󰁻", "󰁼", "󰁽", "󰁾", "󰁿", "󰂀", "󰂁", "󰁹"]
    // },
    "tray": {
        "icon-size": 16,
        "spacing": 0
    }
}
    # Get information about the first connected device
    DEVICE_INFO=$(bluetoothctl devices Connected | head -n 1)

    # Check if a device is connected
    if [ -n "$DEVICE_INFO" ]; then
        # Get the device's MAC address
        DEVICE_MAC=$(echo "$DEVICE_INFO" | awk '{print $2}')
        
        # Convert MAC address to the format upower uses (e.g., dev_XX_XX_XX_XX_XX_XX)
        UPOWER_PATH_MAC=$(echo "$DEVICE_MAC" | tr ':' '_')
        
        # Find the full device path in upower
        DEVICE_PATH=$(upower -e | grep -E "(headset|hands-free)_dev_${UPOWER_PATH_MAC}")

        # Check if a battery path was found for the device
        if [ -n "$DEVICE_PATH" ]; then
            # Get the battery percentage
            PERCENTAGE=$(upower -i "$DEVICE_PATH" | grep "percentage:" | awk '{print $2}')

            if [ -n "$PERCENTAGE" ]; then
                # Show connected icon and battery percentage
                echo "󰂱 ${PERCENTAGE}"
            else
                # Device found, but no percentage. Show generic connected status.
                echo "󰂱 Connected"
            fi
        else
            # Device is connected, but not found by upower. Show generic connected status.
            echo "󰂱 Connected"
        fi
    else
        # Bluetooth is on but no device is connected
        echo "󰂯 On"
    fi
else
    # Bluetooth is off
    echo "󰂲 Off"
fi