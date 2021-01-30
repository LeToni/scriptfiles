#!/bin/bash


# This script move files which are older than 20 days
# from a directory to ~/.Trash.

# Use -f target-directory (~/Download as default)
# Use -d (Default is 20) Set days to indicate the maximum days to keep files.
# Use -t (default is ~/.Trash) Set the directory where you want files to move to.

# ex1. Move files which are older than 20 days in ~/Downloads
# to ~/.Trash
# cleanit

# ex2. Remove files which are older than 10 days from ~/.Trash
# cleanit -d 10 -t trash

# ex3. Move files which are older than 10 days in ~/Mydir
# to ~/.Trash
# cleanit -d 10 -f ~/Mydir

# ex4. Move files which are older than 5 days in ~/Mydir
# to ~/Anotherdir
# cleanfit -f ~/Mydir -d 5 -t ~/Anotherdir

move_to_trash() {
    find "$FROM_DIR" -mtime +"$DAYS" -exec mv {} "$TO_DIR" \; 2>/dev/null
    return 0
}

remove_from_trash() {
    local trash=$HOME/.Trash
    # remove files
    find "$trash" -mtime +"$DAYS" -exec rm -rf {} \; 2>/dev/null
    # remove direcotries
    find "$trash"/* -type d -mtime +"$DAYS" -exec rm -rf {} \; 2>/dev/null
    return 0
}

usage()
{
    echo "Usage: $0 [ -d DAYS ] [ -f FROM_DIR ] [ -t TO_DIR ]"
    exit 2
}

####################################
# Main script 

unset FROM_DIR TO_DIR DAYS

FROM_DIR=$HOME/Downloads
TO_DIR=$HOME/.Trash
DAYS=20

while getopts "f:d:t:?h" opt; do
    case $opt in
    f) FROM_DIR=$OPTARG ;;
    d) DAYS=$OPTARG ;;
    t) TO_DIR=$OPTARG ;;
    h|*) usage ;;
    esac
done

[ -z "$FROM_DIR" ] || [ -z "$DAYS" ] || [ -z "$TO_DIR" ] && usage


if [[ -d $FROM_DIR ]]; then
    NUM=$(find "$FROM_DIR" -mtime +"$DAYS" | wc -l | xargs)
elif [[ "$FROM_DIR" =~ "trash" ]]; then
    NUM=$(find "$HOME"/.Trash -mtime +"$DAYS" | wc -l | xargs)
else
    echo "No such directory: $FROM_DIR"
    exit 2
fi

if [[ $DAYS -lt 0 ]]; then
    echo "Days must be greater then 0."
    exit 2
fi

if [[ $NUM -gt 0 ]]; then
    shopt -s nocasematch
    if [[ "$FROM_DIR" =~ "trash" ]]; then
        # remove files from Trash permanently
        remove_from_trash
        echo "There are $NUM files older than $DAYS days in ~/.Trash. We removed them from ~/.Trash."
    else
        # move files to Trash
        move_to_trash
        echo "There are $NUM files older than $DAYS days in the  $FROM_DIR. We moved them to $TO_DIR."
    fi
else
    echo "There is no files older than $DAYS days in $FROM_DIR."
fi