scripts_name=(

    # "Setup Virtual Audio Link"
    # "Reset Virtual Audio Link"
    "Toggle Virtual Audio Link"
    "Toggle Eye-Candy"
    
    "auto-cpufreq default"
    "auto-cpufreq powersave"
    "auto-cpufreq performance"

    "Theme Switch"
    "Waybar Switch"
    "Wallpaper Switch"
    "Wallpaper Theme Switch"

    "Regen Theme"
    "Theme Accent Switch"

    "Hpyrshot Window"
    "Hyprshot Output"
    "Hyprshot Region"

    "Layout Dwindle"
    "Layout Scrolling"

    "Sleep"
    "Lock"
    "Logout"
    "Reboot"
    "Shutdown"
)
scripts_str=(

    "$HOME/.config/mpd/scripts/toggle-virtual-audio-link.sh"
    "$HOME/.config/mpd/scripts/toggle-eye-candy.sh"

    "pkexec auto-cpufreq --force reset"
    "pkexec auto-cpufreq --force powersave"
    "pkexec auto-cpufreq --force performance"

    "$HOME/.config/wallust/scripts/wallust-set-theme.sh"
    "$HOME/.config/waybar/scripts/waybar-switch.sh"
    "$HOME/.config/hypr/scripts/swww_wall_selector.sh"
    "$HOME/.config/hypr/scripts/wallust_swww_wall_selector.sh"

    "sh $HOME/.config/wallust/scripts/wallust-accent.sh --run"
    "sh $HOME/.config/wallust/scripts/wallust-set-accent.sh; sh $HOME/.config/wallust/scripts/wallust-accent.sh --run "

    "hyprshot -m window"
    "hyprshot -m output"
    "hyprshot -m region"

    "hyprctl keyword general:layout dwindle"
    "hyprctl keyword general:layout scrolling"

    "hyprlock && systemctl suspend"
    "hyprlock"
    "hyprctl dispatch exit"
    "reboot"
    "shutdown now"
)
scripts_run_type=(
    # 0 -> command no output
    # 1 -> command interactive
    # 2 -> script no output
    # 3 -> script interactive
    3
    2

    1
    1
    1

    3
    2
    2
    3

    1
    0

    0
    0
    0

    0
    0

    0
    0
    0
    0
    0
)
scripts_count=${#scripts_name[@]}

for (( i=0; i<scripts_count; i++ )); do
    if [[ ${scripts_run_type[$index]} < 0 ]] || [[ ${scripts_run_type[$index]} > 3 ]]; then
        notify-send "Error::Wrong-Run-Type::${scripts_name[$i]}"
        unset scripts_name[$i]
    fi
    if [[ ${scripts_run_type[$i]} > 1 ]] && [[ ! -f ${scripts_str[$i]} ]]; then
        notify-send "Error::Script-Not-Found::${scripts_name[$i]}"
        unset scripts_name[$i]
    fi
done

index=$(printf "<span weight='bold'>%s</span>\n" "${scripts_name[@]}" | rofi -dmenu -markup-rows -p '󰌧 Run' -format 'i' -matching fuzzy -i -no-case-sensitivity)
if [[ -z "$index" ]]; then
    exit 0
fi

if [[ $1 -eq '--debug' ]]; then
    if [[ ${scripts_run_type[$index]} > 1 ]]; then
        scripts_run_type[$index]=3
    else
        scripts_run_type[$index]=1
    fi
fi

case ${scripts_run_type[$index]} in
    0)
        # notify-send "Running Command: ${scripts_name[$index]}"
        eval ${scripts_str[$index]}
        ;;
    1)
        # notify-send "Running Command: ${scripts_name[$index]} in $TERMINAL"
        $TERMINAL --title run-script-output-dialog-float sh -c "${scripts_str[$index]}; echo 'Press [Enter] to EXIT ...'; read"
        ;;
    2)
        # notify-send "Running Script: ${scripts_name[$index]}"
        sh ${scripts_str[$index]}
        ;;
    3)
        # notify-send "Running Script: ${scripts_name[$index]} in $TERMINAL"
        $TERMINAL --title run-script-output-dialog-float sh -c "sh ${scripts_str[$index]}; echo 'Press [Enter] to EXIT ...'; read"
        ;;
    *)
        notify-send "U dumb piece of shit f-ing script kiddie !!"
        ;;
esac
