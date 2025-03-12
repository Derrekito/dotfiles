#!/bin/bash

# Function to get the first session (for SSH case)
get_first_session() {
    tmux list-sessions -F "#{session_name}" 2>/dev/null | head -n1
}

# Function to get first unattached session (for host case)
get_first_unattached_session() {
    tmux list-sessions -F "#{session_name} #{session_attached}" 2>/dev/null |
        awk '$2 == "0" {print $1; exit}'  # Get first unattached session
}

# Check if this is an SSH session
if [ -n "$SSH_CONNECTION" ]; then
    # SSH case: attach to first existing session regardless of attachment status
    if ! tmux has-session 2>/dev/null; then
        # No tmux server running, start a new session
        tmux new-session -d -s default
        exec tmux attach-session -t default
    else
        session=$(get_first_session)
        if [ -z "$session" ]; then
            # No sessions exist (unlikely due to has-session check, but safe)
            tmux new-session -d -s default
            session="default"
        fi
        exec tmux attach-session -t "$session"
    fi
else
    # Host case: prefer unattached sessions or create new
    if ! tmux has-session 2>/dev/null; then
        # No tmux server running, start a new session
        tmux new-session -d -s default
        exec tmux attach-session -t default
    else
        # Get the first unattached session
        session=$(get_first_unattached_session)
        if [ -z "$session" ]; then
            # No unattached sessions exist, create a new unique one
            session_name="session_$(date +%s)_$RANDOM"
            tmux new-session -d -s "$session_name"
            session="$session_name"
        fi
        exec tmux attach-session -t "$session"
    fi
fi
