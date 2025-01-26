{ config, pkgs, catppuccin, ... }:
{
  catppuccin = {
    enable = true;
    flavor = "macchiato";

    gtk.enable = true;
    # Disable conflicting configs
    waybar.enable = false;
    fzf.enable = false;
    sway.enable = false;
  };
}

