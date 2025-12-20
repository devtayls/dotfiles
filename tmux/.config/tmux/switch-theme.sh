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

# Function to get current theme
get_current_theme() {
    grep "^source.*themes/.*\.conf" "$TMUX_CONF" | sed 's|.*themes/\(.*\)\.conf.*|\1|'
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

    # Remove existing theme source line if it exists
    sed -i.bak '/^source.*themes\/.*\.conf/d' "$TMUX_CONF"

    # Add new theme source at the end
    echo "source $theme_file" >> "$TMUX_CONF"

    # Reload tmux configuration for all sessions
    if command -v tmux &>/dev/null && tmux info &>/dev/null 2>&1; then
        tmux source-file "$TMUX_CONF" >/dev/null 2>&1
        echo "Switched tmux theme to: $theme"
    else
        echo "Tmux theme updated to: $theme (will apply on next tmux start)"
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
