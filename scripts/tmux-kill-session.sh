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

    # Find any remaining session for the save command
    save_target=$(tmux list-sessions -F '#S' | head -n 1)

    if [[ -n "$save_target" ]]; then
        # Find an existing pane in the chosen session
        target_pane=$(tmux list-panes -t "$save_target" -F "#{pane_id}" | head -n 1)

        if [[ -n "$target_pane" ]]; then
            echo "saving session state to pane $target_pane"
            tmux send-keys -t "$target_pane" $PREFIX C-s
        else
            echo "No panes available in session $save_target to save."
        fi
    else
        echo "No sessions left to save."
    fi
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
read -p "Select an option: " user_option

case $user_option in
    1) kill_session_or_window_and_save ;;
    2) rename_session ;;
    *) echo "Invalid option. Exiting." ;;
esac
