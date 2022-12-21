{ lib, stdenv, fetchurl }:

stdenv.mkDerivation rec {
  version = "1.9.0";
  name = "salmon-${version}";

  src = fetchurl {
    curlOpts = "-L";
    url = "https://github.com/COMBINE-lab/salmon/releases/download/v${version}/${name}_linux_x86_64.tar.gz";
    sha256 = "sha256-bPnWt8qVUoTWrAPo6dx3XnflAI5RXcNrDqmKRPxt3fY=";
  };

  phases = [ "unpackPhase" "installPhase" ];

  installPhase = ''
    mkdir -p $out
    cp -r bin/ $out/
    cp -r lib/ $out/
  '';

  meta = with lib; {
    description = "Highly-accurate & wicked fast transcript-level quantification from RNA-seq reads using lightweight alignments";
    license     = licenses.gpl3;
    homepage    = "https://github.com/COMBINE-lab/salmon";
    platforms   = platforms.unix;
  };
}
