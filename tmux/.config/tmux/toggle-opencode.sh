#!/bin/bash

# Check if opencode pane exists by looking for the process
pane_id=$(tmux list-panes -a -F "#{pane_id} #{pane_current_command}" | grep "opencode" | head -1 | cut -d' ' -f1)

if [ -n "$pane_id" ]; then
    # Pane exists, kill it
    tmux kill-pane -t "$pane_id"
else
    # Create new pane with opencode
    tmux split-window -h -l 50% opencode
fi
