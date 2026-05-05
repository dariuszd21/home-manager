{ config, pkgs, ... }:

{
  # Configure nixGL wrapper
  targets.genericLinux.nixGL = {
    packages = pkgs.nixgl;
    defaultWrapper = "mesa";
    installScripts = [ "mesa" ];
  };
}
