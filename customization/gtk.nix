{ config, pkgs, ... }:

{
  config = {
    gtk = {
      enable = true;
      colorScheme = "light";
      gtk4.enable = false;

      # theme = {
        # name = "catppuccin-latte-sky-standard";
        # package = pkgs.catppuccin-gtk.override {
        #   accents = [ "sky" ];
        #   size = "standard";
        #   variant = "latte";
        # };
      # };
      iconTheme = {
        name = "Papirus";
        package = pkgs.papirus-icon-theme;
      };
    };

    dconf = {
      enable = true;
      settings = {
        "org/gnome/desktop/interface" = {
          icon-theme = "Papirus";
          gtk-theme = "catppuccin-latte-sky-standard";
          font-name = "Fira Code Retina 10";
          color-scheme = "prefer-light";
        };
      };
    };
  };
}
