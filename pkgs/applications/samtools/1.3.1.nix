{ lib, stdenv, fetchurl, zlib, perl, ncurses }:

stdenv.mkDerivation rec {
  version = "1.3.1";
  name = "samtools-${version}";

  src = fetchurl {
    url = "https://github.com/samtools/samtools/releases/download/${version}/${name}.tar.bz2";
    sha256 = "0znnnxc467jbf1as2dpskrjhfh8mbll760j6w6rdkwlwbqsp8gbc";
  };

  preBuild = ''
    sed -e 's|#!/usr/bin/env python|#!/usr/bin/env python2|' -i misc/varfilter.py
  '';

  buildInputs = [ zlib perl ncurses ];

  patches = [ ./install-lib_1.3.1.patch ];

  doCheck = false;

  installPhase = ''
    make prefix=$out install
  '';

  meta = with lib; {
    description = "Tools for reading/writing/editing/indexing/viewing SAM/BAM/CRAM format";
    license     = licenses.free;
    homepage    = "http://www.htslib.org"; 
    platforms   = platforms.unix;
  };
}
