{ lib, stdenv, fetchurl, htslib, zlib, bzip2, lzma, curl, perl }:

stdenv.mkDerivation rec {
  version = "1.9";
  name = "bcftools-${version}";

  src = fetchurl {
    url = "https://github.com/samtools/bcftools/releases/download/${version}/${name}.tar.bz2";
    sha256 = "1j3h638i8kgihzyrlnpj82xg1b23sijibys9hvwari3fy7kd0dkg";
  };

  prePatch = ''
    sed s/-lcblas/-lgslcblas/g -i Makefile
  '';

  buildInputs = [ htslib zlib bzip2 lzma curl perl ];

  buildPhase = ''
    make
  '';

  checkPhase = ''
    make test
  '';

  installPhase = ''
    make prefix=$out install
    BCFTOOLS_PLUGINS=$out/lib/bcftools/
    mkdir -p $BCFTOOLS_PLUGINS
    install -D plugins/*.so $BCFTOOLS_PLUGINS
  '';

  meta = with lib; {
    description = "Tools for reading/writing BCF2/VCF/gVCF files and calling/filtering/summarising SNP and short indel sequence variants";
    license     = licenses.free;
    homepage    = "http://www.htslib.org"; 
  };
}
