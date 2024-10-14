{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "dariuszd";
  home.homeDirectory = "/home/dariuszd";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
    zig
    fira-code-nerdfont

    # Wayland native snapshot editing tool
    grim
    swappy

    nixgl.nixGLMesa
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;
    ".config/nvim".source = dotfiles/nvim-config;
    ".config/bat/themes".source = dotfiles/bat/themes;
    ".config/systemd/user/sway-session.target".source =
      dotfiles/systemd/user/sway-session.target;
    ".config/waybar/macchiato.css".source = dotfiles/waybar/macchiato.css;
    ".config/waybar/style.css".source = dotfiles/waybar/style.css;

    ".config/sway".source = dotfiles/sway;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/dariuszd/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # enable fonts integration
  fonts.fontconfig.enable = true;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  imports = [
    ./programs/alacritty.nix
    ./programs/fzf.nix
    ./programs/neovim.nix
    ./programs/starship.nix
    ./programs/tmux.nix
    ./programs/zoxide.nix
    ./programs/zsh.nix
    ./services/swaync.nix
  ];

  # WezTerm integration
  programs.wezterm.enable = true;
  programs.wezterm.extraConfig = ''
    local config = {}

    config.color_scheme = "Catppuccin Macchiato"
    config.font = wezterm.font("FiraCode Nerd Font")

    return config
  '';

  # Sway integration
  # It seems that currently sway integration has to be done though host OS
  # To revisit

  # Enable management of XDG base directories.
  xdg.enable = true;

  # make Home Manager work better on GNU/Linux distributions other than NixOS.
  targets.genericLinux.enable = true;

  # Enable rg (ripgrep)
  programs.ripgrep.enable = true;

  # Enable fd (user-friendly find replacement)
  programs.fd.enable = true;

  # Enable portals support
  xdg.portal.enable = true;
  xdg.portal.config = {
    "common" = {
      "default" = "gtk";
      "org.freedesktop.impl.portal.ScreenCast" = "wlr";
      "org.freedesktop.impl.portal.Screenshot" = "wlr";
      # Probably to be replaced with KDE wallet, but we'll see
      "org.freedesktop.impl.portal.Secret" = "gnome-keyring";
    };
  };
  xdg.portal.extraPortals =
    [ pkgs.xdg-desktop-portal-gtk pkgs.xdg-desktop-portal-wlr ];

  # Add bat with theming and extras
  programs.bat = {
    enable = true;
    config = { theme = "Catppuccin Macchiato"; };
    extraPackages = with pkgs.bat-extras; [
      batdiff
      batman
      batgrep
      batpipe
      batwatch
    ];
  };

  # Programs related to the sway sessions
  # avizo - lightweight notification daemon
  services.avizo.enable = true;
  # To be updated to match catpuccin theme
  # services.avizo.settings = {};

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
          "on-scroll-down" = "lightctl down";
          "on-scroll-up" = "lightctl up";
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

  # Add application launcher for SwayWM
  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        terminal = "${pkgs.wezterm}/bin/wezterm";
        layer = "top";
      };
      colors = {
        background = "24273add";
        text = "cad3f5ff";
        prompt = "b8c0e0ff";
        placeholder = "8087a2ff";
        input = "cad3f5ff";
        match = "b7bdf8ff";
        selection = "5b6078ff";
        selection-text = "cad3f5ff";
        selection-match = "b7bdf8ff";
        counter = "8087a2ff";
        border = "b7bdf8ff";
      };
    };
  };
}
