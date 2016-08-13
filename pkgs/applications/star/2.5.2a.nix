{ stdenv, fetchFromGitHub, zlib, vim }:

stdenv.mkDerivation rec {
  version = "2.5.2a";
  name = "star-${version}";

  src = fetchFromGitHub {
		owner = "alexdobin";
		repo = "STAR";
		rev = "${version}";
		sha256 = "0disn6zkq78dyq58zkc6qm4gyqs8kjpj8kwzls91w78hlwaffwcx";
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

  meta = with stdenv.lib; {
    description = "Spliced Transcripts Alignment to a Reference for RNA-seq";
    license     = licenses.gpl3;
    homepage    = "https://github.com/alexdobin/STAR"; 
    platforms   = platforms.unix;
  };
}
