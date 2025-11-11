#!/bin/sh
# ON LOGIN: setup env vars

# -- Default Programs
export EDITOR="nvim"
export TERMINAL="kitty"
export TERM="kitty"
export BROWSER="zen-browser"
export DEV_BROWSER=$BROWSER
export EXPLORER="yazi"

# -- XDG Base Dirs
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

# -- bootstrap zsh config dir [ ~ -> ~/.config/zsh]
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

# -- history files
export LESSHISTFILE="$XDG_CACHE_HOME/less_history"
export PYTHON_HISTORY="$XDG_DATA_HOME/python/history"

# -- Apps Specific Config
export SCREENSHOT_DIR="$HOME/stored-data/screenshots"
export HYPRSHOT_DIR=$SCREENSHOT_DIR
export WALLPAPER_DIR="$HOME/ui-data/wallpapers"
export QT_SCALE_FACTOR=1.25

export PATH="$PATH:$HOME/.local/bin" # Adding pipx to path
export ELECTRON_OZONE_PLATFORM_HINT=auto
export MOZ_ENABLE_WAYLAND=1
export QT_QPA_PLATFORMTHEME=qt5ct


