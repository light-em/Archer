echo "Playlist Name: $1" # PLAYLIST NAME
echo "Playlist URL: $2"  # PLAYLIST URL
echo "------ CHECKING PLAYLIST INTEGRITY -----"
echo ''

parent_dir=$(pwd)
dir_name="$(pwd)/$1"
file_m3u="$parent_dir/playlists/$1.m3u"

if [[ -z $1 ]]; then
    echo "ERROR: PLAYLiST NAME NOT PROVIDED"
    exit 0
fi

if [[ ! -d $dir_name ]]; then
    echo "Creating Dir: $dir_name"
    mkdir $dir_name
fi
cd $dir_name

if [[ -f "$1.spotdl" ]]; then
    spotdl sync "$1.spotdl"
else
    if [[ -z $2 ]]; then
        echo "ERROR: NO PLAYLIST URL PROVIDED !! FKU !!!"
        exit 0
    fi
    spotdl sync $2 --save-file $1.spotdl
fi
echo "------- DONE SYNCING -------"
echo ""

echo "------ REMAKING M3U -------"
if [[ -f $file_m3u ]]; then
    rm $file_m3u
fi
touch $file_m3u
for file in *.*; do
    if [[ $file == *.spotdl ]]; then
        continue;
        echo "SPOTDL File Detected !! Continued ..."
    fi
    echo "$1/$file" >> $file_m3u
done


