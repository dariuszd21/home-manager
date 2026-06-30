{
  config,
  pkgs,
  lib,
  ...
}:

{
  # vscode integration
  programs.vscode = {
    enable = true;

    # TODO: replace with profile once a profile is established
    # https://nix-community.github.io/home-manager/options.xhtml#opt-programs.vscode.profiles
    mutableExtensionsDir = true;
  };
}
