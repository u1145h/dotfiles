#!/bin/bash

# Network interface (change this to your actual interface, e.g., wlan0 for WiFi or eth0 for Ethernet)
INTERFACE="wlan0"

# Icon to display before the speed
ICON=""

# Function to calculate the download speed
get_download_speed() {
    # Read the received bytes from /proc/net/dev for the specified interface
    RX_BYTES_START=$(grep "$INTERFACE" /proc/net/dev | awk '{print $2}')
    sleep 1
    RX_BYTES_END=$(grep "$INTERFACE" /proc/net/dev | awk '{print $2}')

    # Calculate the bytes received in 1 second
    DOWNLOAD_SPEED=$((RX_BYTES_END - RX_BYTES_START))

    # Return the download speed in bytes per second
    echo "$DOWNLOAD_SPEED"
}

# Function to format the speed with appropriate units
format_speed() {
    local speed=$1
    if [ "$speed" -lt 1048576 ]; then
        # If speed is less than 1 MB, display in kB/s
        echo "$ICON $(bc <<< "scale=2; $speed / 1024") kB/s"
    else
        # If speed is 1 MB or more, display in MB/s
        echo "$ICON $(bc <<< "scale=2; $speed / 1048576") MB/s"
    fi
}

# Main loop
while true; do
    download_speed=$(get_download_speed)
    formatted_speed=$(format_speed $download_speed)
    echo "$formatted_speed"
    sleep 1
done
