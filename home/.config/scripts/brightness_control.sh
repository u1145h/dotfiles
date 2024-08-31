#!/bin/bash

# Define paths to store current brightness levels for each monitor
BRIGHTNESS_FILE_HDMI="$HOME/.config/scripts/monitor-brightness/monitor_brightness_hdmi"
BRIGHTNESS_FILE_DP="$HOME/.config/scripts/monitor-brightness/monitor_brightness_dp"

# Define the bus numbers for the monitors
BUS_HDMI=2  # Bus number for HDMI-A-1
BUS_DP=3    # Bus number for DP-1

STEP=10  # Percentage step for brightness adjustment

# Function to read the current brightness level
read_brightness() {
    if [ -f "$1" ]; then
        cat "$1"
    else
        echo 50  # Default brightness level
    fi
}

# Function to adjust brightness
adjust_brightness() {
    local brightness=$1
    local step=$2
    local direction=$3

    if [ "$direction" == "up" ]; then
        brightness=$((brightness + step))
        if [ "$brightness" -gt 100 ]; then
            brightness=100
        fi
    elif [ "$direction" == "down" ]; then
        brightness=$((brightness - step))
        if [ "$brightness" -lt 0 ]; then
            brightness=0
        fi
    else
        echo "Invalid direction: $direction"
        exit 1
    fi

    echo $brightness
}

# Function to set the brightness using ddcutil
set_brightness() {
    local bus=$1
    local brightness=$2
    ddcutil setvcp 10 $brightness --bus $bus
}

# Determine which monitor to adjust based on the first argument (hdmi/dp)
case "$1" in
    hdmi)
        BRIGHTNESS_FILE=$BRIGHTNESS_FILE_HDMI
        BUS=$BUS_HDMI
        ;;
    dp)
        BRIGHTNESS_FILE=$BRIGHTNESS_FILE_DP
        BUS=$BUS_DP
        ;;
    *)
        echo "Usage: $0 {hdmi|dp} {up|down}"
        exit 1
        ;;
esac

# Read the current brightness level
BRIGHTNESS=$(read_brightness "$BRIGHTNESS_FILE")

# Adjust the brightness level based on the second argument (up/down)
BRIGHTNESS=$(adjust_brightness $BRIGHTNESS $STEP "$2")

# Set the new brightness level
set_brightness $BUS $BRIGHTNESS

# Save the current brightness level
echo $BRIGHTNESS > "$BRIGHTNESS_FILE"
