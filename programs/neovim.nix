{ config, pkgs, ... }:

{

  # Enable neovim
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    withPython3 = false;
    withRuby = false;
    extraPackages = with pkgs; [ tree-sitter ];
  };

}

