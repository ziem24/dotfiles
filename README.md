# Dotfiles thing for Arch Linux KDE systems

### Prerequisites:
- A non-root user
- Internet connection
- Packages `git` and `sudo`

### How to get the changes:
```sh
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
git clone --bare https://github.com/ziem24/dotfiles.git $HOME/.dotfiles
config checkout
./bootstrap.sh
```

### How to add things:
```sh
config add <thing...>
config commit -a # -a to update tracked files
```

### Useful commands:
```sh
config config --local status.showUntrackedFiles no
```

### Notes:
- The alias 'config' is also added in .bashrc, so you won't need to set it afterwards
- The icon theme is kinda broken when installing from github raw, so it might need a reinstallation from the system settings gui. My ass cannot be bothered to fix it

### Fun things to try out:
- Type 'aphexfetch' in the (very awesome and riced up kitty) terminal
- Be productive
