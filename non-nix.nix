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
}
