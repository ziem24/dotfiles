#!/bin/sh

OLDPWD=$(pwd)
CONFLICTS='/tmp/dotfiles_conflict.txt'

echo "Creating necessary directories..."
mkdir -p "$HOME/Videos/OBS/"
mkdir -p "$HOME/.local/share/icons/"
mkdir -p "$HOME/.local/share/plasma/desktoptheme/"

echo "Enabling multilib repository (needed for Steam)..."
sudo sed -i '/^#\[multilib-testing\]/,/^#Include/ s/^#//' /etc/pacman.conf

echo "Installing necessary packages..."
sudo pacman -Syyu --needed btop dolphin fastfetch git gwenview kitty networkmanager plasma-login-manager wget || exit 1

echo "Enabling services..."
sudo systemctl enable --now NetworkManager.service
sudo systemctl enable --now plasmalogin.service

echo "Building yay..."
git clone --depth=1 https://aur.archlinux.org/yay.git /tmp/yay
cd /tmp/yay
makepkg -si
cd "$(dirname "$0")"

echo "Installing themes..."
git clone --depth=1 https://github.com/L4ki/Breeze-Chameleon-Icons.git /tmp/Breeze-Chameleon-Icons || exit 2
mv '/tmp/Breeze-Chameleon-Icons/Breeze Chameleon Dark' ~/.local/share/icons/
git clone --depth=1 https://github.com/EliverLara/Nordic-kde.git /tmp/Nordic-kde || exit 3
mv /tmp/Nordic-kde ~/.local/share/plasma/desktoptheme/Nordic

rm -rf /tmp/yay /tmp/Breeze-Chameleon-Icons

echo "Installing a GRUB theme..."
echo "JUST KIDDING!!!!!! I don't want to do it yet." # TODO

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

cd "$OLDPWD"

echo "Done"
