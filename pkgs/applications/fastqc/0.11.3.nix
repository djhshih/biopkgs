{ lib, stdenv, fetchurl, unzip, perl }:

stdenv.mkDerivation rec {
  version = "0.11.3";
  name = "fastqc-${version}";

  src = fetchurl {
    url = "http://www.bioinformatics.babraham.ac.uk/projects/fastqc/fastqc_v${version}.zip";
    sha256 = "1yqgnriv1qp0s7yya69kcpj43s4v87c8v8v5kmsbvvdwjdkqwbpd";
  };

  buildInputs = [ unzip ];
  
  phases = [ "unpackPhase" "installPhase" ];

  installPhase = ''
    chmod +x fastqc
    mkdir -p $out/bin
    cp -v fastqc *.jar $out/bin
    cp -v -r net org uk $out/bin
    cp -v -r Configuration Templates $out/bin
    mkdir -p $out/fastqc/share
    cp -r Help $out/fastqc/share/help
  '';

  meta = with lib; {
    description = "A quality control application for high-throughput sequence data";
    license     = licenses.gpl3;
    homepage    = "http://www.bioinformatics.babraham.ac.uk/projects/fastqc"; 
    platforms   = platforms.unix;
  };
}
