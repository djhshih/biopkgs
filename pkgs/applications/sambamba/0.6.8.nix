{ lib, stdenv, fetchurl, zlib, ldc, which, python2 }:

stdenv.mkDerivation rec {
  version = "0.6.8";
  name = "sambamba-${version}";

  src = fetchurl {
    url = "https://github.com/biod/sambamba/archive/v${version}.tar.gz";
    sha256 = "0ig21qsp2jcbpfkaiica0a261c5dj618jsxbgs6029f3bfrasfja";
  };

  buildInputs = [ zlib ldc which python2 ];

  buildPhase = ''
    make sambamba-ldmd2-64
  '';

  installPhase = ''
    mkdir -p $out/bin
    install build/sambamba $out/bin/sambamba
    mkdir -p $out/share/man/man1/
    install -Dm644 man/*.1 $out/share/man/man1/
  '';

  meta = with lib; {
    description = "Tools for working with SAM/BAM data";
    license     = licenses.gpl2;
    homepage    = "https://github.com/lomereiter/sambamba"; 
    platforms   = platforms.unix;
  };
}
