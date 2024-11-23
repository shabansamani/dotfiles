#!/bin/bash

battery=(
	script="$PLUGIN_DIR/battery.sh"
	icon.font="$FONT:Regular:14.0"
	padding_right=8
	padding_left=4
	label.drawing=on
	update_freq=120
	updates=on
    background.border_color=$BLUE
)

sketchybar --add item battery right \
	--set battery "${battery[@]}" \
	--subscribe battery power_source_change system_woke
