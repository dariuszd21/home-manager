## Installation

### Dependencies

```shell
sudo apt install neofetch # already installed in minimal version
sudo apt install stow
sudo apt install build-essential # C++ compiler needed for neovim
# https://github.com/dariuszd21/home-manager/issues/5
sudo apt install swaylock # until `pam.so` issue will be resolved
```

### Symlink configuration of `nix` and `home-manager` to `~/.config`

> This enables `flake` support for Nix and prepares `home-manager`
> for further installation.

```shell
stow -t ~/.config .
```
### __*Optional*__ add a separate BTRFS subvolume for `Nix` store

```shell
# mount root btrfs filesystem
sudo mount /dev/mapper/luks-<your-decrypted-volume-id> /tmp/root/
# create top-level subvolume for nixpkgs
sudo btrfs subvolume create /tmp/root/@nix
sudo mkdir /nix
# edit /etc/fstab and add /@nix subvolume mount entry
# add `ssd` options for better performance on flash drives
#  btrfs  subvol=/@nix,space_cache=v2,compress=zstd:1,discard=async,ssd,noatime,autodefrag 0 0
```

### Installing Nix

```shell
sh <(curl -L https://nixos.org/nix/install) --daemon
```

### Installing `home-manager` using existing configuration with flake support

```shell
nix run home-manager/master -- switch
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
