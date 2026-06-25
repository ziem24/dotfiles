# Dotfiles thing for KDE systems

### How to get the changes:
```sh
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
git clone --bare git@github.com:ziem24/dotfiles.git $HOME/.dotfiles
.dotfiles/bootstrap.sh
```
Note: the alias is also added in .bashrc, so you won't need to run this after cloning

### How to add things:
```sh
config add <thing...>
config commit -a # -a to update tracked files
```

### Fun things to try out
- Type 'aphexfetch' in the terminal
- Be productive
