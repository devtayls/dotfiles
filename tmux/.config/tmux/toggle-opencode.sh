#!/bin/bash

# Check if opencode pane exists in the current window
pane_id=$(tmux list-panes -F "#{pane_id} #{pane_current_command}" | grep "opencode" | head -1 | cut -d' ' -f1)

if [ -n "$pane_id" ]; then
    # Pane exists in current window - break it off into background session
    tmux break-pane -d -s "$pane_id" -n "opencode-bg"
else
    # Check if background opencode session exists
    if tmux has-session -t "opencode-bg" 2>/dev/null; then
        # Join the background pane back into current window
        tmux join-pane -h -l 50% -s "opencode-bg"
    else
        # Create new session in background and join it
        tmux new-session -d -s "opencode-bg" opencode
        tmux join-pane -h -l 50% -s "opencode-bg"
    fi
fi
