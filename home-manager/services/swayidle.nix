{ config, pkgs, ... }:

{
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
        command = "swaymsg 'output * dpms off'";
        resumeCommand = "swaymsg 'output * dpms on'";
      }
    ];
  };
}
