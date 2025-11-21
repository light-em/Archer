#!/bin/bash

echo "Playlist Name: $1" # PLAYLIST NAME
echo "Playlist URL: $2"  # PLAYLIST URL
echo "------ CHECKING PLAYLIST INTEGRITY -----"
echo ''

music_dir="$HOME/music"
dir_name="$music_dir/$1"
file_m3u="$music_dir/playlists/$1.m3u"

if [[ -z $1 ]]; then
    echo "ERROR: PLAYLiST NAME NOT PROVIDED"
    exit 0
fi

if [[ -z $2 ]]; then
    echo "ERROR: PLAYLIST URL NOT PROVIDED"
    exit 0
fi

if [[ ! -d $dir_name ]]; then
    echo "Creating Dir: $dir_name"
    mkdir $dir_name
fi
cd $dir_name

# if [[ -f "$1.spotdl" ]]; then
    # spotdl sync "$1.spotdl"
# else
    # if [[ -z $2 ]]; then
        # echo "ERROR: NO PLAYLIST URL PROVIDED !! FKU !!!"
        # exit 0
    # fi
    # spotdl sync $2 --save-file $1.spotdl
# fi
# echo "------- DONE SYNCING -------"
# echo ""

yt-dlp -f "bestaudio" -t mp3 --write-thumbnail --add-metadata --postprocessor-args '-id3v2_version 3' -o "$1-%(playlist_index)s_%(title)s.%(ext)s" $2 --restrict-filenames
for file in *.mp3; do
    name="${file%.*}"
    mv ./$file ./temp.mp3
    if [ -e $name.webp ]; then
        magick $name.webp -shave 280x0 temp.png
        ffmpeg -i temp.mp3 -i temp.png -map_metadata 0 -map 0 -map 1 -acodec copy $name.mp3
        rm temp.*
        rm "$name.webp"
    fi
done

echo "------ REMAKING M3U -------"
if [[ -f $file_m3u ]]; then
    rm $file_m3u
fi
touch $file_m3u
for file in *.mp3; do
    echo "$1/$file" >> $file_m3u
done

