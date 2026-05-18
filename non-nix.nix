{
  config,
  lib,
  pkgs,
  ...
}:

{

  home.file = {
    ".config/sway/config.d/outputs".source = ./dotfiles/sway_output/outputs;
  };

  # make Home Manager work better on GNU/Linux distributions other than NixOS.
  targets.genericLinux.enable = true;
}
