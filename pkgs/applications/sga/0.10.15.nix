{ stdenv, fetchurl, automake, autoconf, zlib, bamtools, sparsehash, jemalloc }:

stdenv.mkDerivation rec {
  version = "0.10.15";
  name = "sga-${version}";

  src = fetchurl {
    url = "https://github.com/jts/sga/archive/v${version}.tar.gz";
    sha256 = "12sm89iy6x6l1d2rzbl5sg3silsdrp1wpa4992y8ayf4drp9j60v";
  };

  preConfigure = ''
    cd src
    ./autogen.sh
  '';

  preInstall = ''
    sed -i 's/python/python2/' bin/*.py bin/sga-align bin/sga-joinedpe
  '';

  buildInputs = [ automake autoconf zlib bamtools sparsehash jemalloc ];

  meta = with stdenv.lib; {
    description = "De novo sequence assembler using string graphs";
    license     = licenses.gpl3;
    homepage    = "https://github.com/jts/sga"; 
    platforms   = platforms.unix;
  };
}
