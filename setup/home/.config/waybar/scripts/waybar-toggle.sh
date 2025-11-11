#!/bin/bash

PID=$(pidof waybar)
if [ -z "$PID" ]; then
    # notify-send "Waybar -> Launched"
    waybar & disown
else
    # notify-send "Waybar -> Killed"
    killall waybar
fi
exit 0
