{ stdenv, fetchurl, zlib, libpng, openssl, htslib }:

stdenv.mkDerivation rec {
  version = "0.1.0";
  name = "beato-${version}";

  src = fetchurl {
    url = "https://github.com/djhshih/libbeato/archive/v${version}.tar.gz";
    sha256 = "14spg9mybbbk2vya1sq6cwhxrp541yhdlxvy1px5iv5bfbniic94";
  };

  buildInputs = [ zlib libpng openssl htslib ];

  meta = with stdenv.lib; {
    description = "Static library combining some HTS stuff, core wiggle stuff, Jim Kent's libary";
    license     = licenses.gpl3;
    platforms   = platforms.unix;
    homepage    = "https://github.com/CRG-Barcelona/libbeato"; 
  };
}
