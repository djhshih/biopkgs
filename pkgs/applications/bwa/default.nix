{ lib, stdenv, fetchFromGitHub, zlib }:

stdenv.mkDerivation rec {
  version = "0.7.17";
  name = "bwa-${version}";

  src = fetchFromGitHub {
    owner = "lh3";
    repo = "bwa";
    rev = "v${version}";
    sha256 = "0mzda4awpcvl0q1bskhqrrbiw4k3q7cn407wb10ihdwd0k3whfga";
  };

  buildInputs = [ zlib ];

  installPhase = ''
    mkdir -p $out/bin/
    install $(find . -maxdepth 1 -type f -perm -u+x) $out/bin/
    install -Dm644 bwa.1 $out/share/man/man1/bwa.1
  '';

  meta = with lib; {
    description = "Burrow-Wheeler Aligner for pairwise alignment between DNA sequences";
    license     = licenses.gpl3;
    homepage    = "https://github.com/lh3/bwa"; 
    platforms   = platforms.unix;
  };
}
