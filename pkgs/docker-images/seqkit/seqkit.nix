let
  nixpkgs = import <nixpkgs> {};
  
  biopkgs = import ../../../default.nix {};
in
nixpkgs.dockerTools.buildImage {
  name = "seqkit";
  contents = [
    biopkgs.bwa
    biopkgs.samblaster
    biopkgs.sambamba
    biopkgs.samtools
    biopkgs.bcftools
    biopkgs.bedtools
    biopkgs.vcftools
  ];
}
