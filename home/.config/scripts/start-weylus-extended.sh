#!/bin/bash

# Start Weylus server in background
weylus --wayland --pipewire &

# Give it a few seconds to initialize
sleep 3

# Mirror the virtual WEYLUS output into Weylus
wl-mirror -o WEYLUS weylus &
