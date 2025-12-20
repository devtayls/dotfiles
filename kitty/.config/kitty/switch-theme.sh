#!/bin/bash

# Dynamic script to switch Kitty themes
# Usage: ./switch-theme.sh <theme_name>
# Example: ./switch-theme.sh everforest

SCRIPT_DIR="$(dirname "$0")"
KITTY_CONFIG="$SCRIPT_DIR/kitty.conf"
THEMES_DIR="$SCRIPT_DIR/themes"

# Get the theme name from argument
THEME_NAME="$1"

# Function to list available themes
list_themes() {
    echo "Available themes:"
    for theme in "$THEMES_DIR"/*.conf; do
        if [ -f "$theme" ]; then
            basename "$theme" .conf
        fi
    done
}

# Function to get current theme
get_current_theme() {
    grep "include ./themes/" "$KITTY_CONFIG" | sed 's|.*include ./themes/\(.*\)\.conf|\1|'
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

    # Update kitty.conf to use the new theme (for persistence)
    sed "s|include ./themes/.*\.conf|include ./themes/${theme}.conf|" "$KITTY_CONFIG" > "$KITTY_CONFIG.tmp" && mv "$KITTY_CONFIG.tmp" "$KITTY_CONFIG"

    # Reload kitty configuration to apply the theme
    kill -SIGUSR1 $(pgrep kitty) 2>/dev/null

    echo "Switched to theme: $theme"
    return 0
}

# Main logic
if [ -z "$THEME_NAME" ]; then
    echo "Current theme: $(get_current_theme)"
    echo ""
    list_themes
    echo ""
    echo "Usage: $0 <theme_name>"
elif [ "$THEME_NAME" = "list" ]; then
    list_themes
elif [ "$THEME_NAME" = "current" ]; then
    echo "$(get_current_theme)"
else
    switch_theme "$THEME_NAME"
fi