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
        command = "swaylock";
      }
      {
        timeout = 905;
        command = "${config.lib.nixGL.wrap pkgs.sway}/bin/swaymsg 'output * dpms off'";
        resumeCommand = "${config.lib.nixGL.wrap pkgs.sway}/bin/swaymsg 'output * dpms on'";
      }
    ];
  };
}
