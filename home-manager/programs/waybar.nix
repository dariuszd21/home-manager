{ config, pkgs, ... }:

{
  home.file = {
    ".config/waybar/macchiato.css".source = ../dotfiles/waybar/macchiato.css;
    ".config/waybar/style.css".source = ../dotfiles/waybar/style.css;
  };

  # Status bar for wayland
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        mod = "dock";
        height = 0;
        "modules-left" =
          [ "clock" "cpu" "memory" "sway/workspaces" "sway/mode" ];
        "modules-center" = [ "sway/window" ];
        "modules-right" = [
          "tray"
          "backlight"
          "pulseaudio"
          "battery"
          "network"
          "idle_inhibitor"
        ];
        "sway/workspaces" = { "disable-scroll" = true; };
        "sway/window" = { "format" = "{}"; };

        "idle_inhibitor" = {
          "format" = "{icon} ";
          "format-icons" = {
            "activated" = "";
            "deactivated" = "";
          };
        };
        "tray" = {
          "icon-size" = 14;
          "spacing" = 5;
        };
        "clock" = {
          "format" = " {:%m/%d %I:%M%p}";
          "tooltip-format" = ''
            <big>{:%Y %B}</big>
            <tt><small>{calendar}</small></tt>'';
        };
        "cpu" = {
          "format" = " {usage}%";
          "on-click" = "alacritty -e htop";
        };
        "memory" = {
          "format" = " {}%";
          "on-click" = "alacritty -e htop";
        };
        "backlight" = {
          "format" = "{icon} {percent}%";
          "format-icons" = [ "" "" ];
          "on-scroll-down" = "swayosd-client --brightness raise";
          "on-scroll-up" = "swayosd-client --brightness lower";
        };
        "battery" = {
          "states" = {
            "good" = 70;
            "warning" = 30;
            "critical" = 15;
          };
          "format" = "{icon}  {capacity}%";
          # "format-good": "", // An empty format will hide the module
          # "format-full": "",
          "format-icons" = [ "" "" "" "" "" ];
        };
        "network" = {
          # "interface": "wlp2s0", // (Optional) To force the use of this interface
          "format" = "⚠ Disabled";
          "format-wifi" = " {essid}";
          "format-ethernet" = " {ifname}: {ipaddr}/{cidr}";
          "format-disconnected" = "⚠ Disconnected";
          "on-click" = "alacritty -e nmtui";
        };
        "pulseaudio" = {
          "scroll-step" = 5;
          "format" = "{icon} {volume}%";
          "format-bluetooth" = "{icon} {volume}%";
          "format-muted" = "muted ";
          "format-icons" = {
            "headphones" = "";
            "handsfree" = "";
            "headset" = "";
            "phone" = "";
            "portable" = "";
            "car" = "";
            "default" = [ "" "" ];
          };
          "on-click" = "pavucontrol-qt";
        };
      };
    };
  };
}
