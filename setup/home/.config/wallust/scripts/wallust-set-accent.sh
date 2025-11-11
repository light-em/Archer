WALLUST_DIR=""
if [[ -z "$WALLUST_CONFIG_DIR" ]]; then
    WALLUST_DIR="$HOME/.config/wallust"
fi


source "$WALLUST_DIR/scripts/theme.sh"

if [[ -f "/tmp/temp-accent-set.info" ]]; then
    rm /tmp/temp-accent-set.info
fi
function hexprint() {
    echo "<span color='$1' weight='bold'>$2</span>" >> /tmp/temp-accent-set.info
}

hexprint $accent "previous accent: ██ $accent"
hexprint $color1 "color1: ██ $color1"
hexprint $color2 "color2: ██ $color2"
hexprint $color3 "color3: ██ $color3"
hexprint $color4 "color4: ██ $color4"
hexprint $color5 "color5: ██ $color5"
hexprint $color6 "color6: ██ $color6"
hexprint $color7 "color7: ██ $color7"
hexprint $color8 "color8: ██ $color8"
hexprint $color9 "color9: ██ $color9"
hexprint $color10 "color10: ██ $color10"
hexprint $color11 "color11: ██ $color11"
hexprint $color12 "color12: ██ $color12"
hexprint $color13 "color13: ██ $color13"
hexprint $color14 "color14: ██ $color14"
hexprint $color15 "color15: ██ $color15"
hexprint $color0 "color0: ██ $color0"
hexprint $cursor "cursor: ██ $cursor"

index=$(cat /tmp/temp-accent-set.info | rofi -dmenu -markup-rows -p 'Choose Accent' -format 'i')

if [[ ! -z $index ]]; then
    value="color6"
    case $index in
        '1'|'2'|'3'|'4'|'5'|'6'|'7'|'8'|'9'|'10'|'11'|'12'|'13'|'14'|'15')
            value="color$index"
            ;;
        '16')
            value="color0"
            ;;
        '17')
            value="cursor"
            ;;
        0)
            value=""
            ;;
    esac
    if [[ ! -z $value ]]; then
        if [[ $1 == '--filter' ]]; then
            echo "$value | $2" > $WALLUST_DIR/scripts/accent.info
        else
            echo $value > $WALLUST_DIR/scripts/accent.info
        fi
    fi
fi

