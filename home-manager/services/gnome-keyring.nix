{ config, pkgs, ... }:

{
  # Add gnome-keyring daemon
  services.gnome-keyring = { enable = true; };
}
