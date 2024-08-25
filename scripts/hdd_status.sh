#!/bin/bash

# Define the partition to monitor (e.g., / for root)
partition="/"

# Get the total and used disk space
total=$(df -h "$partition" | awk 'NR==2 {print $2}')
used=$(df -h "$partition" | awk 'NR==2 {print $3}')

# Calculate the percentage of disk usage
usage_percentage=$(df -h "$partition" | awk 'NR==2 {print $5}' | sed 's/%//')

icon="󰋊"

# Output the icon, fraction (used/total), and usage percentage
echo "$icon $used/$total ($usage_percentage%)"
