{ lib, stdenv, fetchFromGitHub, zlib, boost }:

stdenv.mkDerivation rec {
  version = "0.3.0";
  name = "snowtools-${version}";

  src = fetchFromGitHub {
    owner = "jwalabroad";
    repo = "SnowTools";
    rev = "v${version}";
    sha256 = "0w39z03k1q6xy7isckp686xrsqbf31h9kjvfsb1rf4m2wzdxn990";
  };

  buildInputs = [ zlib boost ];

  meta = with lib; {
    description = "C++ htslib/bwa-mem interface for interrogating sequence data";
    license     = licenses.gpl3;
    homepage    = "https://github.com/jwalabroad/SnowTools"; 
    platforms   = platforms.unix;
  };
}
