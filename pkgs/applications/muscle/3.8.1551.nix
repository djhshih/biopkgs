{ lib, stdenv, fetchurl, glibc }:

stdenv.mkDerivation rec {
  version = "3.8.1551";
  name = "muscle-${version}";

  src = fetchurl {
    url = "http://www.drive5.com/muscle/muscle_src_${version}.tar.gz";
    sha256 = "0bj8kj7sdizy3987zx6w7axihk40fk8rn76mpbqqjcnd64i5a367";
  };

  buildInputs = [ glibc.static ];

  unpackPhase = ''
    mkdir $name
    tar -xzf $src -C $name
    sourceRoot=$name
  '';

  installPhase = ''
    mkdir -p $out/bin/
    install muscle $out/bin/
  '';

  meta = with lib; {
    description = "Multiple sequence alignment with high accuracy and high throughput";
    license     = licenses.publicDomain;
    homepage    = "http://www.drive5.com/muscle";
    platforms   = platforms.unix;
  };
}
