{ pkgs, ... }:

# https://github.com/nix-community/nixGL/issues/44#issuecomment-1361524862
let
  nixGLWrap = pkg:
    pkgs.runCommand "${pkg.name}-nixgl-wrapper" { } ''
      mkdir $out
      ln -s ${pkg}/* $out
      rm $out/bin
      mkdir $out/bin
      for bin in ${pkg}/bin/*; do
       wrapped_bin=$out/bin/$(basename $bin)
       echo "exec ${pkgs.nixgl.nixGLMesa}/bin/nixGLMesa $bin \$@" > $wrapped_bin
       chmod +x $wrapped_bin
      done
    '';
in nixGLWrap
