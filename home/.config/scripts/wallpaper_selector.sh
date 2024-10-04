#!/bin/bash
WALLPAPER_DIR="$HOME/Pictures/Wallpapers"
THUMB_DIR="$WALLPAPER_DIR/thumbnails"

# Get the selected wallpaper from Rofi
SELECTED_WALLPAPER=$(ls "$THUMB_DIR" | rofi -dmenu -i -p "Select Wallpaper" -theme-str 'element { width: 300px; height: auto; }')

if [ -z "$SELECTED_WALLPAPER" ]; then
    exit 1
fi

# Get the selected output (display) from Rofi
SELECTED_OUTPUT=$(echo -e "eDP-1\nHDMI-A-1\nDP-1" | rofi -dmenu -i -p "Select Display")

if [ -z "$SELECTED_OUTPUT" ]; then
    exit 1
fi

# Apply the wallpaper using swww
swww img "$WALLPAPER_DIR/$SELECTED_WALLPAPER" --outputs "$SELECTED_OUTPUT"

