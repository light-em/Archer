#!/bin/bash

WALLUST_DIR=""
if [[ -z "$WALLUST_CONFIG_DIR" ]]; then
    WALLUST_DIR="$HOME/.config/wallust"
fi

name=$(cat $WALLUST_DIR/scripts/theme-options.info | rofi -dmenu -p 'Choose Theme' -format 's')
if [[ ! -z "$name" ]]; then
    sh $WALLUST_DIR/scripts/wallust-accent.sh --run --new theme $name
fi

