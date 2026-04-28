{ config, pkgs, ... }:

{
  home.file = {
    ".config/swayosd/style.css".source = ../dotfiles/swayosd/style.css;
  };
  # SwayOSD - lightweight notification daemon
  services.swayosd = {
    enable = true;
    stylePath = "${config.home.homeDirectory}/.config/swayosd/style.css";
  };
}
