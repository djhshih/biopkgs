{ stdenv, fetchurl, zlib, ncurses, perl }:

stdenv.mkDerivation rec {
  version = "1.3.3";
  name = "rsem-${version}";

  src = fetchurl {
    url = "https://github.com/deweylab/RSEM/archive/v${version}.tar.gz";
    sha256 = "1p2039hmxx0ndvxrpipi3njhi5k40ynx4fky5am6qd7qkpfq9rwh";
  };

  # rsem is bundled with samtools-0.1.19 and builds all of it unnecessarily
  # rsem links libbam.a statically
  buildInputs = [ zlib ncurses perl ];

  buildPhase = ''
    make

    cd EBSeq
    # skip installation of EBSeq R package but make the programs
    make rsem-for-ebseq-calculate-clustering-info
    cd ..
  '';

  installPhase = ''
    mkdir -p $out/bin
    # install all executables
    install $(find . -name rsem-\* -maxdepth 1 -type f -perm -u+x) $out/bin
    install convert-sam-for-rsem $out/bin
    install extract-transcript-to-gene-map-from-trinity $out/bin
    install $(find EBSeq -name rsem-\* -maxdepth 1 -type f -perm -u+x) $out/bin
    install -m644 rsem_perl_utils.pm WHAT_IS_NEW $out/bin
  '';

  meta = with stdenv.lib; {
    description = "Accurate quantification of gene and isoform expression from RNA-seq data";
    license     = licenses.gpl3;
    homepage    = "https://github.com/deweylab/RSEM"; 
    platforms   = platforms.unix;
  };
}
