# Dotfiles thing for KDE systems

### Before adding and cloning stuff:
```sh
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME
```

### How to add things:
```sh
config add <thing...>
config commit -a # -a to update tracked files
```

### How to get the changes:
```
git clone --bare git@github.com:ziem24/dotfiles.git $HOME/.dotfiles
config checkout
```

### Current tree (24.06.2026):
```sh
.
├── .bashrc
├── .config
│   ├── btop
│   │   └── btop.conf
│   ├── dolphinrc
│   ├── fastfetch
│   │   ├── config.jsonc
│   │   ├── images
│   │   │   └── afx.txt
│   │   └── presets
│   │       └── afx.jsonc
│   ├── fontconfig
│   │   └── fonts.conf
│   ├── git
│   │   └── gitk
│   ├── gwenviewrc
│   ├── kcminputrc
│   ├── KDE
│   │   └── UserFeedback.conf
│   ├── kdedefaults
│   │   ├── kcminputrc
│   │   ├── kdeglobals
│   │   ├── ksplashrc
│   │   ├── kwinrc
│   │   ├── package
│   │   └── plasmarc
│   ├── kdeglobals
│   ├── kglobalshortcutsrc
│   ├── kitty
│   │   ├── current-theme.conf
│   │   └── kitty.conf
│   ├── krunnerrc
│   ├── ksplashrc
│   ├── ktimezonedrc
│   ├── kwinrc
│   ├── mimeapps.list
│   ├── partitionmanagerrc
│   ├── plasma-localerc
│   ├── plasmanotifyrc
│   ├── plasma-org.kde.plasma.desktop-appletsrc
│   ├── plasmarc
│   ├── powerdevilrc
│   ├── powermanagementprofilesrc
│   ├── python
│   │   └── pythonrc
│   └── xsettingsd
│       └── xsettingsd.conf
├── .gitconfig
├── .gtkrc-2.0
├── Pictures
│   └── Wallpapers
│       ├── Desktop.png
│       └── Loginscreen.png
└── README.md

15 directories, 40 files
```