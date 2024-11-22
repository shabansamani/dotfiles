#!/usr/bin/env bash

echo \$FOCUSED_WORKSPACE: $FOCUSED_WORKSPACE >> ~/aaaa
echo \$NAME: $NAME >> ~/aaaa
echo \$1: $1 >> ~/aaaa
if [ "$1" = "$FOCUSED_WORKSPACE" ]; then
    sketchybar --set $NAME background.drawing=on
else
    sketchybar --set $NAME background.drawing=off
fi
