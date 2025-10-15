#!/bin/bash

set -e

# Define variables
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="$HOME/.config/Pink-Astolfo-Rice"

# --- Backup existing dotfiles ---
echo ""
echo "-----------------------------------------------------"
echo "WARNING: This script will create symbolic links for your dotfiles."
echo "         It's highly recommended to back up your existing configurations first."
echo "         You can do this manually or let the script attempt a basic backup."
echo "-----------------------------------------------------"
echo ""

read -p "Do you want to backup your existing ~/.config files? (y/N): " backup_choice
if [[ "$backup_choice" =~ ^[Yy]$ ]]; then
    echo "Backing up existing ~/.config files to ~/.config_backup_$(date +%Y%m%d_%H%M%S)"
    mkdir -p "$HOME/.config_backup_$(date +%Y%m%d_%H%M%S)"
    cp -r "$HOME/.config/hypr" "$HOME/.config_backup_$(date +%Y%m%d_%H%M%S)/" 2>/dev/null || true
    cp -r "$HOME/.config/waybar" "$HOME/.config_backup_$(date +%Y%m%d_%H%M%S)/" 2>/dev/null || true
    cp -r "$HOME/.config/rofi" "$HOME/.config_backup_$(date +%Y%m%d_%H%M%S)/" 2>/dev/null || true
    cp -r "$HOME/.config/kitty" "$HOME/.config_backup_$(date +%Y%m%d_%H%M%S)/" 2>/dev/null || true
    cp -r "$HOME/.config/mako" "$HOME/.config_backup_$(date +%Y%m%d_%H%M%S)/" 2>/dev/null || true
    cp -r "$HOME/.config/fastfetch" "$HOME/.config_backup_$(date +%Y%m%d_%H%M%S)/" 2>/dev/null || true

    cp -r "$HOME/.config/walker" "$HOME/.config_backup_$(date +%Y%m%d_%H%M%S)/" 2>/dev/null || true
    cp "$HOME/.bashrc" "$HOME/.bashrc_backup_$(date +%Y%m%d_%H%M%S)" 2>/dev/null || true
    echo "Backup complete."
else
    echo "Skipping backup."
fi

# --- Create target directory for dotfiles ---
echo "Creating target directory: $CONFIG_DIR"
mkdir -p "$CONFIG_DIR"

# --- Copy images ---
echo "Copying images to $CONFIG_DIR/images"
cp -r "$DOTFILES_DIR/images" "$CONFIG_DIR/"

# --- Create symbolic links ---
echo "Creating symbolic links for configuration files..."

# Hyprland
ln -sf "$DOTFILES_DIR/hypr" "$HOME/.config/hypr"

# Waybar
ln -sf "$DOTFILES_DIR/waybar" "$HOME/.config/waybar"

# Rofi
ln -sf "$DOTFILES_DIR/rofi" "$HOME/.config/rofi"

# Kitty
ln -sf "$DOTFILES_DIR/kitty" "$HOME/.config/kitty"

# Mako
ln -sf "$DOTFILES_DIR/mako" "$HOME/.config/mako"

# Fastfetch
ln -sf "$DOTFILES_DIR/fastfetch" "$HOME/.config/fastfetch"

# Hypr-lain


# Walker
ln -sf "$DOTFILES_DIR/walker" "$HOME/.config/walker"

# .bashrc
echo ""
echo "-----------------------------------------------------"
echo "IMPORTANT: Your .bashrc file needs to be handled manually."
echo "         You can either:"
echo "         1. Copy it: cp \"$DOTFILES_DIR/.bashrc\" \"$HOME/.bashrc\""
echo "         2. Source it: echo \"source $DOTFILES_DIR/.bashrc\" >> \"$HOME/.bashrc\""
echo "         Please review the content of the provided .bashrc before applying it."
echo "-----------------------------------------------------"
echo ""

# --- Dependency installation (placeholder) ---
echo ""
echo "-----------------------------------------------------"
echo "NOTE: This script does NOT install dependencies."
echo "      You will need to manually install the following packages:"
echo "      - Hyprland, Waybar, Rofi, Kitty, Mako, Fastfetch, Hyprpaper, Playerctl, Brightnessctl, Wpctl"
echo "      For Arch Linux, you might use pacman:"
echo "      sudo pacman -S hyprland waybar rofi kitty mako fastfetch hyprpaper playerctl brightnessctl pipewire-alsa"
echo "      For Fedora, you might use dnf:"
echo "      sudo dnf install hyprland waybar rofi kitty mako fastfetch hyprpaper playerctl brightnessctl pipewire-utils"
echo "-----------------------------------------------------"
echo ""

# --- Post-installation instructions ---
echo ""
echo "-----------------------------------------------------"
echo "Installation complete!"
echo "Please log out and log back in, or reboot your system for changes to take effect."
echo "You may also need to manually set up hyprpaper to run on startup (e.g., in hyprland.conf)."
echo "-----------------------------------------------------"
echo ""

chmod +x "$DOTFILES_DIR/install.sh"
