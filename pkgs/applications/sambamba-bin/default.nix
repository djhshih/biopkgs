{ lib, stdenv, fetchurl }:

stdenv.mkDerivation rec {
  version = "0.6.6";
  name = "sambamba-bin-${version}";

  src = fetchurl {
    url = "https://github.com/lomereiter/sambamba/releases/download/v${version}/sambamba_v${version}_linux.tar.bz2";
    sha256 = "1sdd1z6vh9frhqhcpmphbn302djljhl533d55mphv6im46jr5cn2";
  };

  # Work around the "unpacker appears to have produced no directories"
  # case that happens when the archive doesn't have a subdirectory.
  setSourceRoot = "sourceRoot=`pwd`";

  installPhase = ''
    mkdir -p $out/bin
    cp sambamba* $out/bin/sambamba
  '';

  meta = with lib; {
    description = "Tools for working with SAM/BAM data";
    license     = licenses.gpl2;
    homepage    = "https://github.com/lomereiter/sambamba"; 
    platforms   = platforms.unix;
  };
}
