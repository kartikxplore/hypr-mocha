#!/bin/bash

if pgrep -x "hyprsunset" > /dev/null; then
    # If it's running, kill it
    killall hyprsunset
else
    # If it's not running, start it in the background
    hyprsunset &
fi
