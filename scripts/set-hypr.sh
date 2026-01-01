#!/bin/bash

# Based on:
# HyprV4 By SolDoesTech - https://www.youtube.com/@SolDoesTech
# License..? - You may copy, edit and ditribute this script any way you like, enjoy! :)

# The follwoing will attempt to install all needed packages to run Hyprland
# This is a quick and dirty script there are some error checking
# IMPORTANT - This script is meant to run on a clean fresh Arch install on physical hardware

# Set the dotfiles directory path
DOTFILES_DIR="$HOME/.dotfiles"

# Define the software that would be inbstalled
#Need some prep work
prep_stage=(
    qt5-wayland
    qt5ct
    qt6-wayland
    qt6ct
    qt5-svg
    qt5-quickcontrols2
    qt5-graphicaleffects
    gtk3
    polkit-gnome
    pipewire
    wireplumber
    jq
    wl-clipboard
    cliphist
    python-requests
    pacman-contrib
    cpio
)

#software for nvidia GPU only
nvidia_stage=(
    linux-headers
    nvidia-dkms
    nvidia-settings
    libva
    libva-nvidia-driver-git
)

#the main packages
install_stage=(
    kitty
    mako
    waybar
    hyprlock
    hypridle
    hyprpaper
    wlogout
    wofi
    xdg-desktop-portal-hyprland
    swappy
    grim
    slurp
    thunar
    btop
    firefox
    thunderbird
    mpv
    pamixer
    pavucontrol
    brightnessctl
    bluez
    bluez-utils
    blueman
    network-manager-applet
    gvfs
    thunar-archive-plugin
    file-roller
    zsh
    papirus-icon-theme
    ttf-jetbrains-mono-nerd
    noto-fonts-emoji
    lxappearance
    xfce4-settings
    nwg-look
    sddm
    stow
    tmux
    eza
    flameshot-git
    ttf-firacode-nerd
    fzf
    ripgrep
    less
    asdf-vm
)

# set some colors
CNT="[\e[1;36mNOTE\e[0m]"
COK="[\e[1;32mOK\e[0m]"
CER="[\e[1;31mERROR\e[0m]"
CAT="[\e[1;37mATTENTION\e[0m]"
CWR="[\e[1;35mWARNING\e[0m]"
CAC="[\e[1;33mACTION\e[0m]"
INSTLOG="install.log"

######
# functions go here

# function that would show a progress bar to the user
show_progress() {
    while ps | grep $1 &> /dev/null;
    do
        echo -n "."
        sleep 2
    done
    echo -en "Done!\n"
    sleep 2
}

# function that will test for a package and if not found it will attempt to install it
install_software() {
    # First lets see if the package is there
    if yay -Q $1 &>> /dev/null ; then
        echo -e "$COK - $1 is already installed."
    else
        # no package found so installing
        echo -en "$CNT - Now installing $1 ."
        yay -S --noconfirm $1 &>> $INSTLOG &
        show_progress $!
        # test to make sure package installed
        if yay -Q $1 &>> /dev/null ; then
            echo -e "\e[1A\e[K$COK - $1 was installed."
        else
            # if this is hit then a package is missing, exit to review log
            echo -e "\e[1A\e[K$CER - $1 install had failed, please check the install.log"
            exit
        fi
    fi
}

# clear the screen
clear

# set some expectations for the user
echo -e "$CNT - You are about to execute a script that would attempt to setup Hyprland.
Please note that Hyprland is still in Beta."
sleep 1

# attempt to discover if this is a VM or not
echo -e "$CNT - Checking for Physical or VM..."
ISVM=$(hostnamectl | grep Chassis)
echo -e "Using $ISVM"
if [[ $ISVM == *"vm"* ]]; then
    echo -e "$CWR - Please note that VMs are not fully supported and if you try to run this on
    a Virtual Machine there is a high chance this will fail."
    sleep 1
fi

# let the user know that we will use sudo
echo -e "$CNT - This script will run some commands that require sudo. You will be prompted to enter your password.
If you are worried about entering your password then you may want to review the content of the script."
sleep 1

# give the user an option to exit out
read -rep $'[\e[1;33mACTION\e[0m] - Would you like to continue with the install (y,n) ' CONTINST
if [[ $CONTINST == "Y" || $CONTINST == "y" ]]; then
    echo -e "$CNT - Setup starting..."
    sudo touch /tmp/hyprv.tmp
else
    echo -e "$CNT - This script will now exit, no changes were made to your system."
    exit
fi

# find the Nvidia GPU
if lspci -k | grep -A 2 -E "(VGA|3D)" | grep -iq nvidia; then
    ISNVIDIA=true
else
    ISNVIDIA=false
fi

### Disable wifi powersave mode ###
read -rep $'[\e[1;33mACTION\e[0m] - Would you like to disable WiFi powersave? (y,n) ' WIFI
if [[ $WIFI == "Y" || $WIFI == "y" ]]; then
    LOC="/etc/NetworkManager/conf.d/wifi-powersave.conf"
    echo -e "$CNT - The following file has been created $LOC.\n"
    echo -e "[connection]\nwifi.powersave = 2" | sudo tee -a $LOC &>> $INSTLOG
    echo -en "$CNT - Restarting NetworkManager service, Please wait."
    sleep 2
    sudo systemctl restart NetworkManager &>> $INSTLOG

    #wait for services to restore (looking at you DNS)
    for i in {1..6}
    do
        echo -n "."
        sleep 1
    done
    echo -en "Done!\n"
    sleep 2
    echo -e "\e[1A\e[K$COK - NetworkManager restart completed."
fi

#### Check for package manager (yay) ####
if ! command -v yay &> /dev/null; then
    echo -en "$CNT - Configuring yay."
    git clone https://aur.archlinux.org/yay.git &>> "$INSTLOG"
    cd yay || exit 1
    makepkg -si --noconfirm &>> "../$INSTLOG" &
    show_progress $!

    cd ..

    if command -v yay &> /dev/null; then
        echo -e "\e[1A\e[K$COK - yay configured."
        # update yay database
        echo -en "$CNT - Updating yay."
        yay -Syu --noconfirm &>> "$INSTLOG" &
        show_progress $!
        echo -e "\e[1A\e[K$COK - yay updated."
    else
        echo -e "\e[1A\e[K$CER - yay install failed, please check install.log"
        exit 1
    fi
fi

### Install all of the above pacakges ####
read -rep $'[\e[1;33mACTION\e[0m] - Would you like to install the packages? (y,n) ' INST
if [[ $INST == "Y" || $INST == "y" ]]; then

    # Prep Stage - Bunch of needed items
    echo -e "$CNT - Prep Stage - Installing needed components, this may take a while..."
    for SOFTWR in ${prep_stage[@]}; do
        install_software $SOFTWR
    done

    # Setup Nvidia if it was found
    if [[ "$ISNVIDIA" == true ]]; then
        echo -e "$CNT - Nvidia GPU support setup stage, this may take a while..."
        for SOFTWR in ${nvidia_stage[@]}; do
            install_software $SOFTWR
        done

        # update config
        sudo sed -i 's/MODULES=()/MODULES=(nvidia nvidia_modeset nvidia_uvm nvidia_drm)/' /etc/mkinitcpio.conf
        sudo mkinitcpio --config /etc/mkinitcpio.conf --generate /boot/initramfs-custom.img
        echo -e "options nvidia-drm modeset=1" | sudo tee -a /etc/modprobe.d/nvidia.conf &>> $INSTLOG
    fi

    # Install the correct hyprland version
    echo -e "$CNT - Installing Hyprland, this may take a while..."
    install_software hyprland

    # Stage 1 - main components
    echo -e "$CNT - Installing main components, this may take a while..."
    for SOFTWR in ${install_stage[@]}; do
        install_software $SOFTWR
    done

    # Start the bluetooth service
    echo -e "$CNT - Starting the Bluetooth Service..."
    sudo systemctl enable --now bluetooth.service &>> $INSTLOG
    sleep 2

    # Enable the sddm login manager service
    echo -e "$CNT - Enabling the SDDM Service..."
    sudo systemctl enable sddm &>> $INSTLOG
    sleep 2

    # Clean out other portals
    echo -e "$CNT - Cleaning out conflicting xdg portals..."
    yay -R --noconfirm xdg-desktop-portal-gnome xdg-desktop-portal-gtk &>> $INSTLOG
fi

### Copy Config Files ###
read -rep $'[\e[1;33mACTION\e[0m] - Would you like to copy config files? (y,n) ' CFG
if [[ $CFG == "Y" || $CFG == "y" ]]; then
    echo -e "$CNT - Copying config files..."

    # Setup each appliaction
    # check for existing config folders and backup
    for DIR in eza flameshot hypr kitty mako nvim tmux wallpapers waybar wlogout wofi
    do
        DIRPATH=~/.config/$DIR
        if [ -d "$DIRPATH" ]; then
            echo -e "$CAT - Config for $DIR located, backing up."
            mv $DIRPATH $DIRPATH-back &>> $INSTLOG
            echo -e "$COK - Backed up $DIR to $DIRPATH-back."
        fi
    done
    if [ -e "$HOME/.tmux.conf" ]; then
        echo -e "$CAT - .tmux.conf located, backing up."
        mv ~/.tmux.conf ~/.tmux.conf-back &>> $INSTLOG
        echo -e "$COK - Backed up .tmux.conf to .tmux.conf-back."
    fi
    if [ -e "$HOME/.zshenv" ]; then
        echo -e "$CAT - .zshenv located, backing up."
        mv ~/.zshenv ~/.zshenv-back &>> $INSTLOG
        echo -e "$COK - Backed up .zshenv to .zshenv-back."
    fi

    echo -e "$CNT - Setting up the new config..."

    hyprpm update
    hyprpm add https://github.com/outfoxxed/hy3
    hyprpm enable hy3

    cd "$DOTFILES_DIR" || exit 1
    rm -rf ~/.config/hypr; stow hyprland
    stow eza
    stow flameshot
    stow kitty
    stow mako
    stow nvim
    stow tmux
    stow wallpapers
    stow waybar
    stow wlogout
    stow wofi

    # add the Nvidia env file to the config (if needed)
    if [[ "$ISNVIDIA" == true ]]; then
        echo -e "\nsource = ~/.config/hypr/env_var_nvidia.conf" >> ~/.config/hypr/hyprland.conf
    fi

    # Install the SDDM theme
    echo -e "$CNT - Setting up the login screen."
    cd "$DOTFILES_DIR" || exit 1
    sudo -E env USE_QT5=true bash "$DOTFILES_DIR/scripts/install-sddm-theme.sh"

    # Copy custom theme configuration
    THEME_DIR="/usr/share/sddm/themes/where_is_my_sddm_theme_qt5"
    sudo cp "$DOTFILES_DIR/sddm/theme/theme.conf" "$THEME_DIR/theme.conf"

    # Copy background wallpaper
    sudo cp "$DOTFILES_DIR/wallpapers/.config/wallpapers/mountain.jpg" "$THEME_DIR/"

    # Set theme as current
    sudo mkdir -p /etc/sddm.conf.d
    echo -e "[Theme]\nCurrent=where_is_my_sddm_theme_qt5" | sudo tee -a /etc/sddm.conf.d/10-theme.conf &>> $INSTLOG
    WLDIR=/usr/share/wayland-sessions
    if [ -d "$WLDIR" ]; then
        echo -e "$COK - $WLDIR found"
    else
        echo -e "$CWR - $WLDIR NOT found, creating..."
        sudo mkdir -p $WLDIR
    fi

    # stage the .desktop file
    sudo cp "$DOTFILES_DIR/hyprland/hyprland.desktop" /usr/share/wayland-sessions/

    # setup the first look and feel as dark
    xfconf-query -c xsettings -p /Net/ThemeName -s "Adwaita-dark"
    xfconf-query -c xsettings -p /Net/IconThemeName -s "Papirus-Dark"
    gsettings set org.gnome.desktop.interface gtk-theme "Adwaita-dark"
    gsettings set org.gnome.desktop.interface icon-theme "Papirus-Dark"
    #cp -f ~/.config/HyprV/backgrounds/v4-background-dark.jpg /usr/share/sddm/themes/sdt/wallpaper.jpg
fi

### Configure cedilla input method ###
echo -e "$CNT - Configuring cedilla input method..."
sudo bash "$DOTFILES_DIR/scripts/enable-cedilla.sh"

### Configure zsh shell ###
read -rep $'[\e[1;33mACTION\e[0m] - Set zsh as default shell? (y,n) ' SETZSH
if [[ $SETZSH == "Y" || $SETZSH == "y" ]]; then
    if command -v zsh &> /dev/null; then
        echo -e "$CNT - Setting zsh as default shell (password required)..."
        chsh -s /bin/zsh
    else
        echo -e "$CWR - zsh not installed, skipping."
    fi
fi


### Script is done ###
echo -e "$CNT - Script had completed!"
if [[ "$ISNVIDIA" == true ]]; then
    echo -e "$CAT - Since we attempted to setup an Nvidia GPU the script will now end and you should reboot.
    Please type 'reboot' at the prompt and hit Enter when ready."
    exit
fi

read -rep $'[\e[1;33mACTION\e[0m] - Would you like to start Hyprland now? (y,n) ' HYP
if [[ $HYP == "Y" || $HYP == "y" ]]; then
    exec sudo systemctl start sddm &>> $INSTLOG
else
    exit
fi
