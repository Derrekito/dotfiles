#!/bin/bash

# Function to get the first session
get_first_session() {
    tmux list-sessions -F "#{session_name}" 2>/dev/null | head -n1
}

# Check if tmux server is running
if ! tmux has-session 2>/dev/null; then
    # No tmux server running, start a new session
    tmux new-session -d -s default
    exec tmux attach-session -t default
else
    # Get the first session (or use 'default' if none exists)
    session=$(get_first_session)
    session=${session:-default}

    # Create a new window in the session and attach to it
    exec tmux new-session -t "$session" \; new-window
fi
