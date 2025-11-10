{ config, pkgs, ... }:

{
  # config.gtk.catppuccin = {
  #   accent = "flamingo";
  #   flavor = "macchiato";
  # };

  config.gtk = {
    enable = true;
    colorScheme = "light";

    theme = {
      name = "catppuccin-latte-sky-standard";
      package = pkgs.catppuccin-gtk.override {
        accents = [ "sky" ];
        size = "standard";
        variant = "latte";
      };
    };
  };
}
