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
else echo "Using Defined Archer Config Dir = $ARCHER_CONFIG_DIR"
fi


###### SYNCING USER FILES/FOLDERS ######
user_add_file="$ARCHER_CONFIG_DIR/info/setup.user.add.info"
if [[ -f $user_add_file ]]; then
    echo "=> ADDING USER FILES/FOLDERS"
    # Copying Files
    while IFS= read -r line; do
        ref_path=$(echo $line | cut -d '|' -f 1 | sed 's/^[ \t]*//;s/[ \t]*$//')

        # echo "ref: $ref_path"
        if [[ -z $ref_path ]]; then 
            continue
        fi
        if [[ -f "$HOME/$ref_path" ]]; then
            rsync -rc --mkpath "$HOME/$ref_path" "$ARCHER_CONFIG_DIR/setup/home/$ref_path"
        elif [[ -d "$HOME/$ref_path" ]]; then
            rsync -rc --mkpath "$HOME/$ref_path/" "$ARCHER_CONFIG_DIR/setup/home/$ref_path"
        else
            echo "WARNING::LOW => $HOME/$ref_path  DOES NOT EXIST !!!"
            continue
        fi
        echo "$HOME/$ref_path  ->  $ARCHER_CONFIG_DIR/setup/home/$ref_path"
    done < $user_add_file
else
    # Warning
    echo "ERROR::FATAL => $user_add_file Not Found!!!"
    exit 1
fi
user_remove_file="$ARCHER_CONFIG_DIR/info/setup.user.remove.info"
if [[ -f $user_remove_file ]]; then
    echo "=> REMOVING USER FILES/FOLDERS"
    # Copying Files
    while IFS= read -r ref_path; do
        # ref_path=$line|awk '{$1=$1};1'
        if [[ -z $ref_path ]]; then 
            continue
        fi
        if [[ ! -f "$ARCHER_CONFIG_DIR/setup/home/$ref_path" ]]; then
            echo "WARNING::LOW => $ARCHER_CONFIG_DIR/setup/home/$ref_path  DOES NOT EXIST !!!"
            continue
        fi
        rm -rf "$ARCHER_CONFIG_DIR/setup/home/$ref_path"
    done < $user_remove_file
else
    # Warning
    echo "ERROR::FATAL => $user_remove_file Not Found!!!"
    exit 1
fi


###### SYNCING ROOT FILES/FOLDERS ######
root_add_file="$ARCHER_CONFIG_DIR/info/setup.root.add.info"
if [[ -f $root_add_file ]]; then
    echo "=> ADDING ROOT FILES/FOLDERS"
    # Copying Files
    while IFS= read -r line; do
        ref_path=$(echo $line | cut -d '|' -f 1 | sed 's/^[ \t]*//;s/[ \t]*$//')
        # echo "ref: $ref_path"
        if [[ -z $ref_path ]]; then 
            continue
        fi
        if [[ -f "$ref_path" ]]; then
            rsync -rc --mkpath "$ref_path" "$ARCHER_CONFIG_DIR/setup/$ref_path"
        elif [[ -d "$ref_path" ]]; then
            rsync -rc --mkpath "$ref_path/" "$ARCHER_CONFIG_DIR/setup/$ref_path"
        else
            echo "WARNING::LOW => $HOME/$ref_path  DOES NOT EXIST !!!"
            continue
        fi
        echo "$ref_path  ->  $ARCHER_CONFIG_DIR/setup/$ref_path"
    done < $root_add_file
else
    # Warning
    echo "ERROR::FATAL => $root_add_file Not Found!!!"
    exit 1
fi
root_remove_file="$ARCHER_CONFIG_DIR/info/setup.root.remove.info"
if [[ -f $root_remove_file ]]; then
    echo "=> REMOVING ROOT FILES/FOLDERS"
    # Copying Files
    while IFS= read -r ref_path; do
        # ref_path=$line|awk '{$1=$1};1'
        if [[ -z $ref_path ]]; then 
            continue
        fi
        if [[ ! -f "$ARCHER_CONFIG_DIR/setup/$ref_path" ]]; then
            echo "WARNING::LOW => $ARCHER_CONFIG_DIR/setup/$ref_path  DOES NOT EXIST !!!"
            continue
        fi
        rm -rf "$ARCHER_CONFIG_DIR/setup/$ref_path"
    done < $root_remove_file
else
    # Warning
    echo "ERROR::FATAL => $root_remove_file Not Found!!!"
    exit 1
fi
