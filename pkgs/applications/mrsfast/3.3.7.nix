{ lib, stdenv, fetchurl, zlib, groff }:

stdenv.mkDerivation rec {
  version = "3.3.7";
  name = "mrsfast-${version}";

  src = fetchurl {
    url = "https://github.com/sfu-compbio/mrsfast/archive/v${version}.tar.gz";
    sha256 = "09z5x5lp418fagqp7ki69nyv6qakl4dbk9kj86y3mfb4fb7wyd4v";
  };

  buildInputs = [ zlib groff ];

  installPhase = ''
    mkdir -p $out/bin
    install $(find . -maxdepth 1 -type f -perm -u+x) $out/bin/
  '';

  meta = with lib; {
    description = "Micro-read substitution-only fast alignment search tool";
    license     = licenses.free;
    homepage    = "http://sfu-compbio.github.io/mrsfast";
    platforms   = platforms.unix;
  };
}
