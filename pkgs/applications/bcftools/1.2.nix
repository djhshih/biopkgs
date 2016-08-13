{ stdenv, fetchurl, htslib, zlib, gsl, perl }:

stdenv.mkDerivation rec {
  version = "1.2";
  name = "bcftools-${version}";

  src = fetchurl {
    url = "https://github.com/samtools/bcftools/releases/download/${version}/${name}.tar.bz2";
    sha256 = "1mjgd3x7jqqi7f0yr4i40gqs7jzivbprqz0098rlbp90j0rjiijk";
  };

  buildInputs = [ htslib zlib gsl perl ];

  patches = [ ./use-system-htslib_1.2.patch ];

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
