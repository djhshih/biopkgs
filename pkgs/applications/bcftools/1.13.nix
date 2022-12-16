{ lib, stdenv, fetchurl, htslib, zlib, bzip2, lzma, curl, perl }:

stdenv.mkDerivation rec {
  version = "1.13";
  name = "bcftools-${version}";

  src = fetchurl {
    url = "https://github.com/samtools/bcftools/releases/download/${version}/${name}.tar.bz2";
    sha256 = "140bscypyivq1r7iwi8nfpqzxcxgnjh4fshra7xaipay5bda3gqk";
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
