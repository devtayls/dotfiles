#!/bin/bash

# Dynamic script to switch Ghostty themes
# Usage: ./switch-theme.sh <theme_name>
# Example: ./switch-theme.sh "Everforest Dark Hard"

SCRIPT_DIR="$(dirname "$0")"
CONFIG_FILE="$SCRIPT_DIR/config"

# Function to map Neovim-friendly names to Ghostty theme names
map_theme() {
    case "$1" in
        "everforest") echo "Everforest Dark Hard" ;;
        "dayfox") echo "Dayfox" ;;
        "nightfox") echo "Nightfox" ;;
        "material") echo "Material" ;;
        "catppuccin-mocha") echo "Catppuccin Mocha" ;;
        "catppuccin-macchiato") echo "Catppuccin Macchiato" ;;
        "catppuccin-frappe") echo "Catppuccin Frappe" ;;
        "catppuccin-latte") echo "Catppuccin Latte" ;;
        "tokyonight") echo "TokyoNight" ;;
        "tokyonight-storm") echo "TokyoNight Storm" ;;
        "tokyonight-day") echo "TokyoNight Day" ;;
        "gruvbox-dark") echo "Gruvbox Dark" ;;
        "gruvbox-light") echo "Gruvbox Light" ;;
        "nord") echo "Nord" ;;
        "rose-pine") echo "Rose Pine" ;;
        "dracula") echo "Dracula" ;;
        "kanagawa") echo "Kanagawa Wave" ;;
        *) echo "$1" ;;  # Return as-is if no mapping found
    esac
}

# Function to list available mapped themes
list_themes() {
    echo "Available theme shortcuts:"
    echo "  everforest -> Everforest Dark Hard"
    echo "  dayfox -> Dayfox"
    echo "  nightfox -> Nightfox"
    echo "  material -> Material"
    echo "  catppuccin-mocha -> Catppuccin Mocha"
    echo "  catppuccin-macchiato -> Catppuccin Macchiato"
    echo "  catppuccin-frappe -> Catppuccin Frappe"
    echo "  catppuccin-latte -> Catppuccin Latte"
    echo "  tokyonight -> TokyoNight"
    echo "  tokyonight-storm -> TokyoNight Storm"
    echo "  tokyonight-day -> TokyoNight Day"
    echo "  gruvbox-dark -> Gruvbox Dark"
    echo "  gruvbox-light -> Gruvbox Light"
    echo "  nord -> Nord"
    echo "  rose-pine -> Rose Pine"
    echo "  dracula -> Dracula"
    echo "  kanagawa -> Kanagawa Wave"
    echo ""
    echo "You can also use any Ghostty theme name directly."
    echo "Run: /Applications/Ghostty.app/Contents/MacOS/ghostty +list-themes"
}

# Function to get current theme
get_current_theme() {
    grep "^theme = " "$CONFIG_FILE" | sed 's/^theme = //'
}

# Function to switch theme
switch_theme() {
    local theme_input="$1"
    local theme_name

    # Map the theme name
    theme_name=$(map_theme "$theme_input")

    # Update config file
    if grep -q "^theme = " "$CONFIG_FILE"; then
        # Theme line exists, replace it
        sed -i.bak "s/^theme = .*/theme = $theme_name/" "$CONFIG_FILE" && rm -f "$CONFIG_FILE.bak"
    else
        # Theme line doesn't exist, add it after the first comment block
        sed -i.bak "/^# Theme/a\\
theme = $theme_name
" "$CONFIG_FILE" && rm -f "$CONFIG_FILE.bak"
    fi

    # Reload Ghostty config
    # Note: Ghostty automatically reloads config changes, but we can force it
    # by sending a signal or using the CLI if needed

    echo "Switched to theme: $theme_name"
    echo "Ghostty will automatically reload the configuration."
    return 0
}

# Main logic
THEME_NAME="$1"

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
