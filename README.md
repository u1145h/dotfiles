# Arch Linux - Hyprland (Dotfiles)
💻 Info
- **Distro** - [Arch Linux](https://archlinux.org/)
- **WM** - [Hyprland](https://hyprland.org/)

### 🖼️ Screenshots
![01](/screenshot/1.png)
![02](/screenshot/2.png)
![03](/screenshot/3.png)

## 📦 Basic Installation Guide
##### Additional Packages
Basic additional packages while installing Arch Linux with `archinstall` script. This will add all the home directory's, install important packages and install nvidia drivers.
```bash
git wget curl less go neovim xdg-user-dirs xdg-user-dirs-gtk linux-headers nvidia nvidia-settings nvidia-utils egl-wayland
```
`install yay` [Aur Repo](https://aur.archlinux.org/packages/yay)

##### Post Installation
Install basic nvidia driver with wayland support
```bash
yay -S linux-headers nvidia-dkms qt5-wayland qt5ct libva libva-nvidia-driver-git
```
edit and add module in - `/etc/mkinitcpio.conf`
```bash
MODULES=(nvidia nvidia_modeset nvidia_uvm nvidia_drm)
```

MODULES=(nvidia nvidia_modeset nvidia_uvm nvidia_drm)
```bash
sudo mkinitcpio --config /etc/mkinitcpio.conf --generate /boot/initramfs-custom.img
```
Create NVIDIA Configuration
```bash
echo "options nvidia-drm modeset=1" | sudo tee /etc/modprobe.d/nvidia.conf
```
verify
```bash
cat /etc/modprobe.d/nvidia.conf
```
reboot
```bash
reboot
```

Create and Edit `/etc/modprobe.d/nvidia.conf`. Add this line to the file,
```bash
options nvidia_drm modeset=1 fbdev=1
```
rebuild
```bash
sudo mkinitcpio -P
```


##### Install [ZSH Human](https://github.com/romkatv/zsh4humans) (Optional)
```bash
if command -v curl >/dev/null 2>&1; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/romkatv/zsh4humans/v5/install)"
else
  sh -c "$(wget -O- https://raw.githubusercontent.com/romkatv/zsh4humans/v5/install)"
fi
```

##### Install basic dependencies
```bash
sudo pacman -S hyprpaper hypridle hyprlock waybar hyprpicker udiskie pavucontrol brightnessctl kdeconnect cliphist grim timeshift slurp
```

```bash
yay -S wlogout hyprpicker rofi-wayland swww
```

##### Apply Wallpaper
```bash
swww img ~/.config/wallpaper/desktop/monitor_03.png --outputs HDMI-A-1 && swww img ~/.config/wallpaper/desktop/monitor_02.png --outputs DP-1 && swww img ~/.config/wallpaper/desktop/monitor_01.png --outputs eDP-1
```

##### Install important Packages
```bash
sudo pacman -S spotify-launcher imv zathura zathura-pdf-poppler obsidian rclone syncthing gimp krita inkscape blender kdenlive htop ranger gvfs-mtp mtpfs zathura-pdf-poppler
```
```bash
yay -S vencord zapzap flatseal bottom cava power-profiles-daemon rog-control-center jmtpfs tty-clock spicetify-cli neofetch
```
```bash
reboot
```

##### Enable Bluetooth Support
```bash
sudo pacman -S bluez blueman bluez-utils
sudo modprobe btusb
sudo systemctl enable bluetooth
```


##### Apply Spotify Theme
```bash
spicetify backup apply
spicetify config current_theme text
spicetify apply
```
