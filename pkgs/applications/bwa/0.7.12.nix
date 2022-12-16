{ lib, stdenv, fetchurl, zlib }:

stdenv.mkDerivation rec {
  version = "0.7.12";
  name = "bwa-${version}";

  src = fetchurl {
    url = "https://github.com/lh3/bwa/archive/${version}.tar.gz";
    sha256 = "1q32px2q08xsv6xqdj6bvvn9k9vq4dshd6wsv8z8g7hzzavmapr8";
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
    homepage    = "http://bowtie-bio.sourceforge.net/bowtie2"; 
    platforms   = platforms.unix;
  };
}
