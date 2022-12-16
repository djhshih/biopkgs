{ lib, stdenv, fetchurl, zlib, ldc, which, python2 }:

stdenv.mkDerivation rec {
  version = "0.6.6-1";
  name = "sambamba-${version}";

  src = fetchurl {
    url = "https://github.com/djhshih/sambamba/releases/download/v${version}/sambamba-${version}-wsub.tar.bz2";
    sha256 = "04xpsgin9dwlrc41f4hiskis3vw053qjp0v60gyvzp3smahfxzpf";
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
