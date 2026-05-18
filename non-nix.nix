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

  imports = [
    ./gpu/nixgl.nix
  ];

  # make Home Manager work better on GNU/Linux distributions other than NixOS.
  targets.genericLinux.enable = true;
}
