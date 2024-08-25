#!/bin/bash

# Get battery percentage
battery_percentage=$(cat /sys/class/power_supply/BAT0/capacity)
charging_status=$(cat /sys/class/power_supply/BAT0/status)

# Set the icon based on battery percentage and charging status
if [ "$charging_status" = "Charging" ]; then
    icon="󰂄"  # Charging
elif [ "$battery_percentage" -ge 80 ]; then
    icon="󰁹"  # Full Battery
elif [ "$battery_percentage" -ge 60 ]; then
    icon="󰁽"  # Three-Quarters Battery
elif [ "$battery_percentage" -ge 40 ]; then
    icon="󰁻"  # Half Battery
elif [ "$battery_percentage" -ge 20 ]; then
    icon="󰁺"  # Quarter Battery
else
    icon="󰁺"  # Empty Battery
fi

# Output the icon and battery percentage
echo "$icon $battery_percentage%"

