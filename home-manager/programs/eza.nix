{ config, pkgs, ... }:

{
  # Add eza (ls replacement)
  programs.eza = {
    enable = true;
    git = true;
    icons = true;
    extraOptions = [ "--group-directories-first" "--header" ];
  };
}
