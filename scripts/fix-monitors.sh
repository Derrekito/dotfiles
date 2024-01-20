#!/bin/bash

LEFT='HDMI-0'
RIGHT='eDP-1-1'
CENTER='DP-0'

LOCATION="$1"

echo $LOCATION

if [ "$LOCATION" == "home" ]; then
    echo "setting home monitor setup"
    xrandr --output $CENTER --auto
    xrandr --output $LEFT --left-of $CENTER --auto
    xrandr --output $RIGHT --right-of $CENTER --auto
fi

if [ "$LOCATION" == "work" ]; then
    echo "setting work monitor setup"
    xrandr --output $LEFT --right-of $RIGHT --auto
fi

if [ "$LOCATION" == "" ]; then
    echo "enter arg 'work' or 'home'"
    exit 1
fi

xset s off
xset -dpms
