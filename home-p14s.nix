{
  config,
  lib,
  pkgs,
  ...
}:

{
  home.file = {
    ".config/sway/config.d/outputs".source = ./p14s/outputs;
  };

  imports = [
    ./home.nix
  ];
}
