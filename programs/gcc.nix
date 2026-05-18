{
  config,
  pkgs,
  lib,
  ...
}:

{
  programs.gcc = {
    enable = true;
  };
}
