{ stdenv, fetchFromGitHub, zlib }:

stdenv.mkDerivation rec {
  version = "0.7.15";
  name = "bwa-${version}";

  src = fetchFromGitHub {
    owner = "lh3";
    repo = "bwa";
    rev = "v${version}";
    sha256 = "1aasdr3lik42gafi9lds7xw0wgv8ijjll1g32d7jm04pp235c7nl";
  };

  buildInputs = [ zlib ];

  installPhase = ''
    mkdir -p $out/bin/
    install $(find . -maxdepth 1 -type f -perm -u+x) $out/bin/
    install -Dm644 bwa.1 $out/share/man/man1/bwa.1
  '';

  meta = with stdenv.lib; {
    description = "Burrow-Wheeler Aligner for pairwise alignment between DNA sequences";
    license     = licenses.gpl3;
    homepage    = "http://bowtie-bio.sourceforge.net/bowtie2"; 
    platforms   = platforms.unix;
  };
}
