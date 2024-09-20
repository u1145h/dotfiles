#!/bin/bash
cliphist list | wofi --show=dmenu | cliphist decode | wl-copy

