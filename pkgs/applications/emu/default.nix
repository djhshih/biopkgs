{ lib, stdenv, fetchFromGitHub, gsl }:

stdenv.mkDerivation rec {
  version = "1.5.3";
  name = "emu-${version}";

  src = fetchFromGitHub {
    owner = "djhshih";
    repo = "EMu";
    rev = "v${version}";
    sha256 = "0lfw5kdqshwdgid208a9a5krmwc4hb7zdsrf7a4b08jhvzvf86fl";
  };

  buildInputs = [ gsl ];

  installPhase = ''
    DESTDIR=$out make install
  '';

  meta = with lib; {
    description = "An Expectation-Maximization algorithm to infer mutational signatures";
    license     = licenses.gpl3;
    homepage    = "https://github.com/djhshih/EMu"; 
    platforms   = platforms.unix;
  };
}
