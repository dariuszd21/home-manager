{
  nixpkgs,
  config,
  pkgs,
  lib,
  ...
}:

{
  nixpkgs.config.allowUnfreePredicate =
    pkg:
    builtins.elem (lib.getName pkg) [
      "copilot-language-server"
    ];
  home.packages = with pkgs; [
    nodePackages.nodejs
    copilot-language-server
  ];
}
