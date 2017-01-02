{ stdenv, fetchurl, cmake, zlib, bzip2 }:

stdenv.mkDerivation rec {
  version = "0.7.0b";
  name = "bfast-${version}";

  src = fetchurl {
    url = "https://github.com/djhshih/bfast/archive/v${version}.tar.gz";
    sha256 = "10h0kqvrkh2avabr5l8f9hzw3yxzmvnqzf8m1v898r4axf2mks6x";
  };

  buildInputs = [ cmake zlib bzip2 ];

  meta = with stdenv.lib; {
    description = "Blat-like Fast Accurate Search Tool";
    license     = licenses.gpl2;
    homepage    = "https://github.com/djhshih/bfast"; 
    platforms   = platforms.unix;
  };
}
