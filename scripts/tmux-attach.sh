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
    # Get the first session
    session=$(get_first_session)
    if [ -z "$session" ]; then
        # No sessions exist (unlikely due to has-session check, but safe)
        tmux new-session -d -s default
        session="default"
    fi
    # Attach to the existing session
    exec tmux attach-session -t "$session"
fi
