#!/bin/bash

. $HOME/.config/ytpm/config

# if $PLIST_FILE wasn't defined in the config file, require them as args
if [ -z $PLIST_FILE ]; then
    if [ $# != 2 ]; then
        echo "usage: $(basename $0) <playlists-file> <playlists-dir>"
        exit 1
    fi
    PLIST_FILE="$1"
    PLIST_DIR="$2"
fi

SCRIPTDIR=$(dirname "$0")
JSONDL="$SCRIPTDIR/ytp-json.sh"

echo "DEBUG: using playlist file $PLIST_FILE"
echo "DEBUG: using playlist dir $PLIST_DIR"
echo "DEBUG: using json download script $JSONDL"

while read plist; do
    URL=$(echo $plist | cut -d "," -f 2)
    NAME="$(echo $plist | cut -d "," -f 1).json"
    OUTJSON="$PLIST_DIR/$NAME"

    # run the JSON download script to get an updated json dump
    "$JSONDL" "$OUTJSON" "$URL"
    echo "Updated $NAME"
done < $PLIST_FILE

