{ stdenv, fetchurl, perl }:

stdenv.mkDerivation rec {
  version = "0.14.3";
  name = "bismark-${version}";

  src = fetchurl {
    url = "http://www.bioinformatics.babraham.ac.uk/projects/bismark/bismark_v${version}.tar.gz";
    sha256 = "16igjsa95lfdlr922jy7b21zmp392qq0951wa1588mcvz2l5ndar";
  };

  installPhase = ''
    mkdir -p $out/bin
    # install all executables
    install $(find . -maxdepth 1 -type f -perm -u+x) $out/bin
    install -m644 bismark_sitrep.tpl $out/bin

    mkdir -p $out/share/bismark
    install -m644 *.pdf $out/share/bismark
  '';

  meta = with stdenv.lib; {
    description = "A bisulfite read mapper and methylation caller";
    license     = licenses.gpl3;
    homepage    = "http://www.bioinformatics.babraham.ac.uk/projects/bismark"; 
    platforms   = platforms.unix;
  };
}
