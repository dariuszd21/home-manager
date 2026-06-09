{
  config,
  pkgs,
  lib,
  ...
}:

{
  home.file.".vscode/argv.json".text = ''
    {
      // Fixes the "an OS keyring couldn't be identified for
      // storing the encryption..." error
      "password-store": "gnome-libsecret"
    }
  '';

  # vscode integration
  programs.vscode = {
    enable = true;

    # TODO: replace with profile once a profile is established
    # https://nix-community.github.io/home-manager/options.xhtml#opt-programs.vscode.profiles
    mutableExtensionsDir = true;
  };
}
