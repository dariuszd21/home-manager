{ config, pkgs, ... }:

{
  # Add fzf (fuzzy finder) 
  programs.fzf = {
    enable = true;
    colors = {
      "spinner" = "#f4dbd6";
      hl = "#ed8796";
      fg = "#cad3f5";
      header = "#ed8796";
      info = "#c6a0f6";
      pointer = "#f4dbd6";
      marker = "#f4dbd6";
      "fg+" = "#cad3f5";
      prompt = "#c6a0f6";
      "hl+" = "#ed8798";
    };
  };
}
