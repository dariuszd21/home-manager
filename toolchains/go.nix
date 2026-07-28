{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    golangci-lint
    golangci-lint-langserver
  ];
}
