{ config, pkgs, ... }:

{
  home.file = {
    ".config/swaync/style.css".source = ../dotfiles/swaync/style.css;
  };

  # Add notification daemon
  services.swaync = {
    enable = true;
    settings = {

      "widgets" =
        [ "inhibitors" "title" "dnd" "buttons-grid" "mpris" "notifications" ];
      "buttons-grid" = {
        "actions" = [{
          "label" = "WiFi";
          "type" = "toggle";
          "active" = true;
          "command" =
            "sh -c '[[ $SWAYNC_TOGGLE_STATE == true ]] && nmcli radio wifi on || nmcli radio wifi off'";
          "update-command" =
            "sh -c '[[ $(nmcli radio wifi) == \"enabled\" ]] && echo true || echo false'";
        }];
      };
    };
  };
}
