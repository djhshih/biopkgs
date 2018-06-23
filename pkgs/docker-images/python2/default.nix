let
  nixpkgs = import <nixpkgs> {};
  coreImage = import ../core/default.nix;
in
nixpkgs.dockerTools.buildImage {
  name = "python2";
  fromImage = coreImage;
  contents = [
    nixpkgs.python2
  ];
}
