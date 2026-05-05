{ config, pkgs, ... }:

{
  # Add ssh-agent integration
  services.ssh-agent = { enable = true; };
}
