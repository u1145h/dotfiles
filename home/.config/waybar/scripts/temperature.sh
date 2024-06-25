#!/bin/bash

temp=$(sensors | grep -i 'Package id 0:' | awk '{print $4}' | sed 's/+//;s/°C//')

# Set temperature icons
if (( $(echo "$temp < 30" | bc -l) )); then
    icon=""
elif (( $(echo "$temp < 60" | bc -l) )); then
    icon=""
else
    icon=""
fi

echo -e "{\"text\":\"$icon $temp°C\",\"tooltip\":\"CPU Temperature: $temp°C\"}"

