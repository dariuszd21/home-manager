{ config, pkgs, ... }:

{
  # Enable zsh
  programs.zsh = {
    enable = true;
    enableVteIntegration = true;
    autocd = true;
    autosuggestion.enable = true;
    shellAliases = {
      ip = "ip --color=auto";
      ls = "ls --color=auto";
      grep = "grep --color";
      rgrep = "rgrep -n --color";
    };
    syntaxHighlighting.enable = true;
  };
}

