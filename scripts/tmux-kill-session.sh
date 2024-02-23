#!/bin/bash

# Your tmux prefix key
PREFIX='C-Space'

# Function to display tmux sessions and windows in a hierarchy
display_hierarchy() {
    echo "tmux Sessions and Windows:"
    tmux list-sessions -F '#S:' | while read session; do
        echo "  $session"
        tmux list-windows -t "$session" -F '    #I: #W' | while read window; do
            echo "    $window"
        done
    done
}

# Function to kill a session or window and then save the tmux state
kill_session_or_window_and_save() {
    read -p "Enter session/window to kill (session_name or session_name:window_index, 'exit' to cancel): " target

    if [[ "$target" == "exit" ]]; then
        echo "Operation cancelled."
        return
    fi

    if [[ $target == *:* ]]; then
        # It's a window
        session_name=${target%:*}
        window_index=${target#*:}
        tmux kill-window -t "${session_name}:${window_index}"
    else
        # It's a session
        tmux kill-session -t "$target"
    fi

    # Additional code to save state could go here
}

# Function to kill all sessions except the current one
kill_all_but_current_session() {
    current_session=$(tmux display-message -p '#S')
    tmux list-sessions -F '#S' | while read session_name; do
        if [[ "$session_name" != "$current_session" ]]; then
            tmux kill-session -t "$session_name"
        fi
    done
    echo "All sessions except the current one have been killed."
}

# Function to rename a session
rename_session() {
    echo "Available sessions:"
    tmux list-sessions -F "#S"

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

    tmux rename-session -t "$session_to_rename" "$new_name"
}

# Main script execution
display_hierarchy

echo "Options:"
echo "  1. Kill session/window"
echo "  2. Rename session"
echo "  3. Kill all but the current session"
read -p "Select an option: " user_option

case $user_option in
    1) kill_session_or_window_and_save ;;
    2) rename_session ;;
    3) kill_all_but_current_session ;;
    *) echo "Invalid option. Exiting." ;;
esac
