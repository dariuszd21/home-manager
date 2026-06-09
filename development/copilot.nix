{
  nixpkgs,
  config,
  pkgs,
  lib,
  ...
}:

{
  home.packages = with pkgs; [
    nodejs-slim
    copilot-language-server
  ];
}
