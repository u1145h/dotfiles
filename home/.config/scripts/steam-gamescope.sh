#!/bin/bash
# Wrapper to launch Steam via Gamescope on NVIDIA hybrid GPU

# Force NVIDIA PRIME offload
export __NV_PRIME_RENDER_OFFLOAD=1
export __GLX_VENDOR_LIBRARY_NAME=nvidia
export __VK_LAYER_NV_optimus=NVIDIA_only

# Optional SDL tweaks for better colors
export SDL_VIDEO_ALLOW_SCREENSAVER=0
export SDL_VIDEO_RGB=1

# Run Gamescope with recommended options
gamescope --backend sdl -W 1920 -H 1080 --adaptive-sync --force-grab-cursor -f -- steam -gamepadui
