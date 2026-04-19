#!/bin/bash

# Tmux theme switcher script
# Usage: ./switch-theme.sh <theme_name>

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
THEMES_DIR="$SCRIPT_DIR/themes"
TMUX_CONF="$SCRIPT_DIR/tmux.conf"

# Get theme name from argument
THEME_NAME="$1"

# Function to list available themes
list_themes() {
    echo "Available tmux themes:"
    for theme in "$THEMES_DIR"/*.conf; do
        if [ -f "$theme" ]; then
            basename "$theme" .conf
        fi
    done
}

# Function to get current theme (reads shared state file with Neovim)
get_current_theme() {
    cat ~/.local/state/theme/current 2>/dev/null
}

# Function to switch theme
switch_theme() {
    local theme="$1"
    local theme_file="$THEMES_DIR/${theme}.conf"

    # Check if theme file exists
    if [ ! -f "$theme_file" ]; then
        echo "Error: Theme '$theme' not found"
        echo ""
        list_themes
        return 1
    fi

    # Persist the choice — tmux.conf's run-shell line reads this on startup
    mkdir -p ~/.local/state/theme
    echo "$theme" > ~/.local/state/theme/current

    # Apply to running tmux server (runtime only; tmux.conf never changes)
    if command -v tmux &>/dev/null && tmux info &>/dev/null 2>&1; then
        tmux source-file "$theme_file" >/dev/null 2>&1
        echo "Switched tmux theme to: $theme"
    else
        echo "Tmux not running; theme saved, will apply on next start"
    fi

    return 0
}

# Main logic
if [ -z "$THEME_NAME" ]; then
    current=$(get_current_theme)
    if [ -n "$current" ]; then
        echo "Current theme: $current"
    else
        echo "No theme currently set"
    fi
    echo ""
    list_themes
    echo ""
    echo "Usage: $0 <theme_name>"
elif [ "$THEME_NAME" = "list" ]; then
    list_themes
elif [ "$THEME_NAME" = "current" ]; then
    get_current_theme
else
    switch_theme "$THEME_NAME"
fi
