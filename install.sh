#!/bin/bash

set -e

# Define variables
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="$HOME/.config/Pink-Astolfo-Rice"

# --- Hyprland Detection ---
if [ -n "$HYPRLAND_INSTANCE_SIGNATURE" ]; then
    echo ""
    echo "-----------------------------------------------------"
    echo "NOTE: It appears you are already running Hyprland."
    echo "      This script will proceed with dotfile installation and dependency checks."
    echo "-----------------------------------------------------"
    echo ""
    sleep 2 # Give user time to read the message
fi

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

# --- Developer Tools, Build Tools, and Libraries ---
echo ""
echo "-----------------------------------------------------"
echo "NOTE: This script can also install common developer tools, build tools, and libraries."
echo "      This is optional and can be skipped if not needed."
echo "-----------------------------------------------------"
echo ""

read -p "Do you want to install developer tools, build tools, GTK libraries, and Nerd Fonts? (y/N): " dev_tools_choice
if [[ "$dev_tools_choice" =~ ^[Yy]$ ]]; then
    echo "Attempting to install developer tools and libraries..."
    if command -v pacman &> /dev/null; then
        echo "Detected Arch Linux (or Arch-based distro like CachyOS)."
        sudo pacman -S --noconfirm base-devel neovim python-pip cmake ninja meson pkg-config \
            gtk3 gtk4 libadwaita \
            ttf-jetbrains-mono-nerd catppuccin-gtk-theme-mocha papirus-icon-theme
        echo ""
        echo "NOTE for Arch Linux:"
        echo "  - pyenv: Install via AUR (e.g., yay -S pyenv) or official instructions."
        echo "  - spicetify-cli: Install via AUR (e.g., yay -S spicetify-cli) or official instructions."
        echo "  - ollama: Install via official instructions (curl -fsSL https://ollama.com/install.sh | sh)."
    elif command -v dnf &> /dev/null; then
        echo "Detected Fedora."
        sudo dnf install -y @development-tools neovim python3-pip cmake ninja-build meson pkg-config \
            gtk3-devel gtk4-devel libadwaita-devel \
            jetbrains-mono-fonts-all papirus-icon-theme
        echo ""
        echo "NOTE for Fedora:"
        echo "  - catppuccin-gtk-theme: May require manual installation or a COPR repository."
        echo "  - pyenv: Install via official instructions (e.g., curl https://pyenv.run | bash)."
        echo "  - spicetify-cli: Install via official instructions (e.g., curl -fsSL https://raw.githubusercontent.com/spicetify/spicetify-cli/master/install.sh | sh)."
        echo "  - ollama: Install via official instructions (curl -fsSL https://ollama.com/install.sh | sh)."
    elif command -v zypper &> /dev/null; then
        echo "Detected openSUSE."
        sudo zypper install -y @patterns-devel_basis neovim python3-pip cmake ninja meson pkg-config \
            libgtk-3-0 libgtk-4-0 libadwaita-1 \
            jetbrains-mono-fonts papirus-icon-theme
        echo ""
        echo "NOTE for openSUSE:"
        echo "  - catppuccin-gtk-theme: May require manual installation or a community repository."
        echo "  - pyenv: Install via official instructions (e.g., curl https://pyenv.run | bash)."
        echo "  - spicetify-cli: Install via official instructions."
        echo "  - ollama: Install via official instructions (curl -fsSL https://ollama.com/install.sh | sh)."
    else
        echo "Could not detect a supported package manager (pacman, dnf, or zypper)."
        echo "Please install developer tools, build tools, GTK libraries, and Nerd Fonts manually."
    fi
else
    echo "Skipping installation of developer tools and libraries."
fi

# --- Core Dependency Installation ---
echo ""
echo "-----------------------------------------------------"
echo "NOTE: This script will attempt to install core dependencies."
echo "      You will be prompted for sudo password if necessary."
echo "-----------------------------------------------------"
echo ""

read -p "Do you want to install core dependencies (Hyprland, Waybar, Rofi, Kitty, etc.)? (y/N): " core_deps_choice
if [[ "$core_deps_choice" =~ ^[Yy]$ ]]; then
    echo "Attempting to install core dependencies..."
    if command -v pacman &> /dev/null; then
        echo "Detected Arch Linux (or Arch-based distro like CachyOS)."
        sudo pacman -S hyprland hyprpaper hypridle hyprlock waybar rofi mako grim slurp jq fastfetch kitty brightnessctl wl-clipboard playerctl pipewire wireplumber pulseaudio-utils pavucontrol mpv yt-dlp ffmpeg
    elif command -v dnf &> /dev/null; then
        echo "Detected Fedora."
        sudo dnf install hyprland hyprpaper hypridle hyprlock waybar rofi mako grim slurp jq fastfetch kitty brightnessctl wl-clipboard playerctl pipewire-utils wireplumber pulseaudio-utils pavucontrol mpv yt-dlp ffmpeg
    elif command -v zypper &> /dev/null; then
        echo "Detected openSUSE."
        sudo zypper install hyprland hyprpaper hypridle hyprlock waybar rofi mako grim slurp jq fastfetch kitty brightnessctl wl-clipboard playerctl pipewire wireplumber pulseaudio-utils pavucontrol mpv yt-dlp ffmpeg
    else
        echo "Could not detect a supported package manager (pacman, dnf, or zypper)."
echo "For the most up-to-date and detailed installation instructions for Hyprland and its dependencies,"
echo "always refer to the official Hyprland Wiki: https://wiki.hypr.land/Hyprland-wiki/Getting-Started/"
echo "Please install core dependencies manually."
    fi
else
    echo "Skipping installation of core dependencies."
fi

echo ""
echo "-----------------------------------------------------"
echo "For Debian/Ubuntu (and other stable distros):"
echo "Hyprland is bleeding-edge and often requires building from source on stable distributions."
echo "Refer to the official Hyprland Wiki for detailed instructions on building from source or using testing/unstable repositories."
echo "-----------------------------------------------------"
echo ""

# --- Post-installation instructions ---
echo ""
echo "-----------------------------------------------------"
echo "Installation complete!"
echo ""
echo "IMPORTANT: If you are installing Hyprland alongside an existing Desktop Environment (like GNOME or KDE),"
echo "           be aware that Hyprland will be available as a separate session at your login manager."
echo "           Some services or configurations from your existing DE might conflict or behave unexpectedly."
echo "           For a cleaner experience, consider installing on a fresh system or a separate user account."
echo ""
echo "Please log out and log back in, or reboot your system for changes to take effect."
echo "You may also need to manually set up hyprpaper to run on startup (e.g., in hyprland.conf)."
echo "-----------------------------------------------------"
echo ""

chmod +x "$DOTFILES_DIR/install.sh"
