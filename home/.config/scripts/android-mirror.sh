#!/bin/bash

# Paths for scrcpy
SCRCPY_NORMAL="scrcpy"
SCRCPY_NO_SECURE="scrcpy-no-secure"

# Check if scrcpy-no-secure exists, otherwise use normal scrcpy
if command -v $SCRCPY_NO_SECURE &> /dev/null; then
    SCRCPY_CMD=$SCRCPY_NO_SECURE
else
    SCRCPY_CMD=$SCRCPY_NORMAL
fi

# Optional: Try enabling Shizuku if installed
adb shell sh /storage/emulated/0/Android/data/moe.shizuku.privileged.api/start.sh > /dev/null 2>&1

# Run scrcpy with desired options
$SCRCPY_CMD --turn-screen-off -m 800 -b 2M --max-fps=30 --video-codec=h264

