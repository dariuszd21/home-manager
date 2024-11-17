{ config, pkgs, ... }:

{
  # Enable Fuzzel - application launcher for SwayWM
  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        terminal = "${pkgs.alacritty}/bin/alacritty";
        layer = "top";
        show-actions = "yes";
      };
      colors = {
        background = "24273add";
        text = "cad3f5ff";
        prompt = "b8c0e0ff";
        placeholder = "8087a2ff";
        input = "cad3f5ff";
        match = "b7bdf8ff";
        selection = "5b6078ff";
        selection-text = "cad3f5ff";
        selection-match = "b7bdf8ff";
        counter = "8087a2ff";
        border = "b7bdf8ff";
      };
    };
  };
}
