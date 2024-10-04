#!/bin/bash
WALLPAPER_DIR="$HOME/Pictures/Wallpapers"
THUMB_DIR="$WALLPAPER_DIR/thumbnails"
mkdir -p "$THUMB_DIR"

# Create thumbnails for all PNG and JPG files
for img in "$WALLPAPER_DIR"/*.{png,jpg}; do
    img_name=$(basename "$img")
    magick "$img" -resize 300x "$THUMB_DIR/$img_name"
done

