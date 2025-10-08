#!/bin/bash

# Check if bluetooth is powered on
if bluetoothctl show | grep -q "Powered: yes"; then
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