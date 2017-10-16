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
    nixpkgs.python
		nixpkgs.zlib
		nixpkgs.gzip
  ];
  # nixpkgs.gsl
  # nixpkgs.R depends on jdk!
}
