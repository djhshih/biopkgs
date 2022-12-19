{ lib, stdenv, fetchurl, zlib, bzip2, xz, curl, perl }:

stdenv.mkDerivation rec {
  version = "1.16";
  name = "htslib-${version}";

  src = fetchurl {
    url = "https://github.com/samtools/htslib/releases/download/${version}/${name}.tar.bz2";
    sha256 = "093r1n4s134k50m9a925yn95gyi90ps5dlgc6gq4qwvkzxx7qsv0";
  };

  preBuild = ''
    sed -e 's|/usr/bin/perl -w|/usr/bin/env perl|' -i  test/compare_sam.pl
  '';

  preCheck = ''
    patchShebangs test/
  '';

  nativeBuildInputs = [ perl ];

  buildInputs = [ zlib bzip2 xz curl ];

  doCheck = true;

  meta = with lib; {
    description = "A C library for reading/writing high-throughput sequencing data";
    license     = licenses.free;
    platforms   = platforms.unix;
    homepage    = "http://bedtools.readthedocs.org"; 
  };
}
