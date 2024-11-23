#!/bin/bash

# Filename: ~/github/dotfiles-latest/sketchybar/felixkratz/items/volume.sh

volume_slider=(
	script="$PLUGIN_DIR/volume.sh"
	updates=on
	label.drawing=off
	icon.drawing=off
	slider.highlight_color=$YELLOW
	slider.background.height=5
	slider.background.corner_radius=3
	slider.knob=􀀁
	slider.knob.drawing=on
    background.border_color=$BLUE
)

volume_icon=(
	click_script="$PLUGIN_DIR/volume_click.sh"
	padding_left=10
	icon=$VOLUME_100
	icon.width=0
	icon.align=left
	icon.color=$GREY
	icon.font="$FONT:Regular:14.0"
	label.width=25
	label.align=left
	label.font="$FONT:Regular:14.0"
    background.border_color=$BLUE
)

status_bracket=(
	background.color=$BACKGROUND_1
    background.border_color=$BLUE
)

sketchybar --add slider volume right \
	--set volume "${volume_slider[@]}" \
	--subscribe volume volume_change \
	mouse.clicked \
	\
	--add item volume_icon right \
	--set volume_icon "${volume_icon[@]}"

sketchybar --add bracket status brew github.bell wifi volume_icon \
	--set status "${status_bracket[@]}"
