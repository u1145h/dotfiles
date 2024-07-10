#!/bin/bash

case $1 in
    "normal")
        paplay /home/u1145h/.config/dunst/sound/noti_normal.ogg
        ;;
    "critical")
        paplay /home/u1145h/.config/dunst/sound/noti_critical.ogg
        ;;
esac
