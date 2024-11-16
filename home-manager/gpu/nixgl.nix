{ config, pkgs, ... }:

{
  # Configure nixGL wrapper
  nixGL.packages = pkgs.nixgl;
  nixGL.defaultWrapper = "mesa";
  nixGL.installScripts = [ "mesa" ];
}
