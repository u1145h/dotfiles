#!/bin/bash

# Define the path to store the current brightness level
BRIGHTNESS_FILE="$HOME/.config/hypr/monitor_brightness"
BUS=1  # Bus number for HDMI-A-1
STEP=10  # Percentage step for brightness adjustment

# Read the current brightness level
if [ -f "$BRIGHTNESS_FILE" ]; then
    BRIGHTNESS=$(cat "$BRIGHTNESS_FILE")
else
    BRIGHTNESS=50  # Default brightness level
fi

# Adjust the brightness level
case "$1" in
    up)
        BRIGHTNESS=$((BRIGHTNESS + STEP))
        if [ "$BRIGHTNESS" -gt 100 ]; then
            BRIGHTNESS=100
        fi
        ;;
    down)
        BRIGHTNESS=$((BRIGHTNESS - STEP))
        if [ "$BRIGHTNESS" -lt 0 ]; then
            BRIGHTNESS=0
        fi
        ;;
    *)
        echo "Usage: $0 {up|down}"
        exit 1
        ;;
esac

# Set the new brightness level
ddcutil setvcp 10 $BRIGHTNESS --bus $BUS

# Save the current brightness level
echo $BRIGHTNESS > "$BRIGHTNESS_FILE"
