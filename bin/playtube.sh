#!/bin/bash

SEARCH=$*
echo "Playing Music based on the search: "$SEARCH
mpv --shuffle --no-video ytdl://ytsearch10:"$SEARCH" --ytdl-format=bestaudio --gapless-audio=yes
