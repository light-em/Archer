#!/bin/zsh

WAYDIR=""
if [[ -z $WAYBAR_DIR ]] || [[ ! -d $WAYBAR_DIR ]]; then
    WAYDIR="$HOME/.config/waybar"
 else
    WAYDIR=$WAYBAR_DIR
fi

cd $WAYDIR/configs
option_dir="$(ls | rofi -dmenu -p "WAYBAR CONFIG")"
if [[ -z $option_dir ]]; then
    exit 0;
fi
cd -

mv $WAYDIR/base.jsonc "/tmp/waybar-base-$(date +%mm-%dd-%HH-%MM-%SS).jsonc"
mv $WAYDIR/style.css "/tmp/waybar-style-$(date +%mm-%dd-%HH-%MM-%SS).css"

cp "$WAYDIR/configs/${option_dir}/base.jsonc" "$WAYDIR/base.jsonc"
cp "$WAYDIR/configs/${option_dir}/style.css" "$WAYDIR/style.css"

sh $WAYDIR/scripts/update-waybar.sh
killall waybar
waybar & disown
exit 0
