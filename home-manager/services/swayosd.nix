{ config, pkgs, ... }:

{
  # SwayOSD - lightweight notification daemon
  services.swayosd = {
    enable = true;
    stylePath = "${config.home.homeDirectory}/.config/swayosd/style.css";
  };
}
