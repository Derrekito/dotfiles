#!/bin/bash
#
# Add the current normal user to a dev group.
#

# Check if the script is run with sudo privileges
if [ "$(id -u)" -ne 0 ]; then
    echo "This script must be run as root."
    exit 1
fi

# Check if an argument is provided
if [ $# -eq 0 ]; then
    echo "Usage: $0 /dev/some_device"
    exit 1
fi

DEV_PATH="$1"

# get group associated with the device
GROUP=$(ls -l $DEV_PATH | awk '{print $4}')

# verify group exists in the database
if getent group "$GROUP" >/dev/null; then
    # Get the original user (who invoked sudo)
    # if SUDO_USER isn't set, then it defaults to whoami output
    ORIGINAL_USER="${SUDO_USER:-$(whoami)}"

    # Add the original user to the group
    usermod -a -G "$GROUP" "$ORIGINAL_USER"

    echo "User $ORIGINAL_USER has been added to the group $GROUP."
else
    echo "Group not found for device $DEV_PATH"
    exit 1
fi
