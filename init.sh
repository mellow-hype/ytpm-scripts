#!/usr/bin/env bash
CONFDIR="$HOME/.config/ytpm"
BINDIR=$HOME/bin

# copy over the config dir if it doesn't exist
if [ ! -d "$CONFDIR" ]; then
    cp -R ./config "$CONFDIR"
fi

# set up symlinks to the scripts in $HOME/bin
[ ! -e $BINDIR/dm-ytpm ] && ln -s $PWD/dm-ytpm $BINDIR/dm-ytpm
[ ! -e $BINDIR/dm-ytpv ] && ln -s $PWD/dm-ytpv $BINDIR/dm-ytpv
[ ! -e $BINDIR/ytpm ] && ln -s $PWD/ytpm $BINDIR/ytpm
[ ! -e $BINDIR/ympv ] && ln -s $PWD/ympv $BINDIR/ympv
