WALLUST_DIR=""
if [[ -z "$WALLUST_CONFIG_DIR" ]]; then
    WALLUST_DIR="$HOME/.config/wallust"
fi

source "$WALLUST_DIR/scripts/theme.sh"

  max=$(echo "if ($r > $g && $r > $b) $r else if ($g > $b) $g else $b" | bc)
  min=$(echo "if ($r < $g && $r < $b) $r else if ($g < $b) $g else $b" | bc)

  # Calculate Lightness (L)
  l=$(echo "scale=5; ($max + $min) / 2" | bc)

  # Calculate Saturation (S) and Hue (H)
  if (( $(echo "$max == $min" | bc -l) )); then
    s=0
    h=0
  else
    delta=$(echo "scale=5; $max - $min" | bc)
    if (( $(echo "$l > 0.5" | bc -l) )); then
      s=$(echo "scale=5; $delta / (2 - $max - $min)" | bc)
    else
      s=$(echo "scale=5; $delta / ($max + $min)" | bc)
    fi

    if (( $(echo "$r == $max" | bc -l) )); then
      h=$(echo "scale=5; ($g - $b) / $delta + ( ($g < $b) * 6 )" | bc)
    elif (( $(echo "$g == $max" | bc -l) )); then
      h=$(echo "scale=5; ($b - $r) / $delta + 2" | bc)
    else # b == max
      h=$(echo "scale=5; ($r - $g) / $delta + 4" | bc)
    fi
    h=$(echo "scale=5; $h / 6" | bc)
  fi

  # Convert HSL to typical ranges (H: 0-360, S: 0-100, L: 0-100)
  h_final=$(echo "scale=0; $h * 360 / 1" | bc)
  s_final=$(echo "scale=0; $s * 100 / 1" | bc)
  l_final=$(echo "scale=0; $l * 100 / 1" | bc)

accent_color="$(cat ~/.config/wallust/scripts/accent.info)"
for file in $WALLUST_DIR/templates/*.*; do
    if [[ $file == *".accent" ]]; then
        continue
    fi
    
    sed -e "s/<||accent||>/$accent_color/g" -e "s/<||accent_h||>/$h_final/g" -e "s/<||accent_s||>/$s_final/g" -e "s/<||accent_l||>/$l_final/g" $file > $file.accent
done

if [[ "$1" == "--run" ]]; then
    if [[ "$2" == "--new" ]]; then
        wallust ${@:3}
    elif [[ -f $wallpaper ]]; then
        wallust run $wallpaper ${@:2}
    else
        wallust theme $wallpaper ${@:2}
    fi
    rm $WALLUST_DIR/templates/*.accent 
    swaync-client -R -rs
fi
