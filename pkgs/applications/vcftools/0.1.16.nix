{ lib, stdenv, fetchurl, zlib, perl, pkg-config }:

stdenv.mkDerivation rec {
  version = "0.1.16";
  name = "vcftools-${version}";

  src = fetchurl {
    url = "https://github.com/vcftools/vcftools/releases/download/v${version}/vcftools-${version}.tar.gz";
    sha256 = "sha256-2/x3Q4PBBrhQQ9qixCVogWqmp7Tmq8ll7upsR93pFOM=";
  };

  buildInputs = [ pkg-config zlib perl ];

  # patch the perl scripts so that they can find the local modules
  patches = [ ./findbin_v${version}.patch ];

  installPhase = ''
    PREFIX=$out make install
    install -Dm644 src/perl/*.pm $out/bin/
  '';

  meta = with lib; {
    description = "A set of tools for working with VCF files";
    license     = licenses.lgpl3;
    homepage    = "http://vcftools.github.io"; 
    platforms   = platforms.unix;
  };
}
