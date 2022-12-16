{ lib, stdenv, fetchurl, zlib }:

stdenv.mkDerivation rec {
  version = "0.1.13";
  name = "vcftools-${version}";

  src = fetchurl {
    url = "https://github.com/vcftools/vcftools/archive/v${version}.tar.gz";
    sha256 = "0pn87xds32pikv692g407yjfcdmd8bl1n6kmsdhq2167gfjis90f";
  };

  buildInputs = [ zlib ];

  # patch the perl scripts so that they can find the local modules
  patches = [ ./findbin.patch ];

  preBuild = ''
    # fix version number
    sed 's/v0.1.14/v0.1.13/' -i cpp/parameters.h
  '';

  installPhase = ''
    install -Dm644 bin/man1/vcftools.1 $out/share/man/man1/vcftools.1
    install -D bin/vcftools $out/bin/vcftools
    install -Dm644 perl/*.pm $out/bin/
    chmod +x perl/{fill-,vcf-}* perl/tab-to-vcf
    PREFIX=$out make install
    rm -r $out/bin/man1
  '';

  meta = with lib; {
    description = "A set of tools for working with VCF files";
    license     = licenses.lgpl3;
    homepage    = "http://vcftools.github.io"; 
    platforms   = platforms.unix;
  };
}
