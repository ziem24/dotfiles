#!/bin/sh

CONFLICTS='/tmp/dotfiles_conflict.txt'

YAY_PATH='/tmp/yay'
THEME_PATH='/tmp/Nordic-kde'
ICON_PATH='/tmp/Breeze-Chameleon-Icons'
GRUB_THEME_PATH='/tmp/MilkGrub'

rm -rf "$YAY_PATH" "$THEME_PATH" "$ICON_PATH" "$GRUB_THEME_PATH"

# prerequisites
if [ "$(id -u)" = 0 ]
then
    echo "You are a root user!!!"
    exit 101
fi

if ! ping -c 1 ping.archlinux.org
then
    echo "Get internet loser!!! How the heck did you even clone this repo anyways???"
    exit 102
fi

if ! sudo echo "Waow you really do have sudo!!!"
then
    echo "Get sudo privileges NOW!!!" >&2
    exit 103
fi

echo "Creating necessary directories..."
mkdir -p "$HOME/Videos/OBS/"
mkdir -p "$HOME/.local/share/icons/"
mkdir -p "$HOME/.local/share/plasma/desktoptheme/"

echo "Enabling multilib repository (needed for Steam)..."
sudo sed -i '/^#\[multilib\]/,/^#Include/ s/^#//' /etc/pacman.conf

echo "Installing necessary packages..."
sudo pacman -Syyu --needed base-devel dolphin git kitty networkmanager plasma-desktop plasma-login-manager polkit-kde-agent wget || exit 2

echo "Enabling NetworkManager and plasmalogin..."
sudo systemctl enable --now NetworkManager.service
sudo systemctl enable plasmalogin.service

if which yay
then
    echo "yay is already installed. Yay."
else
    echo "Building yay..."
    git clone --depth=1 https://aur.archlinux.org/yay.git "$YAY_PATH"
    OLDPWD=$(pwd)
    cd "$YAY_PATH"
    makepkg -si
fi

echo "Installing a GRUB theme (gemakfy/MilkGrub)..."
git clone https://github.com/ziem24/MilkGrub.git "$GRUB_THEME_PATH" || exit 5
cd "$GRUB_THEME_PATH"
git checkout fedora-support
sudo ./install.sh # nasty bashisms oughhhh

cd "$OLDPWD"

echo "Installing KDE themes..."
git clone --depth=1 https://github.com/L4ki/Breeze-Chameleon-Icons.git "$ICON_PATH" || exit 3
mv "$ICON_PATH/Breeze Chameleon Dark" "$HOME/.local/share/icons/"
git clone --depth=1 https://github.com/EliverLara/Nordic-kde.git "$THEME_PATH" || exit 4
mv "$THEME_PATH" "$HOME/.local/share/plasma/desktoptheme/Nordic"

rm -rf "$YAY_PATH" "$ICON_PATH" "$GRUB_THEME_PATH"

echo "Checking out the repository branch..."
rm -f "$CONFLICTS"
git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME checkout 2>"$CONFLICTS"
if [ -s "$CONFLICTS" ]
then
    cat "$CONFLICTS" | while read -r line
    do
        TARGET="$HOME/$line"
        if [ -f "$TARGET" ] || [ -L "$TARGET" ]
        then
            rm -f "$TARGET"
        fi
    done
fi
git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME checkout
rm -f "$CONFLICTS"

echo '
=================
Done. Here are some things you might want to do:
    - sudo pacman -S --needed $(cat ~/Documents/pacman_installs.txt)  # installs a lot of pacman packages
    - yay -S $(cat ~/Documents/aur_installs.txt)  # installs a couple of AUR packages
    - sudo systemctl start plasmalogin.service  # starts the KDE Plasma login manager (RedHat SystemD GCC Virus Technology)
================='
