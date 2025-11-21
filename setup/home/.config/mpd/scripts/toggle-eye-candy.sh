#!/bin/bash

if [[ "$(hyprctl getoption animations:enabled | grep 'int:' | awk '{print $2}')" -eq "1" ]]; then
    hyprctl keyword animations:enabled no
    hyprctl keyword decoration:blur:enabled false
    notify-send "Eye-Candy Disabled !!"
else
    hyprctl keyword animations:enabled yes
    hyprctl keyword decoration:blur:enabled true
    notify-send "Eye-Candy Enabled !!"
fi
