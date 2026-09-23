#!/bin/sh

CONFLICTS='/tmp/dotfiles_conflict.txt'

[ whoami != root ] || echo "You are a root user!!!" && exit 101
ping -c1 ping.archlinux.org || echo "Get internet loser!!!" && exit 102
sudo echo "Waow you really do have sudo!!!" || echo "Get sudo privillegesNOW !!!" && exit 103

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

echo "Building yay..."
git clone --depth=1 https://aur.archlinux.org/yay.git /tmp/yay
OLDPWD=$(pwd)
cd /tmp/yay
makepkg -si

echo "Installing a GRUB theme (gemakfy/MilkGrub)..."
git clone --depth=1 https://github.com/ziem24/MilkGrub.git /tmp/MilkGrub || exit 5
cd /tmp/MilkGrub
git checkout fedora-support
sudo bash install.sh # nasty bashisms oughhhh

cd "$OLDPWD"

echo "Installing KDE themes..."
git clone --depth=1 https://github.com/L4ki/Breeze-Chameleon-Icons.git /tmp/Breeze-Chameleon-Icons || exit 3
mv '/tmp/Breeze-Chameleon-Icons/Breeze Chameleon Dark' ~/.local/share/icons/
git clone --depth=1 https://github.com/EliverLara/Nordic-kde.git /tmp/Nordic-kde || exit 4
mv /tmp/Nordic-kde ~/.local/share/plasma/desktoptheme/Nordic

rm -rf /tmp/yay /tmp/Breeze-Chameleon-Icons /tmp/MilkGrub

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
