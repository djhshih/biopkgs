{ system ? builtins.currentSystem }:

let
  nixpkgs = import <nixpkgs> { inherit system; };

  # prioritize packages in self over those in nixpkgs
  callPackage = nixpkgs.lib.callPackageWith (nixpkgs // biopkgs);

  biopkgs = {

    
    # applications

    bamtools = callPackage ./pkgs/applications/bamtools {};

    bcftools = callPackage ./pkgs/applications/bcftools {};

    
    # libraries
    

  };
in
biopkgs
