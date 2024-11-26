{ config, pkgs, ... }:

{

  # Enable neovim
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    extraPackages = with pkgs; [ tree-sitter ];
  };

}

