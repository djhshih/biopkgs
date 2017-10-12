let
  nixpkgs = import <nixpkgs> {};
  
  biopkgs = import ../../../default.nix {};
in
nixpkgs.dockerTools.buildImage {
  name = "core";
  contents = [
    nixpkgs.bash
    nixpkgs.coreutils
    nixpkgs.glibc
    nixpkgs.perl
    nixpkgs.zlib
    nixpkgs.python
  ];
  # nixpkgs.gsl
  # nixpkgs.R depends on jdk!
}
