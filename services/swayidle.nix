{ config, pkgs, ... }:

{
  # Add it also to PATH
  home.packages = with pkgs; [ swayidle ];

  # swayidle - idle manager for wayland
  services.swayidle = {
    enable = true;
    timeouts = [
      {
        timeout = 900;
        # to be fixed by https://github.com/dariuszd21/home-manager/issues/5
        command = "/usr/bin/swaylock -Ff";
      }
      {
        timeout = 905;
        command =
          "${config.lib.nixGL.wrap pkgs.sway}/bin/swaymsg 'output * dpms off'";
        resumeCommand =
          "${config.lib.nixGL.wrap pkgs.sway}/bin/swaymsg 'output * dpms on'";
      }
    ];
  };
}
