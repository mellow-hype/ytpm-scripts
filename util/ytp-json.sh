#!/bin/bash
# Download JSON metadata for the given Youtube playlist URL and create a filtered version that can
# be reused by other scripts.

# usage:
#   - json-outfile: path where the json metadata file for the plist will be stored
#   - playlist-url: YouTube URL for the playlist
if [ $# != 2 ]; then
    echo "usage: $0 <json-outfile> <playlist-url>"
    exit 1
fi

OUTRAW="/tmp/playlist-raw.json"
OUTFILE="$1"
URL="$2"

yt-dlp -j --flat-playlist "$URL" > $OUTRAW
PLISTNAME=$(jq '.playlist' "$OUTRAW" | uniq | tr -d '"')

if [ ! -z "$PLISTNAME" ]; then
    jq '{id: .id, title: .title, url: .url}' "$OUTRAW" | jq -s "{playlist: \"$PLISTNAME\",videos: .}" > $OUTFILE
fi

