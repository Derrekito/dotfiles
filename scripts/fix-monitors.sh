#!/bin/bash

# Detect connected monitors
connected_monitors=$(xrandr | grep ' connected' | awk '{ print $1 }')
monitor_array=($connected_monitors)
echo "Monitor array: $monitor_array"
num_monitors=${#monitor_array[@]}
echo "Num Monitors: ${#monitor_array[@]}"

# Default monitor settings
primary_monitor=${monitor_array[0]}
echo "primary: $primary_monitor"

secondary_monitor=${monitor_array[1]}
echo "secondary: $secondary_monitor"

# Usage information if no arguments
if [[ -z "$1" ]]; then
    echo "Usage: $0 [home|extern|work|local]"
    exit 1
fi

LOCATION="$1"

echo "Location set to: $LOCATION"

# Configuration based on location
case $LOCATION in
    home)
        echo "Setting home monitor setup"
        if [[ $num_monitors -gt 1 ]]; then
            xrandr --output $secondary_monitor --auto
            xrandr --output $primary_monitor --auto --right-of $secondary_monitor
        else
            echo "Not enough monitors connected for dual setup."
        fi
        ;;
    extern)
        echo "Setting external only monitor setup"
        if [[ $num_monitors -gt 1 ]]; then
            xrandr --output $primary_monitor --off
            xrandr --output $secondary_monitor --auto
        else
            echo "Only one monitor connected, using as primary."
            xrandr --output $primary_monitor --auto
            xrandr --output $secondary_monitor --off
        fi
        ;;
    work)
        echo "Setting work monitor setup"
        if [[ $num_monitors -gt 1 ]]; then
            xrandr --output $primary_monitor --auto --right-of $secondary_monitor
            xrandr --output $secondary_monitor --auto --left-of $primary_monitor
        else
            echo "Not enough monitors connected for dual setup."
        fi
        ;;
    local)
        echo "Setting local only monitor setup"
        # Dynamically find the laptop display, assuming it starts with 'eDP'
        laptop_monitor=$(echo "$connected_monitors" | grep 'eDP')
        # Turn off all monitors first
        for monitor in "${monitor_array[@]}"; do
            if [ "$monitor" != "$laptop_monitor" ]; then
                xrandr --output $monitor --off
            fi
        done
        # Now enable only the laptop's display
        xrandr --output $laptop_monitor --auto
        ;;
    *)
        echo "Invalid location specified."
        echo "Please specify one of the following options: home, extern, work, local"
        exit 2
        ;;
esac

# Disable screen saver and power management
#xset s off
#xset -dpms
