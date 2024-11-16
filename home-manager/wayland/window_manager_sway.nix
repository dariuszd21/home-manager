{ config, pkgs, lib, ... }:

{
  # sway integration
  wayland.windowManager.sway = {
    enable = true;
    package = config.lib.nixGL.wrap pkgs.sway;

    swaynag = { enable = true; };
  };
}
