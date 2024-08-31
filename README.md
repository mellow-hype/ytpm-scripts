# youtube playlist manager

## dependencies

- sway
- fuzzel
- jq
- mpv
- yt-dlp

## configuration

Run `init.sh` to create the default configuration directory (`$HOME/.config/ytpm`) and install the
default config file. Make sure to edit that file to update location of the directory containing the
`playlist.conf` file and the `playlists/` directory if they already exist or you want them placed
somewhere else. Otherwise, the default location for these files will be `$HOME/.local/ytpm`.

This will also install symlinks to the main scripts under `$HOME/bin`. Edit `init.sh` before running
it if this needs to be changed.

### playlists
Playlists to be tracked are configured in a `playlists.conf` file and have the format:

```
<playlist-name>,<playlist-url>
```

Playlists names should not have any spaces and playlist URLs must be compatible with yt-dlp.
The downloaded JSON metadata for each tracked playlist will be stored under `playlists/` in the
directory where `playlists.conf` is located.

After adding new playlists to track, run `utils/ytp-update.sh` to pull down the JSON metadata.


### mpv

Two mpv profiles are defined in `mpv-profile.conf` for YouTube video and audio. Append these
profiles to `$HOME/.config/mpv/mpv.conf` using:

```
cat mpv-profile.conf >> $HOME/.config/mpv/mpv.conf
```

## usage

### ytpm

This is the main script with simple functionality to list all available playlists (as defined in the
playlist file name field), list all episodes for a particular playlist, and fetch the URL of a
specific video from a playlist by title.

```
# list all tracked playlists
usage: ./ytpm list-all

# list all videos for a playlist
usage: ./ytpm list-playlist <playlist-name>

# get a video URL
usage: ./ytpm get-video <playlist-name> <video-name>
```

### ympv
This is just a wrapper around mpv to play a YouTube video URL with the correct profile is applied;
the same can be accomplished with a shell alias.

```
ympv <video-url>
```

## fuzzel/dmenu utils

### dm-ytpm
This script combines the data provided by the different `ytpm` subcommands to allow for selecting
videos from tracked playlists using dmenu menus (via fuzzel).

It will first list the playlists by name and then list the videos for the selected playlist; a video
can then be selected and played using `ympv`.

### dm-ytpv
This is similar to the previous script but will instead read a JSON file for a given playlist
directly and only list those videos.

