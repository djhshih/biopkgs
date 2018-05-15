{ stdenv, fetchurl, zlib, bzip2, lzma, perl, ncurses }:

stdenv.mkDerivation rec {
  version = "1.6";
  name = "samtools-${version}";

  src = fetchurl {
    url = "https://github.com/samtools/samtools/releases/download/${version}/${name}.tar.bz2";
    sha256 = "17p4vdj2j2qr3b2c0v4100h6cg4jj3zrb4dmdnd9d9aqs74d4p7f";
  };

  preBuild = ''
    sed -e 's|#!/usr/bin/env python|#!/usr/bin/env python2|' -i misc/varfilter.py
  '';

  buildInputs = [ zlib bzip2 lzma perl ncurses ];

  patches = [ ./install-lib_1.6.patch ];

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
