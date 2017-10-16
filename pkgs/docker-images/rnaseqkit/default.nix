let
  nixpkgs = import <nixpkgs> {};
  biopkgs = import ../../../default.nix {};
	coreImage = import ../core/default.nix;
in
nixpkgs.dockerTools.buildImage {
  name = "rnaseqkit";
	fromImage = coreImage;
  contents = [
    biopkgs.star
    biopkgs.rsem
  ];
}
