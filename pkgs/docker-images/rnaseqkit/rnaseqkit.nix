let
  nixpkgs = import <nixpkgs> {};
  
  biopkgs = import ../../../default.nix {};
in
nixpkgs.dockerTools.buildImage {
  name = "rnaseqkit";
  contents = [
    biopkgs.star
    biopkgs.rsem
  ];
}
