#!/bin/bash

mic_id="$(pactl list short modules | grep VirtualMic | awk '{print $1}')"
if [[ -z $mic_id ]]; then
    echo "VirtualMic Not Found"
else
    pactl unload-module $mic_id
    echo "--- Unloaded Virtual Mic ---"
fi
speaker_id="$(pactl list short modules | grep VirtualSpeaker | awk '{print $1}')"
if [[ -z $speaker_id ]]; then
    echo "VirtualSpeaker Not Found"
else
    pactl unload-module $speaker_id
    echo "--- Unloaded Virtual Speaker ---"
fi
echo "--- RESTART PIPEWIRE SERVICE ---"
systemctl --user restart pipewire pipewire-pulse wireplumber
    
if [ ! -e "$XDG_CONFIG_HOME/mpd/configs/default.conf" ]; then
    echo "ERROR: Can't find $XDG_CONFIG_HOME/mpd/configs/default.conf"
    exit 0
fi
echo "--- RESET MPD CONFIG ---"
rm $XDG_CONFIG_HOME/mpd/mpd.conf
cp $XDG_CONFIG_HOME/mpd/configs/default.conf $XDG_CONFIG_HOME/mpd/mpd.conf
echo "--- RESTART MPD SERVICE ---"
systemctl --user restart mpd


