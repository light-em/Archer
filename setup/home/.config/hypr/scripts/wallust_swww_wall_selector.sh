#!/bin/zsh

if [ $WALLPAPER_DIR = "" ] || [ ! -d $WALLPAPER_DIR ]; then
    notify-send "Error Finding Wallpaper Directory !!! \nSet Env Variable: \$WALLPAPER_DIR, and check if folder is present !!"
    exit 0
fi

selected_wall="$(ls $WALLPAPER_DIR | rofi -dmenu -p "Wallpaper")"
if [[ -z $selected_wall ]]; then
    exit 0
fi

swww img "$WALLPAPER_DIR/$selected_wall" -t wipe --transition-angle 30

sh "$HOME/.config/wallust/scripts/wallust-accent.sh" --run --new run "$WALLPAPER_DIR/$selected_wall"
rm $HOME/.config/hypr/hyprwall.img
ln $WALLPAPER_DIR/$selected_wall $HOME/.config/hypr/hyprwall.img
# notify-send "Wallpaper & Theme Changed !!!"
