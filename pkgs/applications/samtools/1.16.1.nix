{ lib, stdenv, fetchurl, zlib, bzip2, lzma, perl, ncurses }:

stdenv.mkDerivation rec {
  version = "1.16.1";
  name = "samtools-${version}";

  src = fetchurl {
    url = "https://github.com/samtools/samtools/releases/download/${version}/${name}.tar.bz2";
    sha256 = "01qxvygvq6m7m3vhlysdw5g1qkx1c182vly90wyz4k2rg1gs581g";
  };

  buildInputs = [ zlib bzip2 lzma perl ncurses ];

  #patches = [ ./install-lib_1.13.patch ];

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
