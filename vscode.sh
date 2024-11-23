#!/usr/bin/env zsh

# Check if Homebrew's bin exists and if it's not already in the PATH
if [ -x "/opt/homebrew/bin/brew" ] && [[ ":$PATH:" != *":/opt/homebrew/bin:"* ]]; then
	export PATH="/opt/homebrew/bin:$PATH"
fi

# Install VS Code Extensions
extensions=(
	aaron-bond.better-comments
	andrejunges.handlebars
	arjun.swagger-viewer
	cstrap.flask-snippets
	dbaeumer.vscode-eslint
	dsznajder.es7-react-js-snippets
	ecmel.vscode-html-css
	esbenp.prettier-vscode
	formulahendry.auto-close-tag
	formulahendry.auto-rename-tag
	formulahendry.code-runner
	foxundermoon.shell-format
	hookyqr.minif
	inferrinizzard.prettier-sql-vscode
	mechatroner.rainbow-csv
	ms-python.black-formatter
	ms-python.debugpy
	ms-python.isort
	ms-python.pylint
	ms-python.python
	ms-toolsai.jupyter
	ms-toolsai.jupyter-keymap
	ms-toolsai.jupyter-renderers
	ms-toolsai.vscode-jupyter-cell-tags
	ms-toolsai.vscode-jupyter-slideshow
	ms-vscode.theme-predawnkit
	mtxr.sqltools
	mtxr.sqltools-driver-sqlite
	msjsdiag.vscode-react-native
	naco-siren.gradle-language
	pkief.material-icon-theme
	planbcoding.vscode-react-refactor
	qufiwefefwoyn.kanagawa
	redhat.fabric8-analytics
	redhat.java
	redhat.vscode-apache-camel
	redhat.vscode-commons
	redhat.vscode-microprofile
	redhat.vscode-openshift-connector
	redhat.vscode-quarkus
	redhat.vscode-redhat-account
	redhat.vscode-xml
	redhat.vscode-yaml
	richardwillis.vscode-gradle-extension-pack
	samuelcolvin.jinjahtml
	sohibe.java-generate-setters-getters
	visualstudioexptteam.intellicode-api-usage-examples
	visualstudioexptteam.vscodeintellicode
	teabyii.ayu
	tomoki1207.pdf
	vmware.vscode-boot-dev-pack
	vmware.vscode-spring-boot
	vscjava.vscode-gradle
	vscjava.vscode-java-debug
	vscjava.vscode-java-dependency
	vscjava.vscode-java-pack
	vscjava.vscode-java-test
	vscjava.vscode-lombok
	vscjava.vscode-maven
	vscjava.vscode-spring-boot-dashboard
	vscjava.vscode-spring-initializr
	vscode-icons-team.vscode-icons
	wholroyd.jinja
)

# Get a list of all currently installed extensions.
installed_extensions=$(code --list-extensions)

for extension in "${extensions[@]}"; do
	if echo "$installed_extensions" | grep -qi "^$extension$"; then
		echo "$extension is already installed. Skipping..."
	else
		echo "Installing $extension..."
		code --install-extension "$extension"
	fi
done

echo "VS Code extensions have been installed."

# Define the target directory for VS Code user settings on macOS
VSCODE_USER_SETTINGS_DIR="${HOME}/Library/Application Support/Code/User"

# Check if VS Code settings directory exists
if [ -d "$VSCODE_USER_SETTINGS_DIR" ]; then
	# Copy your custom settings.json and keybindings.json to the VS Code settings directory
	ln -sf "${HOME}/dotfiles/settings/VSCode-Settings.json" "${VSCODE_USER_SETTINGS_DIR}/settings.json"
	ln -sf "${HOME}/dotfiles/settings/VSCode-Keybindings.json" "${VSCODE_USER_SETTINGS_DIR}/keybindings.json"

	echo "VS Code settings and keybindings have been updated."
else
	echo "VS Code user settings directory does not exist. Please ensure VS Code is installed."
fi

# Open VS Code to sign-in to extensions
code .
echo "Login to extensions (Copilot, Grammarly, etc) within VS Code."
echo "Press enter to continue..."
read
