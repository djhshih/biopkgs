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
		nixpkgs.gzip
		biopkgs.conkymon
  ];
  # nixpkgs.python (adds 100MB)
  # nixpkgs.R depends on jdk!
}
