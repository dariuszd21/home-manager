{ config, pkgs, lib, ... }:

{
  home.file = {
    ".config/sway".source = ../dotfiles/sway;
    ".local/share/backgrounds/Toronto.jpg".source =
      ../assets/backgrounds/Toronto.jpg;
  };

  # sway integration
  wayland.windowManager.sway = {
    enable = true;
    package = config.lib.nixGL.wrap pkgs.sway;

    swaynag = { enable = true; };
  };

  home.packages = with pkgs; [
    # Wayland native snapshot editing tool
    grim
    swappy
    slurp
    wl-clipboard
  ];

  # Swaylock may be problematic due to pam configuration
  # see https://github.com/hyprwm/hyprlock/issues/333
  programs.swaylock = {
    enable = true;
    # Due to the collision with system libpam.so
    # we're putting here dummy package here just to satisfy installer
    package = pkgs.hello;
    settings = {
      color = "24273a";
      bs-hl-color = "f4dbd6";
      caps-lock-bs-hl-color = "f4dbd6";
      caps-lock-key-hl-color = "a6da95";
      inside-color = "00000000";
      inside-clear-color = "00000000";
      inside-caps-lock-color = "00000000";
      inside-ver-color = "00000000";
      inside-wrong-color = "00000000";
      key-hl-color = "a6da95";
      layout-bg-color = "00000000";
      layout-border-color = "00000000";
      layout-text-color = "cad3f5";
      line-color = "00000000";
      line-clear-color = "00000000";
      line-caps-lock-color = "00000000";
      line-ver-color = "00000000";
      line-wrong-color = "00000000";
      ring-color = "b7bdf8";
      ring-clear-color = "f4dbd6";
      ring-caps-lock-color = "f5a97f";
      ring-ver-color = "8aadf4";
      ring-wrong-color = "ee99a0";
      separator-color = "00000000";
      text-color = "cad3f5";
      text-clear-color = "f4dbd6";
      text-caps-lock-color = "f5a97f";
      text-ver-color = "8aadf4";
      text-wrong-color = "ee99a0";
    };
  };
}
