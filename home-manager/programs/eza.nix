{ config, pkgs, ... }:

{
  # Add eza (ls replacement)
  programs.eza = {
    enable = true;
    git = true;
    icons = "auto";
    extraOptions = [ "--group-directories-first" "--header" ];
  };
}
