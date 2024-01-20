#!/bin/bash

# Usage: update.sh [AUR_DIRECTORY]
# Default AUR directory if not provided
aur_package_dir="${1:-$HOME/aur_packages}"

# Log file for script output
log_file="/tmp/update.log"

# Log function
function log
{
    echo "[$(date +'%Y-%m-%d %H:%M:%S')] $1" | tee -a "$log_file"
}

# Check for required commands
for cmd in emacs flatpak pacman git makepkg; do
    if ! command -v $cmd &> /dev/null; then
        log "$cmd could not be found, please install $cmd"
        exit 1
    fi
done
# Function to get the installed version of a package
function get_installed_version
{
    pacman -Q "$1" 2>/dev/null | awk '{print $2}'
}

# Function to get the AUR version of a package
function get_aur_version
{
    grep -m1 'pkgver=' PKGBUILD | cut -d'=' -f2
}

# Function to update Emacs packages
function update_emacs
{
    log "Updating Emacs packages..."
    emacs --batch --eval "(package-refresh-contents)" 2>&1 | tee -a "$log_file"
    emacs --batch --eval "(package-upgrade-all)" 2>&1 | tee -a "$log_file"
    log "Emacs packages updated."
}

# Function to update Flatpak
function update_flatpak
{
    log "Updating Flatpak..."
    flatpak update 2>&1 | tee -a "$log_file"
    log "Removing unused Flatpak runtimes and apps..."
    flatpak uninstall --unused 2>&1 | tee -a "$log_file"
    log "Flatpak updated and unused runtimes/apps removed."
}

# Function to update Arch system
function update_arch
{
    log "Updating Arch system..."

    # Run the update command and redirect both stdout and stderr to the log file
    if ! sudo pacman -Syu 2>&1 | tee -a "$log_file"; then
        log "Error: Package conflict encountered during system update. Exiting with error."
        exit 1
    fi

    log "Arch system updated."
}

# Function to update AUR packages
function update_aur
{
    if [ -d "$aur_package_dir" ]; then
        log "Updating AUR packages in $aur_package_dir..."
        yay -Syu --aur --noconfirm 2>&1 | tee -a "$log_file"
        log "AUR packages updated."
    else
        log "AUR directory $aur_package_dir does not exist"
    fi
}

# Main script execution
log "=== Starting system updates ==="
update_arch
update_aur
update_emacs
update_flatpak
log "=== All updates completed ==="

# Option to display log file
read -p "Do you want to display the log file? (y/n): " choice
if [[ $choice =~ ^[Yy]$ ]]; then
    cat "$log_file"
fi
