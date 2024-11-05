{ config, pkgs, lib, ... }:

let nixGLWrap = import ../nixGLWrap.nix { inherit pkgs; };
in {
  # sway integration
   wayland.windowManager.sway = {
    enable = true;
    package = (nixGLWrap pkgs.sway);
  };
}
