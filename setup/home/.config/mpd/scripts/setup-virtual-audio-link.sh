pactl load-module module-null-sink sink_name="VirtualSpeaker" sink_properties=device.description=VirtualSpeaker
pactl load-module module-null-sink media.class=Audio/Source/Virtual sink_name="VirtualMic" channel_map=front-left,front-right
pw-link VirtualSpeaker:monitor_FL VirtualMic:input_FL
pw-link VirtualSpeaker:monitor_FR VirtualMic:input_FR
echo "## NOTE: Restarting will reset the link"


if [ ! -e "$XDG_CONFIG_HOME/mpd/configs/virtual-cable.conf" ]; then
    echo "ERROR: Can't find $XDG_CONFIG_HOME/mpd/configs/virtual-cable.conf"
    exit 0
fi
echo "--- RESET MPD CONFIG ---"
rm $XDG_CONFIG_HOME/mpd/mpd.conf
cp $XDG_CONFIG_HOME/mpd/configs/virtual-cable.conf $XDG_CONFIG_HOME/mpd/mpd.conf
echo "--- RESTART MPD SERVICE ---"
systemctl --user restart mpd


