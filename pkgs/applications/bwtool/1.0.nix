{ lib, stdenv, fetchurl, zlib, beato, htslib13 }:

stdenv.mkDerivation rec {
  version = "1.0";
  name = "bwtool-${version}";

  src = fetchurl {
    url = "https://github.com/CRG-Barcelona/bwtool/archive/${version}.tar.gz";
    sha256 = "0jjr02a3b6lcx9m66fawqb919vsbq2yqhwp06wfrw4icc1rpa5rf";
  };

  buildInputs = [ zlib beato htslib13 ];

  meta = with lib; {
    description = "A tool for bigWig files";
    license     = licenses.gpl3;
    homepage    = "https://github.com/CRG-Barcelona/bwtool"; 
    platforms   = platforms.unix;
  };
}
