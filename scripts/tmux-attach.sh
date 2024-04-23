##!/bin/bash

# Attempt to attach to the first unoccupied session if it exists
unoccupied_session=$(tmux list-sessions -F "#{session_name}:#{session_attached}" | awk -F: '$2==0 {print $1; exit}')

if [ -n "$unoccupied_session" ]; then
    # If there is an unoccupied session, attach to it
    exec tmux attach-session -t "$unoccupied_session"
else
    # If no unoccupied session exists, create a new one
    exec tmux new-session
fi

sleep 1
