#!/bin/bash

EXTERN='HDMI-0'
HOST='eDP-1-1'


#exec xrandr --output DP-1 --off
#exec xrandr --output eDP-1-1 --auto
#exec xrandr --output DP-0 --left-of eDP-1-1 --auto
#exec xrandr --output HDMI-0 --left-of DP-0 --auto

#xrandr --output $CENTER --auto
#xrandr --output $LEFT --auto
#xrandr --output $RIGHT --auto
#xrandr --output $LEFT --left-of $CENTER --auto
xrandr --output $EXTERN --right-of $HOST --auto


xset s off
xset -dpms
