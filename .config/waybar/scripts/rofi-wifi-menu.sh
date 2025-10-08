#!/usr/bin/env bash

# Get a list of available wifi connections and their status
# Icons:  for secure,  for open
wifi_list=$(nmcli --fields "SECURITY,SSID" device wifi list | sed 1d | sed 's/  */ /g' | sed -E "s/WPA*.?\S/ /g" | sed "s/^--/ /g" | sed "s/  //g" | sed "/--/d")

connected=$(nmcli -fields WIFI g)
if [[ "$connected" =~ "enabled" ]]; then
	toggle="󰖩  Disable Wi-Fi"
else
	toggle="󰖨  Enable Wi-Fi"
fi

# Use Rofi to present menu, applying dynamic sizing
chosen_network=$(echo -e "$toggle\n$wifi_list" | uniq -u | rofi -dmenu -i -p "󰤨 Wi-Fi" -theme-str 'window {width: 400px;}' -theme-str 'listview {lines: 6;}')

# Actions based on user selection
if [ "$chosen_network" = "󰖩  Disable Wi-Fi" ]; then
	nmcli radio wifi off
elif [ "$chosen_network" = "󰖨  Enable Wi-Fi" ]; then
	nmcli radio wifi on
elif [ -n "$chosen_network" ]; then
	# Get SSID by stripping leading icon and space
	ssid=$(echo "$chosen_network" | sed 's/^..//')

	# Check if the network is already a known connection
	if nmcli connection show | grep -q "^$ssid "; then
		# If it is, just connect to it
		nmcli connection up "$ssid"
	else
		# If it's a new network, ask for a password
		if echo "$chosen_network" | grep -q ""; then
			wifi_password=$(rofi -dmenu -password -p "Password for $ssid")
		fi
		nmcli device wifi connect "$ssid" password "$wifi_password"
	fi
fi
