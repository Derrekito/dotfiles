#!/bin/bash
#
#
#

fork()
{
    if [ $# -eq 0 ]; then
        echo "Error: No command provided." >&2
        return 1
    fi

    "$@" &

    local pid=$!

    # check return code first
    if [ $? -eq 0 ]; then
        if kill -0 "$pid" 2>/dev/null; then
            # return pid
            echo "$pid"
        else
            echo "Error: Failed to start command in background." >&2
            return 1
        fi
    else
        echo "Error: Fork failed... invalid return code" >&2
        return 1
    fi
}
