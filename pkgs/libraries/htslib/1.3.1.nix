{ stdenv, fetchurl, zlib, perl }:

stdenv.mkDerivation rec {
  version = "1.3.1";
  name = "htslib-${version}";

  src = fetchurl {
    url = "https://github.com/samtools/htslib/releases/download/${version}/${name}.tar.bz2";
    sha256 = "1rja282fwdc25ql6izkhdyh8ppw8x2fs0w0js78zgkmqjlikmma9";
  };

  preBuild = ''
    sed -e 's|/usr/bin/perl -w|/usr/bin/env perl|' -i  test/compare_sam.pl
  '';

  buildInputs = [ zlib perl ];

  doCheck = true;

  meta = with stdenv.lib; {
    description = "A C library for reading/writing high-throughput sequencing data";
    license     = licenses.free;
    platforms   = platforms.unix;
    homepage    = "http://bedtools.readthedocs.org"; 
  };
}
