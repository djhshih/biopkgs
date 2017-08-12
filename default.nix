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

    rsem = callPackage ./pkgs/applications/rsem {};

    samtools = callPackage ./pkgs/applications/samtools {};

    sickle = callPackage ./pkgs/applications/sickle {};

    snowtools = callPackage ./pkgs/applications/snowtools {};

    star = callPackage ./pkgs/applications/star {};

    vcftools = callPackage ./pkgs/applications/vcftools {};

    genomic = callPackage ./pkgs/applications/genomic {};

    bfast = callPackage ./pkgs/applications/bfast {};

    blat = callPackage ./pkgs/applications/blat {};

    sga = callPackage ./pkgs/applications/sga {};

    bwtool = callPackage ./pkgs/applications/bwtool {};

    
    # libraries

    htslib = callPackage ./pkgs/libraries/htslib {};

    beato = callPackage ./pkgs/libraries/beato {};
    

  };
in
biopkgs
