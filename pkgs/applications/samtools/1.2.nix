{ stdenv, fetchurl, zlib, perl, htslib, ncurses }:

stdenv.mkDerivation rec {
  version = "1.2";
  name = "samtools-${version}";

  src = fetchurl {
    url = "https://github.com/samtools/samtools/releases/download/${version}/${name}.tar.bz2";
    sha256 = "1akdqb685pk9xk1nb6sa9aq8xssjjhvvc06kp4cpdqvz2157l3j2";
  };

  preBuild = ''
    sed -e 's|#!/usr/bin/env python|#!/usr/bin/env python2|' -i misc/varfilter.py
  '';

  buildInputs = [ zlib perl htslib ncurses ];

  patches = [ ./use-system-htslib.patch ./install-lib.patch ];

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
