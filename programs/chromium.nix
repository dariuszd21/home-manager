{
  config,
  pkgs,
  lib,
  ...
}:

{
  programs.chromium = {
    enable = true;
    nativeMessagingHosts = [
      pkgs.keepassxc
    ];
  };
}
