#!/bin/bash

####### PROHIBITS RUNNING AS ROOT #######
if [ "$EUID" -eq 0 ]; then
  echo "This script must NOT be run as root. Please run as a regular user."
  exit 1
fi

######### SETTING UP ARCHER CONFIG DIR ###########
if [ "$ARCHER_CONFIG_DIR" = "" ]; then
    ARCHER_CONFIG_DIR="$HOME/Archer"
    echo "Using Default Archer Config Dir = $ARCHER_CONFIG_DIR"
else 
    echo "Using Defined Archer Config Dir = $ARCHER_CONFIG_DIR"
fi
HOMEX="$HOME"


###### SYNCING USER FILES/FOLDERS ######
user_add_file="$ARCHER_CONFIG_DIR/info/setup.user.add.info"
if [[ -f $user_add_file ]]; then
    echo "=> ADDING USER FILES/FOLDERS"
    # Copying Files
    while IFS= read -r line; do
        if [[ -z $line ]]; then 
            continue
        fi
        ref_path=$(echo $line | cut -d '|' -f 1 | sed 's/^[ \t]*//;s/[ \t]*$//')
        dependencies=$(echo $line | cut -d '|' -f 2)
        if [[ -z $ref_path ]]; then 
            continue
        fi

        if [[ $line == *"|"* ]]; then
        if ! pacman -Q $dependencies > /tmp/archer-packs.info; then
            echo "WARN::LOW::MISSING => $(cat /tmp/archer-packs.info)"
            continue
        fi
        fi


        if [[ -f "$ARCHER_CONFIG_DIR/setup/home/$ref_path" ]]; then
            if [[ ($1 == "--backup") && (! -z $(diff -rq "$ARCHER_CONFIG_DIR/setup/home/$ref_path" "$HOMEX/$ref_path")) ]]; then
                mv "$HOMEX/$ref_path" "$HOMEX/$ref_path.$(date +'%Y-%m-%d-%H-%M-%S').backup"
            fi
            rsync -rc --mkpath "$ARCHER_CONFIG_DIR/setup/home/$ref_path" "$HOMEX/$ref_path"

        elif [[ -d "$ARCHER_CONFIG_DIR/setup/home/$ref_path" ]]; then
            if [[ ($1 == "--backup") && (! -z $(diff -rq "$ARCHER_CONFIG_DIR/setup/home/$ref_path" "$HOMEX/$ref_path")) ]]; then
                mv "$HOMEX/$ref_path" "$HOMEX/$ref_path.$(date +'%Y-%m-%d-%H-%M-%S').backup"
            fi
            rsync -rc --mkpath "$ARCHER_CONFIG_DIR/setup/home/$ref_path/" "$HOMEX/$ref_path"

        else
            echo "LOG::SKIP => "$ARCHER_CONFIG_DIR/setup/home/$ref_path" DOES NOT EXIST !!!"
            continue
        fi
        echo "$ARCHER_CONFIG_DIR/setup/home/$ref_path  ->  $HOMEX/$ref_path"
    done < $user_add_file
else
    # Warning
    echo "ERROR::FATAL => $user_add_file Not Found!!!"
    exit 1
fi

###### SYNCING ROOT FILES/FOLDERS ######
root_add_file="$ARCHER_CONFIG_DIR/info/setup.root.add.info"
if [[ -f $root_add_file ]]; then
    echo "=> ADDING ROOT FILES/FOLDERS"
    # Copying Files
    while IFS= read -r line; do
        if [[ -z $line ]]; then 
            continue
        fi
        ref_path=$(echo $line | cut -d '|' -f 1 | sed 's/^[ \t]*//;s/[ \t]*$//')
        dependencies=$(echo $line | cut -d '|' -f 2)
        if [[ -z $ref_path ]]; then 
            continue
        fi

        if [[ $line == *"|"* ]]; then
        if ! pacman -Q $dependencies > /tmp/archer-packs.info; then
            echo "WARN::LOW::MISSING => $(cat /tmp/archer-packs.info)"
            continue
        fi
        fi

        if [[ -f "$ARCHER_CONFIG_DIR/setup/$ref_path" ]]; then
            if [[ ($1 == "--backup") && (! -z $(diff -rq "$ARCHER_CONFIG_DIR/setup/$ref_path" "$ref_path")) ]]; then
                sudo mv "$ref_path" "$ref_path.$(date +'%Y-%m-%d-%H-%M-%S').backup"
            fi
            sudo rsync -rc --mkpath "$ARCHER_CONFIG_DIR/setup/$ref_path" "$ref_path"

        elif [[ -d "$ARCHER_CONFIG_DIR/setup/$ref_path" ]]; then
            if [[ ($1 == "--backup") && (! -z $(diff -rq "$ARCHER_CONFIG_DIR/setup/$ref_path" "$ref_path")) ]]; then
                sudo mv "$ref_path" "$ref_path.$(date +'%Y-%m-%d-%H-%M-%S').backup"
            fi
            sudo rsync -rc --mkpath "$ARCHER_CONFIG_DIR/setup/$ref_path/" "$ref_path"

        else
            echo "LOG::SKIP => "$ARCHER_CONFIG_DIR/setup/$ref_path" DOES NOT EXIST !!!"
            continue
        fi
        echo "$ARCHER_CONFIG_DIR/setup/$ref_path  ->  $ref_path"
    done < $root_add_file
else
    # Warning
    echo "ERROR::FATAL => $root_add_file Not Found!!!"
    exit 1
fi

