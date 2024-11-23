#!/bin/bash

#Filename: ~/github/dotfiles-latest/sketchybar/felixkratz/items/calendar.sh

calendar=(
	# icon=cal
	icon.font="$FONT:Medium:16.0"
	# Using default "SF Pro"
	# icon.font="$FONT:Black:12.0"
	icon.padding_right=4
	icon.padding_left=8
	label.font="$FONT:ExtraBold:16.0"
	label.width=60
	label.align=right
	label.padding_right=8
	padding_left=8
	padding_right=8
	update_freq=30
	background.color=$BACKGROUND_1
    icon.background.drawing=on
    background.border_color=$BLUE
	script="$PLUGIN_DIR/calendar.sh"
	click_script="$PLUGIN_DIR/zen.sh"
)

sketchybar --add item calendar right \
	--set calendar "${calendar[@]}" \
	--subscribe calendar system_woke
