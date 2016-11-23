{ stdenv, fetchurl, cmake, lua, boost, mesa, SDL, freetype, ftgl }:

stdenv.mkDerivation rec {
  version = "0.2";
  name = "genomic-${version}";

  src = fetchurl {
    url = "https://github.com/djhshih/genomic/archive/v${version}.tar.gz";
    sha256 = "0kml6dj8pimffphl819lirw7xnrl5f6cc2rx2n2fjbp86fvhylxy";
  };

  buildInputs = [ cmake lua boost mesa SDL freetype ftgl ];

  meta = with stdenv.lib; {
    description = "C++ toolkit for working with copy-number data";
    license     = licenses.gpl3;
    homepage    = "https://github.com/djhshih/genomic"; 
    platforms   = platforms.unix;
  };
}
