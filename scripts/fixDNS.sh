#!/bin/bash

# Set the default DNS server for wlo1
sudo nmcli connection modify wlo1 ipv4.dns "8.8.8.8 8.8.4.4"

# Restart the network-manager service to apply the changes
sudo systemctl restart NetworkManager

# Verify the changes
nmcli -p connection show wlo1 | grep 'IP4.DNS'
