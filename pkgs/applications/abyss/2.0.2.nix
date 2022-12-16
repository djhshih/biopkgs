{ stdenv, fetchurl, automake, autoconf, boost, openmpi, sparsehash, sqlite }:

stdenv.mkDerivation rec {
  version = "2.0.2";
  name = "abyss-${version}";

  src = fetchurl {
    url = "https://github.com/bcgsc/abyss/releases/download/${version}/${name}.tar.gz";
    sha256 = "1pr2jh4gfh5n4y8b4pls9hr8l9yq8gr667aay94gp9n3xbnpcyyq";
  };

  preConfigure = ''
    ./autogen.sh
  '';

  buildInputs = [ automake autoconf boost openmpi sparsehash sqlite ];

  meta = with stdenv.lib; {
    description = "De novo genome sequence assembler to assemble large genomes using short reads";
    license     = licenses.gpl3;
    homepage    = "https://github.com/bcgsc/abyss"; 
    platforms   = platforms.unix;
  };
}
