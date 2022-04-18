.DEFAULT_GOAL := help
.PHONY: asdf sudo
.ONESHELL:

SHELL := /bin/bash

PACKAGES := git curl build-essential vim zsh tmux snapd
PACKAGES += libssl-dev libpam-gnome-keyring xclip
SNAPPACKAGES := discord insomnia gimp obs-studio
PROGRAMS := asdf neovim docker dropbox

# Terminal colors

# Dracula theme colors
BACKGROUND := \#282A36
CURRENT_LINE := \#44475A
FOREGROUND := \#F8F8F2
WHITE := \#F8F8F2
COMMENT := \#6272A4
CYAN := \#8BE9FD
GREEN := \#50FA7B
ORANGE := \#FFB86C
PINK := \#FF79C6
PURPLE := \#BD93F9
RED := \#FF5555
YELLOW := \#F1FA8C
# Not from dracula
GRAY := \#2E3436
BLUE := \#5D7BE6
# Changes default terminal color palette
# black, red, green, yellow, blue, purple, cyan, white
PALETTE := "['$(GRAY)', '$(RED)', '$(GREEN)', '$(YELLOW)', '$(BLUE)', '$(PURPLE)', '$(CYAN)', '$(WHITE)', 'rgb(76,76,76)', 'rgb(255,0,0)', 'rgb(0,255,0)', 'rgb(255,255,0)', 'rgb(70,130,180)', 'rgb(255,0,255)', 'rgb(0,255,255)', 'rgb(255,255,255)']"

help:
	@echo "Usage:"
	@echo
	@echo "make listprograms: list all programs installed by the recipes"
	@echo "make install: install all programs"
	@echo "make dotfiles: install dotfiles (github.com/iagotito/dotfiles)"
	@echo "make backgroundsetup: setup the wallpaper picture"
	@echo "make fontsetup: setup the system font"
	@echo "make themesetup: setup the system theme"
	@echo "make terminalsetup: setup the terminal colors and font"
	@echo "make fullsetup: setup packages, dotfiles, theme and terminal"

sudo: # grant sudo authentication to shell
	@sudo ls > /dev/null

listprograms:
	@echo "$(PACKAGES) $(PROGRAMS)"

install: packagesinstall neoviminstall dockerinstall dropboxinstall asdfinstall

fullsetup: install pythonasdfinstall nodeasdfinstall zshsetup

packagesinstall: sudo
	@echo "Installing packages: $(PACKAGES)"
	sudo apt update
	sudo apt install $(PACKAGES) -y
	@echo "Packages installed"

snappackagesinstall: sudo

_ASDF_DIR := "$${HOME}/.asdf"
_ASDF_SCRIPT := "$(_ASDF_DIR)/asdf.sh"
asdf:
	@source $(_ASDF_SCRIPT)

asdfinstall:
	$(eval ASDF_BRANCH_VERSION := "v0.9.0") # TODO: get the latest
	@echo "Installing asdf"
	git clone https://github.com/asdf-vm/asdf.git $(_ASDF_DIR) --branch $(ASDF_BRANCH_VERSION)
	@echo "asdf installed"

pythonasdfinstall: asdf
	asdf plugin-add python 2> /dev/null || true
	$(eval PYTHON_VERSION = $(shell asdf list all python | grep "^[0-9]\+\.[0-9]\+\.[0-9]\+" | grep -v "[a-zA-Z]" | tail -n 1))
	asdf install python $(PYTHON_VERSION)
	asdf global python $(PYTHON_VERSION)

nodeasdfinstall: adsf
	asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git 2> /dev/null || true
	$(eval NODE_VERSION = $(shell asdf list all nodejs | grep "^[0-9]\+\.[0-9]\+\.[0-9]\+" | grep -v "[a-zA-Z]" | tail -n 1))
	asdf install nodejs $(NODE_VERSION)
	asdf global nodejs $(NODE_VERSION)

neoviminstall: sudo
	$(eval NEOVIM_DIR := "$${HOME}/.nvim")
	@echo "Installing neovim"
	curl --silent -L --create-dirs --output $(NEOVIM_DIR)/nvim.appimage https://github.com/neovim/neovim/releases/latest/download/nvim.appimage; \
	 chmod u+x $(NEOVIM_DIR)/nvim.appimage
	sudo ln -s -T $(NEOVIM_DIR)/nvim.appimage /usr/bin/nvim
	@echo "Neovim installed"

dockerinstall: sudo
	@echo "Installing docker"
	sudo apt install -y ca-certificates curl gnupg lsb-release
	curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor --batch --yes -o /usr/share/keyrings/docker-archive-keyring.gpg
	echo \
	  "deb [arch=$(shell dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
	  $(shell lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
	sudo apt update
	sudo apt install -y docker-ce docker-ce-cli containerd.io
	@echo "Docker installed"
	sudo groupadd -f docker
	sudo usermod -aG docker $${USER}

dropboxinstall:
	@echo "Installing dropbox"
	cd ~ && wget -O - "https://www.dropbox.com/download?plat=lnx.x86_64" | tar xzf -
	(crontab -l 2>/dev/null; echo "@reboot $${HOME}/.dropbox-dist/dropboxd") | crontab -
	@echo "Dropbox installed"
	@echo "Run '~/.dropbox-dist/dropboxd' to login into docker account"

zshsetup: sudo
	$(eval CHSH_FILE := "/etc/pam.d/chsh")
	@sudo sed -i "1 i\# This allows users of group chsh to change their shells without a password." $(CHSH_FILE)
	@sudo sed -i "2 i\# Per: http://serverfault.com/questions/202468/changing-the-shell-using-chsh-via-the-command-line-in-a-script" $(CHSH_FILE)
	sudo sed -i "3 i\auth       sufficient   pam_wheel.so trust group=chsh" $(CHSH_FILE)
	sudo groupadd -f chsh
	sudo usermod -aG chsh $${USER}
	chsh -s $(shell which zsh) $${USER}

dotfiles: zshdotfilessetup tmuxdotfilessetup neovimdotfilessetup

zshdotfilessetup: sudo
	sudo ln -s ~/.dotfiles/zsh/zshenv ~/.zshenv 2> /dev/null
	mkdir -p ~/.config/zsh 2> /dev/null
	sudo ln -s ~/.dotfiles/zsh/zshrc ~/.config/zsh/.zshrc 2> /dev/null

tmuxdotfilessetup: sudo
	sudo ln -s ~/.dotfiles/tmux/tmux.conf ~/.tmux.conf 2> /dev/null

neovimdotfilessetup: SHELL := /usr/bin/zsh
neovimdotfilessetup: sudo
	mkdir ~/.config 2> /dev/null
	sudo ln -s ~/.dotfiles/nvim/ ~/.config/nvim 2> /dev/null
	git clone --depth=1 https://github.com/savq/paq-nvim.git \
	 $(XDG_DATA_HOME)/nvim/site/pack/paqs/start/paq-nvim
	nvim --headless +PaqInstall +q

iconthemesetup: sudo
	curl -L 'https://github.com/EliverLara/candy-icons/archive/refs/heads/master.zip' -o /tmp/candy-icons.zip
	sudo unzip /tmp/candy-icons.zip -d /usr/share/icons/
	gsettings set org.gnome.desktop.interface icon-theme candy-icons-master

themesetup: sudo
	curl -L 'https://github.com/EliverLara/Sweet/releases/download/v3.0/Sweet-Dark-v40.zip' -o /tmp/sweet-theme.zip
	sudo unzip /tmp/sweet-theme.zip -d /usr/share/themes/
	gsettings set org.gnome.desktop.interface gtk-theme 'Sweet-Dark-v40'
	gsettings set org.gnome.desktop.wm.preferences theme 'Sweet-Dark-v40'

fontsdownload: sudo
	sudo mkdir -p /usr/share/fonts/ttf
	curl -L https://github.com/source-foundry/Hack/releases/download/v3.003/Hack-v3.003-ttf.zip -o /tmp/hack-font.zip
	sudo unzip /tmp/hack-font.zip -d /tmp/hack-font/
	sudo cp -t /usr/share/fonts/ttf/ /tmp/hack-font/ttf/*
	curl -L https://github.com/tonsky/FiraCode/releases/download/6.2/Fira_Code_v6.2.zip -o /tmp/firacode.zip
	sudo unzip /tmp/firacode.zip -d /tmp/firacode/
	sudo cp -t /usr/share/fonts/ttf/ /tmp/firacode/ttf/*

fontsetup: sudo fontsdownload
	gsettings set org.gnome.desktop.interface font-name 'Hack Regular 12'

backgroundsetup: sudo
	$(eval DOTFILES_WALLPAPER_PATH := '$${HOME}/.dotfiles/city-wallpaper.png')
	$(eval BACKGROUNDS_WALLPAPER_PATH := '/usr/share/backgrounds/city-wallpaper.png')
	$(eval PICTURE_URI := 'file://$(BACKGROUNDS_WALLPAPER_PATH)')
	sudo cp $(DOTFILES_WALLPAPER_PATH) $(BACKGROUNDS_WALLPAPER_PATH)
	gsettings set org.gnome.desktop.background picture-uri $(PICTURE_URI)
	gsettings set org.gnome.desktop.screensaver picture-uri $(PICTURE_URI)

docksetup:
	gsettings set org.gnome.shell.extensions.dash-to-dock dock-fixed 'false'
	gsettings set org.gnome.shell.extensions.dash-to-dock autohide 'true'
	gsettings set org.gnome.shell.extensions.dash-to-dock intellihide 'true'
	gsettings set org.gnome.shell.extensions.dash-to-dock extend-height 'false'

terminalsetup:
	# From: https://askubuntu.com/questions/1141782/how-to-change-the-background-of-the-terminal-through-a-command
	$(eval DEFAULT_PROFILE := $(shell gsettings get org.gnome.Terminal.ProfilesList default))
	$(eval PROFILE_ID := $(shell echo "$(DEFAULT_PROFILE)" | cut -d "'" -f 2))
	gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$(PROFILE_ID)/ use-theme-colors false
	gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$(PROFILE_ID)/ palette $(PALETTE)
	gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$(PROFILE_ID)/ background-color '$(BACKGROUND)'
	gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$(PROFILE_ID)/ use-system-font false
	gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$(PROFILE_ID)/ font 'Fira Code Medium 16'

test:
	$(eval DEFAULT_PROFILE := $(shell gsettings get org.gnome.Terminal.ProfilesList default))
	$(eval PROFILE_ID := $(shell echo "$(DEFAULT_PROFILE)" | cut -d "'" -f 2))
	echo $(PROFILE_ID)
