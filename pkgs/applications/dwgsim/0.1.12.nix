{ stdenv, fetchFromGitHub, zlib, ncurses }:

stdenv.mkDerivation rec {
  version = "0.1.12";
  name = "dwgsim-${version}";

  src = fetchFromGitHub {
    owner = "nh13";
    repo = "dwgsim";
    rev = "dwgsim.${version}";
    sha256 = "10gsjnrf9c81321j9w04rjy0ah2adi4m1nlz6ya7lh5ixxnqi2h7";
    fetchSubmodules = true;
  };

  nativeBuildInputs = [ zlib ncurses ];

  prePatch = ''
    sed -i -e 's/-lcurses/-lncurses/g' samtools/Makefile
  '';

  installPhase = ''
    mkdir -p $out/bin/
    install $(find . -maxdepth 1 -type f -perm -u+x) $out/bin/
  '';

  meta = with stdenv.lib; {
    description = "Whole genome simulator for next-generation sequencing";
    license     = licenses.gpl2;
    homepage    = "https://github.com/nh13/dwgsim"; 
    platforms   = platforms.unix;
  };
}
