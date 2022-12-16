{ lib, stdenv, fetchurl, zlib }:

stdenv.mkDerivation rec {
  version = "2.24.0";
  name = "bedtools-${version}";

  src = fetchurl {
    url = "https://github.com/arq5x/bedtools2/releases/download/v${version}/${name}.tar.gz";
    sha256 = "1r30psa6djfwy5swslcnpf04hmp5hf6cjvfr9rfs3ib80iibhwza";
  };

  buildInputs = [ zlib ];

  preBuild = ''
    # Remove unnecessary dependency on python by skipping script generation
    sed -i -e '/Creating executables for old CLI/,+3d' Makefile 
  '';

  installPhase = ''
    mkdir -pv $out/bin
    install -D bin/bedtools $out/bin 
  '';

  checkPhase = ''
    make test
  '';

  meta = with lib; {
    description = "A swiss army knife for genome arithmetic";
    license     = licenses.gpl2;
    homepage    = "http://bedtools.readthedocs.org"; 
    platforms   = platforms.unix;
  };
}
