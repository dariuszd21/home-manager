{ config, pkgs, ... }:

{
  home.packages = with pkgs; [ gcr ];

  # Add gnome-keyring daemon
  services.gnome-keyring = {
    enable = true;
    components = [ "pkcs11" "secrets" ];
  };
}
