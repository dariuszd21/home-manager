{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./gpu/nixgl.nix
  ];

  # make Home Manager work better on GNU/Linux distributions other than NixOS.
  targets.genericLinux.enable = true;
}
