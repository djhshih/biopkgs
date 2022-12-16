{ lib, stdenv, fetchurl, unzip, which, inetutils, perl }:

stdenv.mkDerivation rec {
  version = "2.2.5";
  name = "bowtie2-${version}";

  src = fetchurl {
    url = "http://downloads.sourceforge.net/project/bowtie-bio/bowtie2/${version}/${name}-source.zip";
    sha256 = "1c6kg1wwscv6lgzmzb89p4jw095r1qgyw1z2lf10xh91jkfnc9z2";
  };

  buildInputs = [ unzip which inetutils ];

  installPhase = ''
    mkdir -p $out/bin/
    install $(find . -maxdepth 1 -type f -perm -u+x) $out/bin/
    mkdir -p $out/share/bowtie2/
    install -m644 MANUAL $out/share/bowtie2/
  '';

  meta = with lib; {
    description = "A fast and sensitive read aligner supporting gapped, local, and paired-end alignment";
    license     = licenses.gpl3;
    homepage    = "http://bowtie-bio.sourceforge.net/bowtie2"; 
    platforms   = platforms.unix;
  };
}
