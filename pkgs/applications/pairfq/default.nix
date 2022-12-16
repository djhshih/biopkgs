{ lib, stdenv, fetchFromGitHub }:

stdenv.mkDerivation rec {
  version = "0.2.1";
  name = "pairfq-${version}";

  src = fetchFromGitHub {
    owner = "djhshih";
    repo = "pairfq";
    rev = "v${version}";
    sha256 = "0xfjiyr0504sq4rfaghg3fpwd573rxcfli9cs9lvrp8b5lvw9w7i";
  };

  installPhase = ''
    mkdir -p $out/bin
    make install DESTDIR=$out
  '';

  meta = with lib; {
    description = "Pair first-read and second-read fastq files together, separating unpaired reads";
    license     = licenses.gpl3;
    homepage    = "https://github.com/djhshih/pairfq"; 
    platforms   = platforms.unix;
  };
}
