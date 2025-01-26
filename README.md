## Installation

### Dependencies

```shell
sudo apt install neofetch # already installed in minimal version
sudo apt install stow
sudo apt install build-essential # C++ compiler needed for neovim
# https://github.com/dariuszd21/home-manager/issues/5
sudo apt install swaylock # until `pam.so` issue will be resolved
sudo apt install xdg-desktop-portal-wlr # for screensharing on Kubuntu 24.04 LTS
```

### Symlink configuration of `nix` and `home-manager` to `~/.config`

> This enables `flake` support for Nix and prepares `home-manager`
> for further installation.

```shell
stow -t ~/.config .
```
### __*Optional*__ add a separate BTRFS subvolume for `Nix` store

> Important, if you have a separate /nix partition you need x-initrd.mount
> option in your fstab

```shell
# mount root btrfs filesystem
sudo mount /dev/mapper/luks-<your-decrypted-volume-id> /tmp/root/
# create top-level subvolume for nixpkgs
sudo btrfs subvolume create /tmp/root/@nix
sudo mkdir /nix
# edit /etc/fstab and add /@nix subvolume mount entry
# add `ssd` options for better performance on flash drives
#  btrfs  subvol=/@nix,space_cache=v2,compress=zstd:1,discard=async,ssd,noatime,autodefrag,x-initrd.mount 0 0
```

### Installing Nix

```shell
sh <(curl -L https://nixos.org/nix/install) --daemon
```

### Installing `home-manager` using existing configuration with flake support

```shell
nix run home-manager/master -- switch --flake '.?submodules=1'
```

> If there are any conflicts with existing files you may need to rename them before installing
> `home-manager`.

### Reboot & enjoy

> In case of `nix-daemon.service` not working you may to manually enable it by typing

```shell
sudo systemctl enable --now nix-daemon.service
```

## Tips & Tricks

### Create desktop entry for Sway

> Place it under /usr/share/wayland-sessions/sway-nix.desktop
> to avoid collision with system Sway (if installed or may be installed)

```conf
[Desktop Entry]
Name=Sway (Nix)
Comment=An i3-compatible Wayland compositor
Exec=sway
Type=Application
```

### Disable nixbld users from `SDDM`

> Add /etc/sddm.conf.d/uid.conf with the following configuration

```conf
[Users]
HideShells=/usr/bin/nologin,/sbin/nologin,/bin/false,/usr/bin/git-shell
```

## Housekeeping

### Updating packages state

> It has to be run in `~/.config/home-manager` directory

```shell
nix flake update
```

### Updating home-manager configuration

```shell
home-manager switch
```

### Garbage collect old packages

```shell
nix store gc
```

## Features

- Allowing private counterpart to be conditionally included (I use it to
 handle my personal and work `git` configuration)

## Disclaimers

Tested and used on Kubuntu 24.04 LTS
