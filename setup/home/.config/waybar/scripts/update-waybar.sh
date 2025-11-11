for file in ~/.config/waybar/modules/*.jsonc; do
    cpp -P -E $file > $file.json
    jq -e . "$file.json" > /dev/null 2>&1
    if [ $? -ne 0 ]; then
        echo $file
        echo "invalid file"
        exit 0
    fi
done
# for file in ~/.config/waybar/modules/custom/*.jsonc; do
    # cpp -P -E $file > $file.json
    # jq -e . "$file.json" > /dev/null 2>&1
    # if [ $? -ne 0 ]; then
        # echo $file
        # echo "invalid file"
        # exit 0
    # fi
# done
for file in ~/.config/waybar/modules/hyprland/*.jsonc; do
    cpp -P -E $file > $file.json
    jq -e . "$file.json" > /dev/null 2>&1
    if [ $? -ne 0 ]; then
        echo $file
        echo "invalid file"
        exit 0
    fi
done
cpp -P -E ~/.config/waybar/base.jsonc > ~/.config/waybar/base.json
cpp -P -E ~/.config/waybar/prefer.jsonc > ~/.config/waybar/prefer.json
echo "done creation"

jq -s add ~/.config/waybar/base.json ~/.config/waybar/prefer.json  ~/.config/waybar/modules/*.json  ~/.config/waybar/modules/hyprland/*.json > ~/.config/waybar/config.jsonc

echo "removing"
rm ~/.config/waybar/base.json ~/.config/waybar/prefer.json ~/.config/waybar/modules/*.json  ~/.config/waybar/modules/hyprland/*.json

