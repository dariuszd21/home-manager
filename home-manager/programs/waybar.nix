{ config, pkgs, ... }:

{

  # add pavucontrol-qt for the bar
  home.packages = with pkgs; [ lxqt.pavucontrol-qt ];

  home.file = {
    ".config/waybar/macchiato.css".source = ../dotfiles/waybar/macchiato.css;
    ".config/waybar/style.css".source = ../dotfiles/waybar/style.css;
  };

  # Status bar for wayland
  programs.waybar = {
    enable = true;
    systemd = {
      enable = true;
      target = "sway-session.target";
    };
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
          "custom/notification"
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
          "on-scroll-down" =
            "${pkgs.swayosd}/bin/swayosd-client --brightness lower";
          "on-scroll-up" =
            "${pkgs.swayosd}/bin/swayosd-client --brightness raise";
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
          "on-click" = "${pkgs.lxqt.pavucontrol-qt}/bin/pavucontrol-qt";
        };
        "custom/notification" = {
          "tooltip" = false;
          "format" = "{icon}";
          "format-icons" = {
            "notification" = "<span foreground='red'><sup></sup></span>";
            "none" = "";
            "dnd-notification" = "<span foreground='red'><sup></sup></span>";
            "dnd-none" = "";
            "inhibited-notification" =
              "<span foreground='red'><sup></sup></span>";
            "inhibited-none" = "";
            "dnd-inhibited-notification" =
              "<span foreground='red'><sup></sup></span>";
            "dnd-inhibited-none" = "";
          };
          "return-type" = "json";
          "exec-if" = "which ${pkgs.swaynotificationcenter}/bin/swaync-client";
          "exec" = "${pkgs.swaynotificationcenter}/bin/swaync-client -swb";
          "on-click" =
            "${pkgs.swaynotificationcenter}/bin/swaync-client -t -sw";
          "on-click-right" =
            "${pkgs.swaynotificationcenter}/bin/swaync-client -d -sw";
          "escape" = true;
        };
      };
    };
  };
}
