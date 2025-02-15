{ config, pkgs, lib, ... }:

{
  # alacritty integration
  programs.alacritty = {
    enable = true;
    package = config.lib.nixGL.wrap pkgs.alacritty;
    settings = {
      general = { live_config_reload = true; };
      colors = {
        bright = {
          black = "#4c566a";
          blue = "#81a1c1";
          cyan = "#8fbcbb";
          green = "#8fbcbb";
          magenta = "#d2b8ed";
          red = "#bf616a";
          white = "#d8dee9";
          yellow = "#fbdf90";
        };

        cursor = {
          cursor = "#d8dee9";
          text = "#2e3440";
        };

        dim = {
          black = "#373e4d";
          blue = "#68809a";
          cyan = "#6d96a5";
          green = "#809575";
          magenta = "#8c738c";
          red = "#94545d";
          white = "#aeb3bb";
          yellow = "#b29e75";
        };

        footer_bar = {
          background = "#434c5e";
          foreground = "#d8dee9";
        };
        normal = {
          black = "#434c5e";
          blue = "#81a1c1";
          cyan = "#88c0d0";
          green = "#98c379";
          magenta = "#b48ead";
          red = "#f9929b";
          white = "#d8dee9";
          yellow = "#ebcb8b";
        };

        primary = {
          background = "#282c34";
          dim_foreground = "#282c34";
          foreground = "#d8dee9";
        };

        search.matches = {
          background = "#88c0d0";
          foreground = "CellBackground";
        };

        selection = {
          background = "#4c566a";
          text = "CellForeground";
        };

        vi_mode_cursor = {
          cursor = "#d8dee9";
          text = "#2e3440";
        };

      };
      font = {
        size = 10;
        normal = {
          family = "FiraCode Nerd Font";
          style = "Retina";
        };
      };
      terminal = { shell = { program = "${pkgs.zsh}/bin/zsh"; }; };
      window = {
        opacity = 0.9;
        padding = {
          x = 20;
          y = 20;
        };
      };
    };
  };
}
