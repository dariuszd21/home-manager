{ config, pkgs, ... }:

{
  # Add bat with Cattpuccin theme and extras
  home.file = { ".config/bat/themes".source = ../dotfiles/bat/themes; };
  programs.bat = {
    enable = true;
    config = { theme = "Catppuccin Macchiato"; };
    extraPackages = with pkgs.bat-extras; [
      batdiff
      batman
      batgrep
      batpipe
      batwatch
    ];
  };

}
