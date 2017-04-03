{ stdenv, fetchurl, coreutils, libpng }:

stdenv.mkDerivation rec {
  version = "35.1";
  name = "blat-${version}";

  src = fetchurl {
    url = "https://github.com/djhshih/blat/archive/v${version}.tar.gz";
    sha256 = "1xifxqrb7rml533lph42p4a3sr9i592ckwnsp7f4ncfl2sg0dhwp";
  };

  buildPhase = ''
    DESTDIR=$out make
  '';

  # skip install phase, since installation is already done by make
  installPhase = "";

  buildInputs = [ coreutils libpng ];

  meta = with stdenv.lib; {
    description = "BLAST-Like Alignment Tool";
    license     = licenses.cc-by-nc-sa-40;
    homepage    = "https://genome.ucsc.edu/FAQ/FAQblat.html"; 
    platforms   = platforms.unix;
  };
}
