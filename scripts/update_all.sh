#!/bin/bash

# Usage: update_all.sh [AUR_DIRECTORY]
# Default AUR directory if not provided
aur_package_dir="${1:-$HOME/aur_packages}"

# Log file for script output
log_file="/tmp/update.log"

# Log function
function log {
    echo "[$(date +'%Y-%m-%d %H:%M:%S')] $1" | tee -a "$log_file"
}

# Check for required commands
for cmd in flatpak pacman yay; do
    if ! command -v $cmd &> /dev/null; then
        log "$cmd could not be found, please install $cmd"
        exit 1
    fi
done

# Function to update Flatpak
function update_flatpak {
    log "Updating Flatpak..."
    flatpak update --noninteractive 2>&1 | tee -a "$log_file"
    log "Removing unused Flatpak runtimes and apps..."
    flatpak uninstall --unused --noninteractive 2>&1 | tee -a "$log_file"
    log "Flatpak updated and unused runtimes/apps removed."
}

# Function to update Arch system
function update_arch {
    log "Updating Arch system..."
    sudo pacman -Syu --noconfirm 2>&1 | tee -a "$log_file"

    # Check the exit status of pacman and handle errors
    if [ "${PIPESTATUS[0]}" != 0 ]; then
        log "Error: Package conflict encountered during system update. Exiting with error."
        exit 1
    fi
    log "Arch system updated."
}

# Function to update AUR packages with automation
function update_aur {
  if [ -d "$aur_package_dir" ]; then
    log "Updating AUR packages in $aur_package_dir..."
    # Set CMAKE_ARGS to include the compatibility flag
    export CMAKE_ARGS="-DCMAKE_POLICY_VERSION_MINIMUM=3.5"
    yay -Syu --noconfirm --cleanafter --answerclean=ask --answerdiff=None --builddir="$aur_package_dir" 2>&1 | tee -a "$log_file"

    # Check the exit status of yay
    if [ "${PIPESTATUS[0]}" != 0 ]; then
      log "Error: AUR update failed. Check the log for details."
      exit 1
    fi
    log "AUR packages updated."
  else
    log "AUR directory $aur_package_dir does not exist."
  fi
}

# Main script execution
log "=== Starting system updates ==="
update_arch
update_aur
update_flatpak
log "=== All updates completed ==="

# Option to display log file
read -p "Do you want to display the log file? (y/n): " choice
if [[ $choice =~ ^[Yy]$ ]]; then
    cat "$log_file"
fi
