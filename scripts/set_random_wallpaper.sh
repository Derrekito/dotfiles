#!/bin/bash

WALLPAPER_PATH="$HOME/wallpaper"

function get_current_ar()
{
    # Get the resolution of the active display
    RESOLUTION=$(xrandr --current | grep '*' | uniq | awk '{print $1}')
    WIDTH=$(echo $RESOLUTION | cut -d 'x' -f1)
    HEIGHT=$(echo $RESOLUTION | cut -d 'x' -f2)

    # Calculate aspect ratio
    echo "scale=2; $WIDTH/$HEIGHT" | bc
}

function check_ar()
{
    local AR=$1
    echo "$ASPECT_RATIO == $AR" | bc -l
}

ASPECT_RATIO=$(get_current_ar)

ASPECT_RATIO_16_9=$(echo "scale=2; 16/9" | bc)
ASPECT_RATIO_21_9=$(echo "scale=2; 21/9" | bc)
ASPECT_RATIO_43_18=$(echo "scale=2; 43/18" | bc)

# Set the wallpaper directory based on aspect ratio
if (( $(check_ar $ASPECT_RATIO_16_9) )); then
    WALLPAPER_DIR="$WALLPAPER_PATH/16:9"
elif (( $(check_ar $ASPECT_RATIO_21_9) )); then
    WALLPAPER_DIR="$WALLPAPER_PATH/21:9"
else
    WALLPAPER_DIR="$WALLPAPER_PATH/43:18"
fi

# Select a random wallpaper from the appropriate directory
RANDOM_WALLPAPER=$(find "$WALLPAPER_DIR" -type f | shuf -n 1)

# Set the wallpaper
feh --bg-scale "$RANDOM_WALLPAPER"
