#!/bin/bash

# Your tmux prefix key
PREFIX='C-Space'

# Function to display tmux sessions and windows in a hierarchy
display_hierarchy() {
    echo "tmux Sessions and Windows:"
    if ! tmux list-sessions >/dev/null 2>&1; then
        echo "  No active tmux sessions found."
        return
    fi
    tmux list-sessions -F '#S:' | while read -r session; do
        echo "  $session"
        tmux list-windows -t "$session" -F '    #I: #W' | while read -r window; do
            echo "    $window"
        done
    done
}

# Function to save tmux state using continuum/resurrect
save_continuum_state() {
    echo "Saving tmux state..."
    if tmux run-shell "$HOME/.tmux/plugins/tmux-resurrect/scripts/save.sh" 2>/dev/null; then
        echo "State saved successfully."
    else
        echo "Warning: Failed to save state. Ensure tmux-resurrect is installed correctly."
    fi
}

# Function to kill all sessions except the current one
kill_all_but_current_session() {
    if [ -z "$TMUX" ]; then
        echo "Error: This script must be run from within a tmux session."
        return 1
    fi

    current_session=$(tmux display-message -p '#{session_id}')
    if [ -z "$current_session" ]; then
        echo "Error: Could not determine current session."
        return 1
    fi

    echo "Current session ID: $current_session"
    local session_count=$(tmux list-sessions | wc -l)

    if [ "$session_count" -gt 1 ]; then
        save_continuum_state
        local killed_count=0
        tmux list-sessions -F '#{session_id} #{session_name}' | while read -r session_id session_name; do
            if [ "$session_id" != "$current_session" ]; then
                if tmux kill-session -t "$session_name" 2>/dev/null; then
                    ((killed_count++))
                    echo "Killed session: $session_name (ID: $session_id)"
                fi
            fi
        done
        echo "Killed $killed_count session(s). Current session preserved."
    else
        echo "Only one session found. Would you like to kill all windows except the current one?"
        read -p "Enter 'yes' to proceed, anything else to cancel: " response
        if [ "$response" = "yes" ]; then
            save_continuum_state
            current_window=$(tmux display-message -p '#{window_id}')
            local killed_count=0
            tmux list-windows -F '#{window_id} #{window_name}' | while read -r window_id window_name; do
                if [ "$window_id" != "$current_window" ]; then
                    if tmux kill-window -t "$window_id" 2>/dev/null; then
                        ((killed_count++))
                        echo "Killed window: $window_name (ID: $window_id)"
                    fi
                fi
            done
            echo "Killed $killed_count window(s). Current window preserved."
        else
            echo "Operation cancelled."
        fi
    fi
}

# Function to kill a session or window
kill_session_or_window() {
    read -p "Enter session/window to kill (session_name or session_name:window_index, 'exit' to cancel): " target
    if [[ "$target" == "exit" || -z "$target" ]]; then
        echo "Operation cancelled."
        return
    fi
    save_continuum_state
    if [[ $target == *:* ]]; then
        session_name=${target%:*}
        window_index=${target#*:}
        if tmux kill-window -t "${session_name}:${window_index}" 2>/dev/null; then
            echo "Window ${session_name}:${window_index} killed successfully."
        else
            echo "Failed to kill window ${session_name}:${window_index}."
        fi
    else
        if tmux kill-session -t "$target" 2>/dev/null; then
            echo "Session $target killed successfully."
        else
            echo "Failed to kill session $target."
        fi
    fi
}

# Function to rename a session
rename_session() {
    echo "Available sessions:"
    tmux list-sessions -F "#S" 2>/dev/null || echo "No sessions found."
    read -p "Enter the session name to rename: " session_to_rename
    if [[ -z "$session_to_rename" ]]; then
        echo "Operation cancelled."
        return
    fi
    if ! tmux has-session -t "$session_to_rename" 2>/dev/null; then
        echo "Session not found: $session_to_rename"
        return
    fi
    read -p "Enter new name for session '$session_to_rename': " new_name
    if [[ -z "$new_name" ]]; then
        echo "Operation cancelled."
        return
    fi
    if tmux rename-session -t "$session_to_rename" "$new_name" 2>/dev/null; then
        echo "Session renamed to '$new_name' successfully."
    else
        echo "Failed to rename session."
    fi
}

# Main script execution
echo "Current date: $(date)"
display_hierarchy
echo

echo "Options:"
echo "  1. Kill session/window"
echo "  2. Rename session"
echo "  3. Kill all but the current session/window"
echo "  4. Exit"
read -p "Select an option: " user_option

case $user_option in
    1) kill_session_or_window ;;
    2) rename_session ;;
    3) kill_all_but_current_session ;;
    4) echo "Exiting."; exit 0 ;;
    *) echo "Invalid option. Exiting."; exit 1 ;;
esac
