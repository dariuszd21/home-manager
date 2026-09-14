{ config, pkgs, ... }:

{
  home.packages = with pkgs; [ gcr_3 ];

  # Add gnome-keyring daemon
  services.gnome-keyring = {
    enable = true;
    components = [ "pkcs11" "secrets" ];
  };
}
