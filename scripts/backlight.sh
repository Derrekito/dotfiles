#!/bin/bash
LEVEL=$1

#echo 24000 | sudo tee /sys/class/backlight/intel_backlight/brightness

echo $LEVEL | sudo tee /sys/class/backlight/intel_backlight/brightness
