#!/bin/bash

mic_id="$(pactl list short modules | grep VirtualMic | awk '{print $1}')"
speaker_id="$(pactl list short modules | grep VirtualSpeaker | awk '{print $1}')"

if [[ (-z $mic_id) || (-z $speaker_id) ]]; then
    echo "=> SETUP VIRTUAL AUDIO LINK"

    pactl load-module module-null-sink sink_name="VirtualSpeaker" sink_properties=device.description=VirtualSpeaker
    pactl load-module module-null-sink media.class=Audio/Source/Virtual sink_name="VirtualMic" channel_map=front-left,front-right
    pw-link VirtualSpeaker:monitor_FL VirtualMic:input_FL
    pw-link VirtualSpeaker:monitor_FR VirtualMic:input_FR
    
if [ ! -e "$XDG_CONFIG_HOME/mpd/configs/virtual-cable.conf" ]; then
    echo "ERROR: Can't find $XDG_CONFIG_HOME/mpd/configs/virtual-cable.conf"
    exit 0
fi
echo "--- RESET MPD CONFIG ---"
rm $XDG_CONFIG_HOME/mpd/mpd.conf
cp $XDG_CONFIG_HOME/mpd/configs/virtual-cable.conf $XDG_CONFIG_HOME/mpd/mpd.conf
echo "--- RESTART MPD SERVICE ---"
systemctl --user restart mpd


else
    echo "=> RESET VIRTUAL AUDIO LINK"
    if [[ -z $mic_id ]]; then
        echo "VirtualMic Not Found"
    else
        pactl unload-module $mic_id
        echo "--- Unloaded Virtual Mic ---"
    fi
    if [[ -z $speaker_id ]]; then
        echo "VirtualSpeaker Not Found"
    else
        pactl unload-module $speaker_id
        echo "--- Unloaded Virtual Speaker ---"
    fi
    
if [ ! -e "$XDG_CONFIG_HOME/mpd/configs/default.conf" ]; then
    echo "ERROR: Can't find $XDG_CONFIG_HOME/mpd/configs/default.conf"
    exit 0
fi
echo "--- RESET MPD CONFIG ---"
rm $XDG_CONFIG_HOME/mpd/mpd.conf
cp $XDG_CONFIG_HOME/mpd/configs/default.conf $XDG_CONFIG_HOME/mpd/mpd.conf
echo "--- RESTART MPD SERVICE ---"
systemctl --user restart mpd

fi
