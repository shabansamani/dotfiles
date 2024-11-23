#!/bin/zsh

dots=(
	"aerospace",
	"nvim",
	"sketchybar",
	"neofetch",
	"wezterm",
	"starship",
	"borders"
)

for dot in "${dots[@]}"; do
	if [ -d "${HOME}/.config/$dot" ]; then
  		echo "$dot already exist. Skipping."
	else
		echo "Configuring $dot with GNU Stow..."
		stow "${dot}"
	fi 
done

open -j -a /Applications/Aerospace.app
open /Applications/WezTerm.app

# Hides Apple Menu Bar... requires logout or restart
defaults write NSGlobalDomain _HIHideMenuBar -bool true
echo "Hiding the Apple Menu Bar requires a restart. Press 'Y' to log out, or 'N' to skip: "
read response

if [ $response == 'Y' || $response == 'y' ]; then
	sudo pkill loginwindow
else
	echo "Skipping this for now..."
fi
