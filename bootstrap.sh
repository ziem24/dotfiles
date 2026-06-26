#!/bin/sh

OLDPWD=$(pwd)
cd $(dirname $0)

mkdir -p ~/Videos/OBS
mkdir -p ~/.local/share/icons/
mkdir -p ~/.local/share/plasma/desktoptheme/

CONFIG="/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"

echo "Installing necessary packages..."
sudo pacman -Syu dolphin gwenview btop fastfetch kitty python unzip wget || exit 1

echo "Installing themes..."

git clone --depth=1 https://github.com/L4ki/Breeze-Chameleon-Icons.git /tmp/Breeze-Chameleon-Icons || exit 2
mv '/tmp/Breeze-Chameleon-Icons/Breeze Chameleon Dark' ~/.local/share/icons/
rm -rf /tmp/Breeze-Chameleon-Icons

git clone --depth=1 https://github.com/EliverLara/Nordic-kde.git /tmp/Nordic-kde || exit 3
mv /tmp/Nordic-kde ~/.local/share/plasma/desktoptheme/Nordic
rm -rf /tmp/

if [ -s "$HOME/.dotfiles/tmp" ]
then
    cat "$HOME/.dotfiles/tmp" | grep -v "$(cat "$HOME/.dotfiles/tmp" | head -1)" | grep -v "$(cat "$HOME/.dotfiles/tmp" | tail -2)" | xargs rm -f
fi
rm -f "$HOME/.dotfiles/tmp"

"$CONFIG" checkout

cd "$OLDPWD"
