#!/usr/bin/env zsh

# Install Homebrew if it isn't already installed
if ! command -v brew &>/dev/null; then
	echo "Homebrew not installed. Installing Homebrew."
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

	# Attempt to set up Homebrew PATH automatically for this session
	if [ -x "/opt/homebrew/bin/brew" ]; then
		# For Apple Silicon Macs
		echo "Configuring Homebrew in PATH for Apple Silicon Mac..."
		export PATH="/opt/homebrew/bin:$PATH"
	fi
else
	echo "Homebrew is already installed."
fi

# Verify brew is now accessible
if ! command -v brew &>/dev/null; then
	echo "Failed to configure Homebrew in PATH. Please add Homebrew to your PATH manually."
	exit 1
fi

# Update Homebrew and Upgrade any already-installed formulae
brew update
brew upgrade
brew upgrade --cask
brew cleanup

# Define an array of taps
formulae=(
	"FelixKratz/formulae",
	"mongodb/brew"
)

# Define an array of packages to install using Homebrew
packages=(
	"bat",
	"borders",
	"fish",
	"fd",
	"fzf",
	"gh",
	"git",
	"lazygit",
	"lua",
	"luajit",
	"luarocks",
	"maven",
	"mongodb-community",
	"mongodb-database-tools",
	"mongosh",
	"mysql",
	"ncurses",
	"neofetch",
	"neovim",
	"nowplaying-cli",
	"pyenv",
	"pyenv-virtualenv"
	"readline",
	"ripgrep",
	"sketchybar",
	"starship",
	"stow"
	"tree",
	"tree-sitter",
	"wget",
	"yazi"
)

for formula in "${formulae[@]}"; do
	echo "Tapping $formula"
	brew tap "$formula"
done

# Loop over the array to install each application.
for package in "${packages[@]}"; do
	if brew list --formula | grep -q "^$package\$"; then
		echo "$package is already installed. Skipping..."
	else
		echo "Installing $package..."
		brew install "$package"
	fi
done

# Git config name
current_name=$($(brew --prefix)/bin/git config --global --get user.name)
if [ -z "$current_name" ]; then
	echo "Please enter your FULL NAME for Git configuration:"
	read git_user_name
	$(brew --prefix)/bin/git config --global user.name "$git_user_name"
	echo "Git user.name has been set to $git_user_name"
else
	echo "Git user.name is already set to '$current_name'. Skipping configuration."
fi

# Git config email
current_email=$($(brew --prefix)/bin/git config --global --get user.email)
if [ -z "$current_email" ]; then
	echo "Please enter your EMAIL for Git configuration:"
	read git_user_email
	$(brew --prefix)/bin/git config --global user.email "$git_user_email"
	echo "Git user.email has been set to $git_user_email"
else
	echo "Git user.email is already set to '$current_email'. Skipping configuration."
fi

apps=(
	"aerospace",
	"cheatsheet",
	"discord",
	"docker",
	"google-chrome",
	# "ghostty",
	"obsidian",
	"slack",
	"visual-studio-code",
	"zoom",
	"google-drive",
	"vlc",
	"insomnia",
	"wezterm"
)

# Loop over the array to install each application.
for app in "${apps[@]}"; do
	if brew list --cask | grep -q "^$app\$"; then
		echo "$app is already installed. Skipping..."
	else
		echo "Installing $app..."
		brew install --cask "$app"
	fi
done

# Install fonts
# cask-fonts has been deprecated. All fonts have been transitioned to homebrew-cask

fonts=(
	"font-hack-nerd-font",
	"font-sf-mono",
	"font-sf-pro",
	"sf-symbols",
	"font-jetbrains-mono-nerd-font",
	"font-source-code-pro",
	"font-lato",
	"font-montserrat",
	"font-nunito",
	"font-open-sans",
	"font-oswald",
	"font-poppins",
	"font-raleway",
	"font-roboto",
)

for font in "${fonts[@]}"; do
	# Check if the font is already installed
	if brew list --cask | grep -q "^$font\$"; then
		echo "$font is already installed. Skipping..."
	else
		echo "Installing $font..."
		brew install --cask "$font"
	fi
done

# Update and clean up again for safe measure
brew update
brew upgrade
brew upgrade --cask
brew cleanup
