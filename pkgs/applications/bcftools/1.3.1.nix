{ stdenv, fetchurl, htslib, zlib, gsl, perl }:

stdenv.mkDerivation rec {
  version = "1.3.1";
  name = "bcftools-${version}";

  src = fetchurl {
    url = "https://github.com/samtools/bcftools/releases/download/${version}/${name}.tar.bz2";
    sha256 = "095ry68vmz9q5s1scjsa698dhgyvgw5aicz24c19iwfbai07mhqj";
  };

  prePatch = ''
    sed s/-lcblas/-lgslcblas/g -i Makefile
  '';

  buildInputs = [ htslib zlib gsl perl ];

  buildPhase = ''
    make USE_GPL=1
  '';

  checkPhase = ''
    make USE_GPL=1 test
  '';

  installPhase = ''
    make USE_GPL=1 prefix=$out install
    BCFTOOLS_PLUGINS=$out/lib/bcftools/
    mkdir -p $BCFTOOLS_PLUGINS
    install -D plugins/*.so $BCFTOOLS_PLUGINS
  '';

  meta = with stdenv.lib; {
    description = "Tools for reading/writing BCF2/VCF/gVCF files and calling/filtering/summarising SNP and short indel sequence variants";
    license     = licenses.free;
    homepage    = "http://www.htslib.org"; 
  };
}
