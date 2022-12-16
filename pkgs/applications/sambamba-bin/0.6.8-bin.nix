{ lib, stdenv, fetchurl }:

stdenv.mkDerivation rec {
  version = "0.6.8";
  name = "sambamba-bin-${version}";

  src = fetchurl {
    url = "https://github.com/lomereiter/sambamba/releases/download/v${version}/sambamba-${version}-linux-static.gz";
    sha256 = "1m0gp48p7v3ybgqywvjig8fggsyay3wc7vc0fkdnkshcq5ixwvp5";
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
