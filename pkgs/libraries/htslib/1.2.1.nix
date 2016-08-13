{ stdenv, fetchurl, zlib, perl }:

stdenv.mkDerivation rec {
  version = "1.2.1";
  name = "htslib-${version}";

  src = fetchurl {
    url = "https://github.com/samtools/htslib/releases/download/${version}/${name}.tar.bz2";
    sha256 = "1c32ssscbnjwfw3dra140fq7riarp2x990qxybh34nr1p5r17nxx";
  };

  buildInputs = [ zlib perl ];

  doCheck = true;

  meta = with stdenv.lib; {
    description = "A C library for reading/writing high-throughput sequencing data";
    license     = licenses.free;
    platforms   = platforms.unix;
    homepage    = "http://bedtools.readthedocs.org"; 
  };
}
