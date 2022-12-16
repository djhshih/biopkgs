{ lib, stdenv, fetchurl, cmake, zlib, bzip2 }:

stdenv.mkDerivation rec {
  version = "0.7.0b";
  name = "bfast-${version}";

  src = fetchurl {
    url = "https://github.com/djhshih/bfast/archive/v${version}.tar.gz";
    sha256 = "1km8b42zr3y12acr2gygcqyb3m6bm8yajfil0yif9s6q7ccnz934";
  };

  buildInputs = [ cmake zlib bzip2 ];

  meta = with lib; {
    description = "Blat-like Fast Accurate Search Tool";
    license     = licenses.gpl2;
    homepage    = "https://github.com/djhshih/bfast"; 
    platforms   = platforms.unix;
  };
}
