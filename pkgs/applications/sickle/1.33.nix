{ stdenv, fetchurl, zlib }:

stdenv.mkDerivation rec {
  version = "1.33";
  name = "sickle-${version}";

  src = fetchurl {
    url = "https://github.com/najoshi/sickle/archive/v${version}.tar.gz";
    sha256 = "0d27c9j0k8mvg6a7k3nn7igdd3lgiw92cmn2cz7f56f7bp973cpa";
  };

  buildInputs = [ zlib ];

  installPhase = ''
    mkdir -p $out/bin/
    install sickle $out/bin/
  '';

  meta = with stdenv.lib; {
    description = "Windowed adaptive trimming for FASTQ files using quality";
    license     = licenses.free;
    homepage    = "https://github.com/najoshi/sickle";
    platforms   = platforms.unix;
  };
}
