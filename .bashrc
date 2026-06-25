# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

export PYTHONSTARTUP="$HOME/.config/python/pythonrc"
export LESSHISTFILE="$HOME/.local/state/lesshst"
export GNUPGHOME="$HOME/.local/share/gnupg"
export DOTNET_CLI_HOME="$HOME/.local/share/dotnet"

# User specific aliases and functions
alias l="ls"
alias la="ls -a"
alias ll="ls -alh"
alias aphexfetch='fastfetch -c ~/.config/fastfetch/presets/afx.jsonc'
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

if [ -d ~/.bashrc.d ]; then
    for rc in ~/.bashrc.d/*; do
        if [ -f "$rc" ]; then
            . "$rc"
        fi
    done
fi
unset rc
