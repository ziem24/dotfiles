#!/bin/sh

OLDPWD=$(pwd)
cd $(dirname $0)

mkdir -p ~/Videos/OBS

alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

echo "Installing necessary packages..."
sudo pacman -Syu dolphin gwenview btop fastfetch kitty git python unzip || exit 1

echo "Installing themes..."
rm -rf master*.zip Breeze-Chameleon-Icons* Nordic-kde*

wget https://github.com/L4ki/Breeze-Chameleon-Icons/archive/refs/heads/master.zip || exit 2
unzip -q master.zip
mkdir -p ~/.local/share/icons/
mv 'Breeze-Chameleon-Icons-master/Breeze Chameleon Dark' ~/.local/share/icons/
rm -rf master.zip Breeze-Chameleon-Icons-master

wget https://github.com/EliverLara/Nordic-kde/archive/refs/heads/master.zip || exit 3
unzip -q master.zip
mkdir -p ~/.local/share/plasma/desktoptheme/
mv Nordic-kde-master ~/.local/share/plasma/desktoptheme/Nordic
rm -rf master.zip

cd
config checkout 2>.dotfiles/tmp
cat .dotfiles/tmp | grep -v "$(cat .dotfiles/tmp | head -1)" | grep -v "$(cat .dotfiles/tmp | tail -2)" | xargs rm
rm .dotfiles/tmp
config checkout

cd "$OLDPWD"
