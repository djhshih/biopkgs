{ stdenv, fetchurl, zlib }:

stdenv.mkDerivation rec {
  version = "0.1.12b";
  name = "vcftools-${version}";

  src = fetchurl {
    url = "http://downloads.sourceforge.net/project/vcftools/vcftools_${version}.tar.gz";
    sha256 = "148al9h7f8g8my2qdnpax51kdd2yjrivlx6frvakf4lz5r8j88wx";
  };

  buildInputs = [ zlib ];

  # patch the perl scripts so that they can find the local modules
  patches = [ ./findbin.patch ];

  installPhase = ''
    install -Dm644 bin/man1/vcftools.1 $out/share/man/man1/vcftools.1
    install -D bin/vcftools $out/bin/vcftools
    install -Dm644 perl/*.pm $out/bin/
    PREFIX=$out make install
    rm -r $out/bin/man1
  '';

  meta = with stdenv.lib; {
    description = "A set of tools for working with VCF files";
    license     = licenses.lgpl3;
    homepage    = "http://vcftools.github.io"; 
    platforms   = platforms.unix;
  };
}
