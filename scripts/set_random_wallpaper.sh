#!/bin/bash
# =============================================================================
# set_random_wallpaper.sh
# =============================================================================
#
# Description:
#   This script selects a random wallpaper based on the current screen's aspect
#   ratio. It retrieves the current resolution using xrandr, calculates the
#   aspect ratio, and then compares it to a set of predefined aspect ratios.
#   Depending on which ratio is closest (within a ±0.05 tolerance), the script
#   chooses the appropriate wallpaper directory from:
#       $HOME/wallpaper/16:9
#       $HOME/wallpaper/21:9
#       $HOME/wallpaper/43:18
#
# Usage:
#   ./set_random_wallpaper.sh
#
# Dependencies:
#   - xrandr: for obtaining the current screen resolution.
#   - bc: for performing floating-point arithmetic.
#   - feh: for setting the wallpaper.
#
# Author: Your Name
# Date: 2025-03-18
# Version: 1.0
# =============================================================================

WALLPAPER_PATH="$HOME/wallpaper"

# -----------------------------------------------------------------------------
# Function: get_current_ar
# -----------------------------------------------------------------------------
# Retrieves the current screen resolution using xrandr, parses the width and
# height, and calculates the aspect ratio using bc.
#
# Returns:
#   The calculated aspect ratio (formatted with two decimal places).
# -----------------------------------------------------------------------------
function get_current_ar() {
    # Extract the current resolution.
    # - grep "\*" searches for the line containing '*' (current mode indicator).
    # - head -n1 ensures only the first match is used.
    # - awk '{print $1}' extracts the resolution string (e.g., "1920x1080").
    RESOLUTION=$(xrandr --current | grep "\*" | head -n1 | awk '{print $1}')
    echo "Debug: Raw resolution = '$RESOLUTION'" >&2

    # Validate that a resolution was found.
    if [ -z "$RESOLUTION" ]; then
        echo "Error: Could not determine screen resolution" >&2
        exit 1
    fi

    # Parse the width and height from the resolution string.
    WIDTH=$(echo "$RESOLUTION" | cut -d 'x' -f1)
    HEIGHT=$(echo "$RESOLUTION" | cut -d 'x' -f2)
    echo "Debug: Parsed WIDTH = '$WIDTH', HEIGHT = '$HEIGHT'" >&2

    if [ -z "$WIDTH" ] || [ -z "$HEIGHT" ]; then
        echo "Error: Invalid resolution format (Width: $WIDTH, Height: $HEIGHT)" >&2
        exit 1
    fi

    # Calculate the aspect ratio with two decimal places.
    INPUT="scale=2; $WIDTH / $HEIGHT"
    echo "Debug: bc input: '$INPUT'" >&2
    ASPECT=$(echo "$INPUT" | bc 2>/dev/null)
    if [ -z "$ASPECT" ]; then
        echo "Error: Failed to calculate aspect ratio" >&2
        exit 1
    fi

    echo "Debug: Calculated ASPECT = '$ASPECT'" >&2
    printf "Debug: ASPECT hexdump = " >&2
    printf "%s" "$ASPECT" | xxd >&2
    echo "" >&2

    # Output the aspect ratio.
    printf "%s\n" "$ASPECT"
}

# -----------------------------------------------------------------------------
# Function: check_ar
# -----------------------------------------------------------------------------
# Compares the current aspect ratio to a target aspect ratio with a tolerance
# of ±0.05 using bc for floating-point arithmetic.
#
# Parameters:
#   AR - The target aspect ratio to compare against.
#
# Returns:
#   1 if the current aspect ratio is within the tolerance of the target, 0 otherwise.
# -----------------------------------------------------------------------------
function check_ar() {
    local AR=$1
    if [ -z "$ASPECT_RATIO" ] || [ -z "$AR" ]; then
        echo "Error: Aspect ratio or target AR is empty" >&2
        return 1
    fi
    echo "Debug: Comparing ASPECT_RATIO = '$ASPECT_RATIO' vs target AR = '$AR'" >&2

    # Build the comparison expression for bc.
    CMP_INPUT="($ASPECT_RATIO >= ($AR - 0.05)) && ($ASPECT_RATIO <= ($AR + 0.05))"
    echo "Debug: bc comparison input: '$CMP_INPUT'" >&2
    RESULT=$(echo "$CMP_INPUT" | bc -l)
    echo "Debug: bc comparison result: '$RESULT'" >&2
    echo "$RESULT"
}

# -----------------------------------------------------------------------------
# Main Script Execution
# -----------------------------------------------------------------------------

# 1. Calculate the current screen's aspect ratio.
ASPECT_RATIO=$(get_current_ar)
if [ -z "$ASPECT_RATIO" ]; then
    echo "Error: Aspect ratio calculation failed" >&2
    exit 1
fi
echo "Calculated aspect ratio: $ASPECT_RATIO"

# 2. Define predefined aspect ratios.
ASPECT_RATIO_16_9=$(echo "scale=2; 16/9" | bc)
ASPECT_RATIO_21_9=$(echo "scale=2; 21/9" | bc)
ASPECT_RATIO_43_18=$(echo "scale=2; 43/18" | bc)

echo "Debug: Predefined ARs - 16:9: '$ASPECT_RATIO_16_9', 21:9: '$ASPECT_RATIO_21_9', 43:18: '$ASPECT_RATIO_43_18'" >&2

# 3. Choose the wallpaper directory based on the aspect ratio.
if [ "$(check_ar "$ASPECT_RATIO_16_9")" = "1" ]; then
    WALLPAPER_DIR="$WALLPAPER_PATH/16:9"
elif [ "$(check_ar "$ASPECT_RATIO_21_9")" = "1" ]; then
    WALLPAPER_DIR="$WALLPAPER_PATH/21:9"
else
    WALLPAPER_DIR="$WALLPAPER_PATH/43:18"
fi
echo "Selected wallpaper directory: $WALLPAPER_DIR"

# 4. Verify the wallpaper directory exists.
if [ ! -d "$WALLPAPER_DIR" ]; then
    echo "Error: Directory $WALLPAPER_DIR does not exist" >&2
    exit 1
fi

# 5. Randomly select a wallpaper from the directory.
RANDOM_WALLPAPER=$(find "$WALLPAPER_DIR" -type f | shuf -n 1)
if [ -z "$RANDOM_WALLPAPER" ]; then
    echo "Error: No wallpapers found in $WALLPAPER_DIR" >&2
    exit 1
fi

# 6. Set the selected wallpaper using feh.
feh --bg-scale "$RANDOM_WALLPAPER"

