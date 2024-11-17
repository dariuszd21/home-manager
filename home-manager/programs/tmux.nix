{ config, pkgs, ... }:

{
  # tmux integration
  programs.tmux = {
    enable = true;
    mouse = true;
    prefix = "C-a";
    shell = "${pkgs.zsh}/bin/zsh";
    extraConfig = ''
      # remap prefix from 'C-b' to 'C-a'
      bind-key C-a send-prefix
      bind-key C-a last-window
      bind-key A command-prompt -I "#W" "rename-window '%%'"

      # reload configuration hotkey
      bind R source-file ${config.home.homeDirectory}/.config/tmux/tmux.conf

      # open new pane and windows in current directory
      bind  %  split-window -h -c "#{pane_current_path}"
      bind '"' split-window -v -c "#{pane_current_path}"
    '';
    plugins = with pkgs; [{
      plugin = tmuxPlugins.catppuccin;
      extraConfig = ''
        set -g @catppuccin_flavor 'macchiato' # latte,frappe, macchiato or mocha

        # Set style for the window part
        set -g @catppuccin_window_left_separator "█"
        set -g @catppuccin_window_right_separator " "
        set -g @catppuccin_window_middle_separator " █"
        set -g @catppuccin_window_number_position "right"

        # Set window name to tmux default (from directory name)
        set -g @catppuccin_window_default_fill "number"
        set -g @catppuccin_window_default_text "#W"
        set -g @catppuccin_window_current_fill "number"
        set -g @catppuccin_window_current_text "#W"

        # Make status transparent
        set -g @catppuccin_status_background "default"

        # Adjust status configuration
        set -g @catppuccin_status_left_separator  " "
        set -g @catppuccin_status_right_separator "█"
        set -g @catppuccin_status_modules_right "application directory date_time"
        set -g @catppuccin_status_connect_separator "no"

        # Replace directories inside home with ~/ to shorten path
        set -g @catppuccin_directory_text "#(${config.home.homeDirectory}/.config/tmux/scripts/shorten_path.py #{pane_current_path})"

        # Change application background to yellow to distinguish from directory
        set -g @catppuccin_application_color "#{thm_yellow}"
      '';
    }];
  };
}
