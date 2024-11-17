{ config, pkgs, ... }:

{
  # Enable git
  programs.git = {
    enable = true;
    aliases = {
      last = "log -1 --stat";
      cleanup =
        "!git branch --merged | grep  -v '\\*\\|main\\|develop' | xargs -n 1 git branch -d";
      cs = "commit --signoff --gpg-sign";
    };
    # TODO: check fancy diffs in the future
    # delta.enable = true;
    # diff-highlight.enable = true;
    # diff-so-fancy.enable = true;
    # difftastic.enable  = true;
    extraConfig = { init = { defaultBranch = "develop"; }; };
  };
}
