#!/bin/bash

# Check if control panel is open
if eww active-windows | grep -q "control-panel"; then
    eww close control-panel
else
    eww open control-panel
fi
