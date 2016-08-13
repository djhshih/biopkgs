{ system ? builtins.currentSystem }:

let
  nixpkgs = import <nixpkgs> { inherit system; };

  # prioritize packages in self over those in nixpkgs
  callPackage = nixpkgs.lib.callPackageWith (nixpkgs // biopkgs);

  biopkgs = {

    
    # applications

    bamtools = callPackage ./pkgs/applications/bamtools {};

    bcftools = callPackage ./pkgs/applications/bcftools {};

    bedtools = callPackage ./pkgs/applications/bedtools {};

    bismark = callPackage ./pkgs/applications/bismark {};

    bowtie2 = callPackage ./pkgs/applications/bowtie2 {};

    bwa = callPackage ./pkgs/applications/bwa {};

    emu = callPackage ./pkgs/applications/emu {};

    express = callPackage ./pkgs/applications/express {};

    fastqc = callPackage ./pkgs/applications/fastqc {};

    mrsfast = callPackage ./pkgs/applications/mrsfast {};

    muscle = callPackage ./pkgs/applications/muscle {};

    
    # libraries
    

  };
in
biopkgs
