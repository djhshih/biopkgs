let
  nixpkgs = import <nixpkgs> {};
  biopkgs = import ../../../default.nix {};
  coreImage = import ../core/default.nix;
in
nixpkgs.dockerTools.buildImage {
  name = "seqkit";
  fromImage = coreImage;
  contents = [
    biopkgs.bwa
    biopkgs.samblaster
    biopkgs.sambamba-bin
    biopkgs.samtools
    biopkgs.bcftools
    biopkgs.bedtools
    biopkgs.vcftools
    biopkgs.pairfq
    biopkgs.rgsam
  ];
}
