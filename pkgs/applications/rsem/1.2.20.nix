{ stdenv, fetchurl, zlib, ncurses, perl }:

stdenv.mkDerivation rec {
  version = "1.2.20";
  name = "rsem-${version}";

  src = fetchurl {
    url = "https://github.com/deweylab/RSEM/archive/v${version}.tar.gz";
    sha256 = "0kfx7xmdjv50989w5dp14pr0nk4vzwhsy56js1x0a9zk928ddb3r";
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
    install $(find . -maxdepth 1 -type f -perm -u+x) $out/bin
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
