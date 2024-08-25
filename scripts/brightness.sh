#!/bin/bash

# Get the current and maximum brightness values
current=$(brightnessctl get)
max=$(brightnessctl max)

# Check which button was pressed
case "$1" in
    1)  # Left click - Increase brightness
        brightnessctl set +10%
        ;;
    3)  # Right click - Decrease brightness
        brightnessctl set 10%-
        ;;
esac

# Always display current brightness percentage
echo $((current * 100 / max))
