{ config, pkgs, ... }:

{
  # Enable Network Manager applet
  services.network-manager-applet = {
    enable = true;
  };
}
