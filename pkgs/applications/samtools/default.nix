{ lib, stdenv, fetchurl, zlib, bzip2, lzma, perl, ncurses }:

stdenv.mkDerivation rec {
  version = "1.13";
  name = "samtools-${version}";

  src = fetchurl {
    url = "https://github.com/samtools/samtools/releases/download/${version}/${name}.tar.bz2";
    sha256 = "0q4cbx37jh4ifqxnzxnzdn8p12xggj6gs760x6hhk06ca7ha4v31";
  };

  buildInputs = [ zlib bzip2 lzma perl ncurses ];

  patches = [ ./install-lib_1.13.patch ];

  doCheck = false;

  installPhase = ''
    make prefix=$out install
  '';

  meta = with lib; {
    description = "Tools for reading/writing/editing/indexing/viewing SAM/BAM/CRAM format";
    license     = licenses.free;
    homepage    = "http://www.htslib.org"; 
    platforms   = platforms.unix;
  };
}
