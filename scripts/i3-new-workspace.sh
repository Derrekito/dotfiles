#!/bin/bash

#!/bin/bash

#!/bin/bash

#!/bin/bash

next_min_workspace() {
  # Extract workspace numbers and sort them
  workspace_numbers=$(i3-msg -t get_workspaces | grep -o '"num":[0-9]*' | cut -d: -f2 | sort -n)

  # Initialize next workspace number to 1
  next=1

  # Loop through each workspace number and find the next minimal workspace number
  for num in $workspace_numbers; do
    if [ "$num" -ne "$next" ]; then
      # Found a gap in the sequence
      break
    fi
    next=$((next + 1))
  done

  echo $next
}

# Switch to the next minimal workspace number
workspace_num=$(next_min_workspace)
i3-msg -q workspace number "$workspace_num"
