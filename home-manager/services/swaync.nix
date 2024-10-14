{ config, pkgs, ... }:

{
  home.file = {
    ".config/swaync/style.css".source = ../dotfiles/swaync/style.css;
  };

  # Add notification daemon
  services.swaync = { enable = true; };
}
