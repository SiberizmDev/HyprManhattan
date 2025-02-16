# Dotfiles Install

```
git clone https://github.com/SiberizmDev/HyprManhattan.git
```

```cd HyprManhattan```

install it manually:


Let's start with a backup. To receive using a terminal:

```
cp -r ~/.config ~/.config.bak
cp -r ~/.icons ~/.icons.bak
cp -r ~/.fonts ~/.fonts.bak
cp -r ~/.themes ~/.themes.bak
cp -r ~/.zshrc ~/.zshrc.bak
cp -r ~/.aliases ~/.aliases.bak
```

# Let's Restore Git

```
[Arch Linux]
sudo pacman -S git wget 
```

# First, let's set up a YAY (AUR assistant)
```
cd /opt/

sudo git clone https://aur.archlinux.org/yay-bin

sudo chown -R username:username yay-bin

cd yay-bin

makepkg -si
```

# Required Softwares

Let's install our software:

```
[Arch Linux]
yay -S nm-connection-editor cava viewnior mpd mpc mpv vlc okular libreoffice-fresh hyprland waybar steam swaybg swayidle grimblast sddm brightnessctl geany spicetify-cli playerctl stow hyprlock hyprpicker pamixer rofi-wayland wlogout hyprswitch nwg-dock nwg-drawer wf-recorder btop zsh oh-my-zsh-powerline-theme-git ark unrar zip unzip pavucontrol pavucontrol-qt xdg-desktop-portal-wlr neovim vim nano neofetch mpvpaper dunst thunar kvantum kvantum-qt5 kate appimagelauncher-bin noto-fonts-emoji wl-clipboard xfce4-appfinder wofi catfish zen-browser librewolf-bin kitty polkit-gnome gnome-keyring ntfs-3g cliphist qt5ct qt5 qt6 qt6ct plasma lxappearance proton-vpn-gtk-app tesseract-data-tur tesseract-data-eng tesseract-data-rus jdk-openjdk

[Firefox]
sudo dnf in nm-connection-editor cava viewnior mpd vlc okular libreoffice hyprland waybar steam swaybg swayidle grim sddm brightnessctl geany playerctl stow hyprlock hyprpicker pamixer rofi-wayland wf-recorder btop zsh htop ark unrar zip unzip pavucontrol pavucontrol-qt xdg-desktop-portal-wlr neovim vim neofetch dunst thunar thunar-volman thunar-archive-plugin kvantum kvantum-qt5 kate google-noto-fonts-all wl-clipboard xfce4-appfinder wofi catfish firefox kitty gnome-keyring ntfs-3g qt5ct qt6ct lxappearance
```


# Project Management Softwares

```
[Arch Linux]
yay -S rustup visual-studio-code-bin nodejs npm go python-pip pyhton filezilla github-desktop-bin gitkraken postman-bin apache php php-apache phpmyadmin mariadb meld 
```


# Image Manipultaion Softwares

```
[Arch Linux]
yay -S gimp krita inkscape pitivi kdenlive
```


# For Me

```
[Arch Linux]
yay -S discord zoom galculator ferdium-bin skypeforlinux-bin bitwarden flatpak alacritty spotify qbittorrent obs-studio steam wine ente-auth-bin kdeconnect thunderbird rofimoji localsend-bin
```


# MPD & MPC Config

- Create Required folders and files

```
mkdir -p ~/.config/mpd/{playlists,log}

touch ~/.config/mpd/{database,log/mpd.log,state,sticker.sql}
```

- Edit .config/mpd/mpd.conf

```
music_directory    "~/Music"
playlist_directory "~/.config/mpd/playlists"
db_file           "~/.config/mpd/database"
log_file          "~/.config/mpd/log/mpd.log"
pid_file          "~/.config/mpd/pid"
state_file        "~/.config/mpd/state"
sticker_file      "~/.config/mpd/sticker.sql"

bind_to_address "localhost"

audio_output {
    type  "pipewire"
    name  "PipeWire Sound Server"
}

default_permissions "read,add,control,admin"
```

- And the finishing touches

```
killall mpd

mpd ~/.config/mpd/mpd.conf

mpc update

mpc add /
```

- If Error

```
sudo systemctl stop mpd.socket
sudo systemctl stop mpd.service

sudo lsof -i :6600

mpd ~/.config/mpd/mpd.conf
mpc update

sudo systemctl disable mpd.socket
sudo systemctl disable mpd.service
```

# Install VPN (Especially Recommended for Turkey)

- We have already downloaded Proton VPN when installing programs

- Install Open VPN and some VPN servers

```
sudo pacman -S networkmanager networkmanager-openvpn network-manager-applet openvpn

cd /etc/openvpn
wget http://support.fastestvpn.com/download/fastestvpn_ovpn/ -O fastestvpn_ovpn.zip
```

- Unzip and Copy

```
unzip fastestvpn_ovpn.zip

cp /etc/openvpn/tcp_files/* /etc/openvpn/ && cp /etc/openvpn/udp_files/* /etc/openvpn/
```

# Firefox Installation

- In this step, we just need to install 2 plugins

1- Sidebery
2- Manhattan GTK Dark (Theme)

Then you just need to copy and paste everything in the configDocument folder located in the .mozilla folder (ShyFox built on customized config)

- Finally, you need to type the codes in sidebery.css into the stylesheet section of the Sidebery plugin

# Screenshot Firefox

![SS](Firefox.png)


# Install PHP Server (Completely optional. I wrote for myself)

## HTTPD Edit

```
sudo nvim /etc/httpd/conf/httpd.conf
```

- Paste:

```
LoadModule php_module modules/libphp.so
AddHandler php-script php
Include conf/extra/php_module.conf
Include conf/extra/phpmyadmin.conf
```

- And add Comment:

```
#LoadModule mpm_event_module modules/mod_mpm_event.so
```

- Remove Comment:

```
LoadModule mpm_prefork_module modules/mod_mpm_prefork.so
```

- Create PHPMyAdmin File:

```
sudo nvim /etc/httpd/conf/extra/phpmyadmin.conf
```

- Add Lines:

```
Alias /phpmyadmin "/usr/share/webapps/phpMyAdmin"

<Directory "/usr/share/webapps/phpMyAdmin">
    DirectoryIndex index.php
    AllowOverride All
    Options FollowSymlinks
    Require all granted
</Directory>

<Directory "/etc/webapps/phpMyAdmin">
    Require all granted
</Directory>

```

- Edit php.ini:

```
sudo nvim /etc/php/php.ini
```

- Remove Comment:

```
extension=mysqli
```

## Install MariaDB

```
sudo systemctl start httpd
sudo systemctl enable httpd
sudo chown -R mysql:mysql /var/lib/mysql
sudo mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql
sudo systemctl start mariadb
sudo systemctl enable mariadb
sudo mysql_secure_installation
```

## Permission

```
sudo chmod -R 777 /srv
```


# Optional Softwares

```
[All Distros]
flatpak install stremio flatseal obsproject atom
```

# Change Flatpak Apps Theme

```
sudo flatpak override --filesystem=$HOME/.themes
sudo flatpak override --filesystem=$HOME/.icons
sudo flatpak override --env=GTK_THEME=Manhattan
sudo flatpak override --env=ICON_THEME=Tela
```

```
# Change Shell

```
sudo chsh -s $(which zsh)
chsh -s $(which zsh)
```

# Screenshot Desktop

![SS](SS.png)

# Screenshot Spotify

![SS](Spotify.png)
