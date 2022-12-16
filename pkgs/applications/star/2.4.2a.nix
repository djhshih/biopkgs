{ lib, stdenv, fetchurl, zlib, vim }:

stdenv.mkDerivation rec {
  version = "2.4.2a";
  name = "star-${version}";

  src = fetchurl {
    url = "https://github.com/alexdobin/STAR/archive/STAR_${version}.tar.gz";
    sha256 = "1c3rnm7r5l0kl3d04gl1g7938xqf1c2l0mla87rlplqg1hcns5mc";
  };

  buildPhase = ''
    cd source

    make STAR
    mv STAR STARshort
    make clean
    make STARlong
  '';

  # STAR includes its own modified version of htslib
  # STAR uses xxd from vim to hex dump parameter default values
  buildInputs = [ zlib vim ];

  installPhase = ''
    install -D STARshort $out/bin/STAR
    install -D STARlong $out/bin/STARlong
    install -Dm644 parametersDefault $out/share/star/parameters
    install -Dm644 ../doc/STARmanual.pdf $out/share/star/manual.pdf
  '';

  meta = with lib; {
    description = "Spliced Transcripts Alignment to a Reference for RNA-seq";
    license     = licenses.gpl3;
    homepage    = "https://github.com/alexdobin/STAR"; 
    platforms   = platforms.unix;
  };
}
