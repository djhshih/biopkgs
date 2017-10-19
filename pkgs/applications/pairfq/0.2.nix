{ stdenv, fetchFromGitHub }:

stdenv.mkDerivation rec {
  version = "0.2";
  name = "pairfq-${version}";

  src = fetchFromGitHub {
		owner = "djhshih";
		repo = "pairfq";
		rev = "v${version}";
		sha256 = "1fs93p837d0rlw6fccbj73qngjw5yawcs6kfcfm3p7zrlb1gqvi1";
  };

  installPhase = ''
    mkdir -p $out/bin/
    install $(find . -maxdepth 1 -type f -perm -u+x) $out/bin/
  '';

  meta = with stdenv.lib; {
    description = "Pair first-read and second-read fastq files togehter, separating unpaired reads";
    license     = licenses.gpl3;
    homepage    = "https://github.com/djhshih/pairfq"; 
    platforms   = platforms.unix;
  };
}
