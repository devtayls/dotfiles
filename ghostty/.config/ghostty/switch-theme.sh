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
        "nightfox") echo "Nightfox" ;;
        "dayfox") echo "Dayfox" ;;
        "dawnfox") echo "Dawnfox" ;;
        "duskfox") echo "Duskfox" ;;
        "nordfox") echo "Nordfox" ;;
        "terafox") echo "Terafox" ;;
        "carbonfox") echo "Carbonfox" ;;
        "evergarden"|"evergarden-spring") echo "Everforest Dark Hard" ;;  # Ghostty doesn't have evergarden
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
        "rose-pine-dawn") echo "Rose Pine Dawn" ;;
        "rose-pine-moon") echo "Rose Pine Moon" ;;
        "dracula") echo "Dracula" ;;
        "kanagawa") echo "Kanagawa Wave" ;;
        *) echo "$1" ;;  # Return as-is if no mapping found
    esac
}

# Function to list available mapped themes
list_themes() {
    echo "Available theme shortcuts:"
    echo "  everforest -> Everforest Dark Hard"
    echo "  nightfox -> Nightfox"
    echo "  dayfox -> Dayfox"
    echo "  dawnfox -> Dawnfox"
    echo "  duskfox -> Duskfox"
    echo "  nordfox -> Nordfox"
    echo "  terafox -> Terafox"
    echo "  carbonfox -> Carbonfox"
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
    echo "  rose-pine-dawn -> Rose Pine Dawn"
    echo "  rose-pine-moon -> Rose Pine Moon"
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

# Function to validate theme exists in Ghostty
validate_theme() {
    local theme_name="$1"
    local ghostty_bin="/Applications/Ghostty.app/Contents/MacOS/ghostty"

    # Check if Ghostty binary exists
    if [ ! -x "$ghostty_bin" ]; then
        # Can't validate, assume theme exists (graceful degradation)
        return 0
    fi

    # Get list of available themes and check if our theme exists
    if "$ghostty_bin" +list-themes 2>/dev/null | grep -qF "$theme_name"; then
        return 0
    else
        return 1
    fi
}

# Function to switch theme
switch_theme() {
    local theme_input="$1"
    local theme_name

    # Map the theme name
    theme_name=$(map_theme "$theme_input")

    # Validate theme exists in Ghostty
    if ! validate_theme "$theme_name"; then
        echo "Error: Theme '$theme_name' not found in Ghostty" >&2
        echo "Run: /Applications/Ghostty.app/Contents/MacOS/ghostty +list-themes" >&2
        return 1
    fi

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

    # Force Ghostty to reload config immediately
    if pgrep -q ghostty; then
        killall -USR2 ghostty 2>/dev/null
        echo "Switched to theme: $theme_name (config reloaded)"
    else
        echo "Switched to theme: $theme_name (will apply on next launch)"
    fi
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
