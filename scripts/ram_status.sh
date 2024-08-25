#!/bin/bash

# Get the total and used RAM
total=$(free -h | awk '/^Mem/ {print $2}')
used=$(free -h | awk '/^Mem/ {print $3}')

# Get the percentage of RAM used
usage_percentage=$(free | awk '/^Mem/ {print int($3/$2 * 100.0)}')

icon="󰍛"

# Output the icon, fraction (used/total), and usage percentage
echo "$icon $used/$total ($usage_percentage%)"

