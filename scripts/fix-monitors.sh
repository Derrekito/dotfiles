#!/bin/bash

LEFT='HDMI-1'
RIGHT='eDP-1-1'
CENTER='DP-0'

LOCATION="$1"

echo $LOCATION

if [ "$LOCATION" == "home" ]; then
    echo "setting home monitor setup"
    LEFT='HDMI-1'
#    xrandr --output $CENTER --auto
    xrandr --output $LEFT --left-of $RIGHT --auto
    xrandr --output $RIGHT --right-of $LEFT --auto
fi

if [ "$LOCATION" == "extern" ]; then
    echo "setting home external only monitor setup"
    LEFT='HDMI-1'
#    xrandr --output $CENTER --auto
    xrandr --output $LEFT --left-of $RIGHT --auto
    xrandr --output $RIGHT --off
fi

if [ "$LOCATION" == "work" ]; then
    LEFT='HDMI-0'
    echo "setting work monitor setup"
    xrandr --output $LEFT --right-of $RIGHT --auto
fi

if [ "$LOCATION" == "local" ]; then
    echo "setting local only monitor setup"
    xrandr --output $LEFT --off
    xrandr --output $RIGHT --auto
fi

if [ "$LOCATION" == "" ]; then
    echo "enter arg 'work', 'home', or 'local'"
    exit 1
fi

xset s off
xset -dpms
