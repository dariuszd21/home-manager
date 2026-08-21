{
  config,
  lib,
  pkgs,
  ...
}:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "dariusz.duda@canonical.com";
  home.homeDirectory = "/home/dariusz.duda@canonical.com";

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

    # Nerd font
    nerd-fonts.fira-code
    # A generator for LS_COLORS with support for multiple color themes
    vivid
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;
    ".config/nvim".source = ./dotfiles/nvim-config;
    ".config/tmux/scripts".source = ./dotfiles/tmux/scripts;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  xdg = {
    configFile = {
      "nvim-playground" = {
        source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/git/home-manager/dotfiles/nvim-config";
      };
      "containers/storage.conf" = {
        text = ''
        [storage]
        driver = "overlay"
        graphroot = "${config.xdg.dataHome}/containers/storage"
        '';
      };
    };
  };

  systemd.user.sessionVariables = {
    EDITOR = "nvim";
    ELECTRON_OZONE_PLATFORM_HINT = "auto";
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

  nixpkgs.config.allowUnfreePredicate =
    pkg:
    builtins.elem (lib.getName pkg) [
      "copilot-language-server"
      "vscode"
    ];

  imports = [
    ./customization/gtk.nix
    ./development/copilot.nix
    ./programs/alacritty.nix
    ./programs/bat.nix
    ./programs/chromium.nix
    ./programs/eza.nix
    ./programs/fd.nix
    ./programs/fuzzel.nix
    ./programs/fzf.nix
    ./programs/gcc.nix
    ./programs/git.nix
    ./programs/keepassxc.nix
    ./programs/neovim.nix
    ./programs/pyenv.nix
    ./programs/ripgrep.nix
    ./programs/starship.nix
    ./programs/thunderbird.nix
    ./programs/tmux.nix
    ./programs/vscode.nix
    ./programs/zoxide.nix
    ./programs/zsh.nix
    ./services/gnome-keyring.nix
    ./services/ssh-agent.nix
    ./toolchains/clang.nix
    ./toolchains/go.nix
    ./toolchains/lua.nix
    ./toolchains/yaml.nix
    ./toolchains/zig.nix
  ]
  ++ lib.optional (builtins.pathExists ./personal/home.nix) ./personal/home.nix;

  # WezTerm integration
  programs.wezterm = {
    enable = true;
    package = pkgs.wezterm;
    extraConfig = ''
      local config = {}

      config.color_scheme = "Catppuccin Macchiato"
      config.font = wezterm.font("FiraCode Nerd Font")

      return config
    '';
  };

  # Sway integration
  # It seems that currently sway integration has to be done though host OS
  # To revisit

  # Enable management of XDG base directories.
  xdg.enable = true;

  # Enable portals support
  xdg.portal = {
    enable = true;
    config = {
      "common" = {
        "default" = "gtk";
        # Probably to be replaced with KDE wallet, but we'll see
        "org.freedesktop.impl.portal.Secret" = "gnome-keyring";
      };
    };
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
    ];
  };

}
