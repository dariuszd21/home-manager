{ config, pkgs, ... }:

{
  # Add zoxide (better cd command) 
  programs.zoxide = { enable = true; };
}
