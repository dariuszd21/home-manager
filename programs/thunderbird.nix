{ config, pkgs, ... }:

{
  # not using programs.thunderbird.enable on purpuse
  # as it expects set of profiles to be defined upfront
  home.packages = with pkgs; [
    thunderbird
  ];
}
