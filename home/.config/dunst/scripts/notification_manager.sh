#!/bin/bash

# Paths for dunst files
DUNST_PAUSE_FILE="$HOME/.config/dunst/pause_dunst"
DUNST_DISMISS_FILE="$HOME/.config/dunst/dismissed_notifications"

# Function to toggle DND mode
toggle_dnd() {
    if [ -f "$DUNST_PAUSE_FILE" ]; then
        rm "$DUNST_PAUSE_FILE"
        dunstctl set-paused false
    else
        touch "$DUNST_PAUSE_FILE"
        dunstctl set-paused true
    fi
}

# Function to clear all notifications
clear_notifications() {
    > "$DUNST_DISMISS_FILE"
}

# Function to show notification panel
show_notification_panel() {
    dunstctl history | jq -r '.data[] | .msg' | rofi -dmenu -p "Notifications"
}

case "$1" in
    toggle_dnd)
        toggle_dnd
        ;;
    clear_notifications)
        clear_notifications
        ;;
    show_notification_panel)
        show_notification_panel
        ;;
    *)
        echo "Invalid option"
        ;;
esac

