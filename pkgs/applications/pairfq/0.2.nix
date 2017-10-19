{ stdenv, fetchFromGitHub }:

stdenv.mkDerivation rec {
  version = "0.2";
  name = "pairfq-${version}";

  src = fetchFromGitHub {
		owner = "djhshih";
		repo = "pairfq";
		rev = "v${version}";
		sha256 = "1myyn8fpk1px5phz7p5mrnjm8f7s9xjlxf0kzmjl2saapgfx3ram";
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
