{ config, pkgs, ... }:

{
  # tmux integration
  programs.tmux = {
    enable = true;
    mouse = true;
    prefix = "C-a";
    shell = "${pkgs.zsh}/bin/zsh";
    terminal = "tmux-256color";
    focusEvents = true;
    escapeTime = 10;
    extraConfig = ''
      # remap prefix from 'C-b' to 'C-a'
      bind-key C-a last-window
      bind-key A command-prompt -I "#W" "rename-window '%%'"

      # reload configuration hotkey
      bind R source-file ${config.home.homeDirectory}/.config/tmux/tmux.conf

      # open new pane and windows in current directory
      bind  %  split-window -h -c "#{pane_current_path}"
      bind '"' split-window -v -c "#{pane_current_path}"

      # True color support
      set-option -sa terminal-features ',alacritty:RGB'
      set-option -ga terminal-features ",alacritty:usstyle"
      set-option -ga terminal-overrides ',alacritty:Tc'
    '';
    plugins = with pkgs; [{
      plugin = tmuxPlugins.catppuccin;
      extraConfig = ''
        set -g @catppuccin_flavor 'macchiato' # latte,frappe, macchiato or mocha

        # Set style for the window part
        set -g @catppuccin_window_status_style "basic"
        # set -g @catppuccin_window_status_style "rounded"

        # Set window name to tmux default (from directory name)
        set -g @catppuccin_window_default_fill "number"
        set -g @catppuccin_window_default_text "#W"
        set -g @catppuccin_window_current_fill "number"
        set -g @catppuccin_window_current_text "#W"
        set -g @catppuccin_window_current_text_color "#{@thm_surface_1}"
        set -g @catppuccin_window_current_number_color "#{@thm_mauve}"
        set -g @catppuccin_window_current_text " #W"
        set -g @catppuccin_window_current_number "#I"
        set -g @catppuccin_window_text " #W"
        set -g @catppuccin_window_number "#I"

        # Make status transparent
        set -g @catppuccin_status_background "none"

        # Adjust status configuration
        set -g @catppuccin_status_left_separator  " "
        set -g @catppuccin_status_right_separator "█"
        # set -g @catppuccin_status_modules_right "application directory date_time"
        set -g status-right-length 400
        set -gF status-right "#{E:@catppuccin_status_application}"
        set -agF status-right "#{E:@catppuccin_status_directory}"
        set -agF status-right "#{E:@catppuccin_status_date_time}"
        set -g @catppuccin_status_connect_separator "no"

        # Replace directories inside home with ~/ to shorten path
        set -g @catppuccin_directory_text "#(${config.home.homeDirectory}/.config/tmux/scripts/shorten_path.py #{pane_current_path})"

        # Change application background to yellow to distinguish from directory
        set -g @catppuccin_application_color "#{E:@thm_yellow}"
      '';
    }];
  };
}
