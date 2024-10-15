{ config, pkgs, ... }:

{
  home.file = { ".local/share/avizo".source = ../dotfiles/avizo/data; };
  # avizo - lightweight notification daemon
  services.avizo = {
    enable = true;
    settings = {
      default = {
        image-base-dir = "~/.local/share/avizo/images";
        background = "rgba(36, 39, 58, 1)";
        border-color = "rgba(110, 115, 141, 1)";
        bar-fg-color = "rgba(202, 211, 245, 1)";
      };
    };
  };
}
