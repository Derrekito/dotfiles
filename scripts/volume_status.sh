#!/bin/bash

# Get the current volume level and mute status
volume=$(pamixer --get-volume)
mute_status=$(pamixer --get-mute)

# Set the icon based on the volume level and mute status
if [ "$mute_status" = "true" ]; then
    icon="󰖁"  # Muted
    output="$icon"
elif [ "$volume" -ge 75 ]; then
    icon="󰕾"  # High Volume
    output="$icon $volume%"
elif [ "$volume" -ge 40 ]; then
    icon="󰖀"  # Medium Volume
    output="$icon $volume%"
elif [ "$volume" -ge 1 ]; then
    icon="󰕿"  # Low Volume
    output="$icon $volume%"
else
    icon="󰖁"  # Muted or No Volume
    output="$icon"
fi

# Output the icon and volume percentage (if not muted)
echo "$output"
