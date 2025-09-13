# Arch Linux - Hyprland (Dotfiles)

💻 Info

- **Distro** - [Arch Linux](https://archlinux.org/)
- **WM** - [Hyprland](https://hyprland.org/)

## 🖼️ Screenshots

![01](/screenshot/1.png)
![02](/screenshot/2.png)
![03](/screenshot/3.png)

## 📦 Basic Installation Guide

Install Omarchy 2.0 iso.

- ⬇️ [Download Omarchy](https://omarchy.org/)
- 📜 [Omarchy Installation Guide](https://learn.omacom.io/2/the-omarchy-manual)

## 💻 Post Installation

Install [ZSH Human](https://github.com/romkatv/zsh4humans) (Optional)

```bash
if command -v curl >/dev/null 2>&1; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/romkatv/zsh4humans/v5/install)"
else
  sh -c "$(wget -O- https://raw.githubusercontent.com/romkatv/zsh4humans/v5/install)"
fi
```

1. Clone this repository

```bas
git clone https://github.com/u1145h/dotfiles
```

2. Copy all the file and folder
```bash
cd dotfiles/home/
\cp -rf ~/Documents/git/dotfiles/home/. ~/

```

Install Important Packages

```bash
sudo pacman -S udiskie pavucontrol kdeconnect cliphist grim slurp spotify-launcher imv zathura zathura-pdf-poppler obsidian rclone syncthing gimp krita inkscape blender kdenlive htop ranger gvfs-mtp mtpfs zathura-pdf-poppler ddcutil i2c-tools

```

```bash
yay -S rofi-wayland swww cava power-profiles-daemon rog-control-center jmtpfs tty-clock spicetify-cli vencord zapzap flatseal waypaper nwg-look wttrbar
```

and, reboot

```bash
reboot
```

#### Apply Spotify Theme

```bash
spicetify backup apply
spicetify config current_theme text
spicetify apply
```

#### Setup Razer Driver

This installs Polymatic GUI App to configure Razer hardware. Linux Headers must be installed in order to work properly

```bash
yay -S polychromatic
sudo gpasswd -a $USER plugdev
sudo pacman -S openrazer-daemon
sudo modprobe razerkbd
```

---
## 🖥️ Control External Monitor Brightness

Install Packages

```bash
sudo modprobe ddcutil i2c-dev
```

Load Kernal Modules
```bash
sudo modprobe i2c-dev
```
Make them load at boot,
```bash
echo i2c-dev | sudo tee /etc/modules-load.d/i2c-dev.conf
```

Give Permission
```bash
sudo gpasswd -a $USER i2c
newgrp i2c
```

---
## 💻 Add Laptop Lid function for Hyprland

I have created a proper guide to setup Laptop Lid function properly.
- [Setup Guide and Script](https://github.com/u1145h/hyprland-laptop-lid-configuration-script)

###### Hyprland Keybinding for turn On/Off laptop display
```bash
bind = $mainMod SHIFT, L, exec, /usr/local/bin/lid-handler.sh
bind = $mainMod SHIFT, D, exec, hyprctl keyword monitor "eDP-1,disable"
bind = $mainMod SHIFT, E, exec, hyprctl keyword monitor "eDP-1,1920x1080@144,0x0,1.25"
```

#### How it functions?

###### 🔌 Plug in your charger
- Close the lid → Display should turn off
- Open the lid → Display should turn back on at 144Hz

###### 🔋 Unplug your charger
- Close the lid → System should suspend
- Open the lid → System should wake u

## Setup XAMPP
Insall XAMPP
```bash
yay -S xampp
```

Give read and write permission to htdocs directory - `/opt/lampp/htdocs`
```bash
sudo chmod -R 777 /opt/lampp/htdocs
```