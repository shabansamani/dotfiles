#!/bin/bash

cpu_top=(
  label.font="$FONT:Medium:11"
  label=CPU
  icon.drawing=off
  width=0
  padding_right=15
  y_offset=6
)

cpu_percent=(
  label.font="$FONT:Medium:13"
  label=CPU
  y_offset=-8
  padding_right=15
  width=55
  icon.drawing=off
  update_freq=4
  mach_helper="$HELPER"
)

cpu_sys=(
  graph.color=$BLUE
  graph.fill_color=$BLUE
  y_offset=8
  padding_right=0
  label.drawing=off
  icon.drawing=off
  background.height=0
  background.drawing=on
  background.color=$TRANSPARENT
)

cpu_user=(
  graph.color=$ORANGE
  graph.fill_color=$ORANGE
  label.drawing=off
  icon.drawing=off
  padding_left=25
  y_offset=8
  background.height=0
  background.drawing=on
  background.color=$TRANSPARENT
)

sketchybar --add item cpu.top right              \
           --set cpu.top "${cpu_top[@]}"         \
                                                 \
           --add item cpu.percent right          \
           --set cpu.percent "${cpu_percent[@]}" \
                                                 \
           --add graph cpu.sys right 75          \
           --set cpu.sys "${cpu_sys[@]}"         \
                                                 \
           --add graph cpu.user right 75         \
           --set cpu.user "${cpu_user[@]}"
