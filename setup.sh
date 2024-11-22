#!/usr/bin/env zsh
############################
# This script creates symlinks from the home directory to any desired dotfiles in $HOME/dotfiles
# And also installs MacOS Software
# And also installs Homebrew Packages and Casks (Apps)
# And also sets up VS Code
# Also sets up GNU Stow to configure NeoVim, Aerospace WM, Sketchybar and WezTerm
############################

# dotfiles directory
dotfiledir="${HOME}/dotfiles"
shelldir="${dotfiledir}/zsh"

# list of files/folders to symlink in ${homedir}
files=(zshrc zprofile zprompt bashrc bash_profile bash_prompt aliases private)

# change to the dotfiles directory
echo "Changing to the ${shelldir} directory"
cd "${shelldir}" || exit

# create symlinks (will overwrite old dotfiles)
for file in "${files[@]}"; do
	echo "Creating symlink to $file in home directory."
	ln -sf "${shelldir}/.${file}" "${HOME}/.${file}"
done

echo "Changing to the ${dotfiledir} directory"
cd "${HOME}/dotfiles" || exit

# Run the MacOS Script
./macOS.sh

# Run the Homebrew Script
./brew.sh

# Run VS Code Script
./vscode.sh

# Run GNU Stow (& other misc config)
./stow.sh

sdks=(
	"java"
	"gradle",
	"groovy",
	"jbang",
	"jetty",
	"kotlin",
	"maven",
	"micronaut",
	"quarkus",
	"springboot"
)

# Install SDKMAN!
curl -s "https://get.sdkman.io" | zsh
source "${HOME}/.sdkman/bin/sdkman-init.sh"

# Check if SDKMAN! is installed
if ! command -v sdk &>/dev/null; then
	echo "SDKMAN not able to be used. Please configure manually. Aborting..."
else
	for sdk in "${sdks[@]}"; do
		echo "Installing sdk for $sdk"
		sdk install "$sdk"
	done
fi

echo "Installation Complete!"
