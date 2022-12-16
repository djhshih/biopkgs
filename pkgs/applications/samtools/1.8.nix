{ stdenv, fetchurl, zlib, bzip2, lzma, perl, ncurses }:

stdenv.mkDerivation rec {
  version = "1.8";
  name = "samtools-${version}";

  src = fetchurl {
    url = "https://github.com/samtools/samtools/releases/download/${version}/${name}.tar.bz2";
    sha256 = "c942bc1d9b85fd1b05ea79c5afd2805d489cd36b2c2d8517462682a4d779be16";
  };

  preBuild = ''
    sed -e 's|#!/usr/bin/env python|#!/usr/bin/env python2|' -i misc/varfilter.py
  '';

  buildInputs = [ zlib bzip2 lzma perl ncurses ];

  patches = [ ./install-lib_1.8.patch ];

  doCheck = false;

  installPhase = ''
    make prefix=$out install
  '';

  meta = with stdenv.lib; {
    description = "Tools for reading/writing/editing/indexing/viewing SAM/BAM/CRAM format";
    license     = licenses.free;
    homepage    = "http://www.htslib.org"; 
    platforms   = platforms.unix;
  };
}
