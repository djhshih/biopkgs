{ lib, stdenv, fetchFromGitHub, libdeflate, libisal }:

stdenv.mkDerivation rec {
  version = "0.23.2";
  name = "fastp-${version}";

  src = fetchFromGitHub {
    owner = "OpenGene";
    repo = "fastp";
    rev = "v${version}";
    sha256 = "04nmrqpjc3qni0cbazlwvpg8rk1mkfmfma0n4q3zivs3zi6rfnav";
  };

  buildInputs = [ libdeflate libisal ];

  installPhase = ''
    mkdir -p $out/bin/
    install $(find . -maxdepth 1 -type f -perm -u+x) $out/bin/
  '';

  meta = with lib; {
    description = "An ultra-fast all-in-one FASTQ preprocessor (QC/adapters/trimming/filtering/splitting/merging...)";
    license     = licenses.mit;
    homepage    = "https://github.com/OpenGene/fastp"; 
    platforms   = platforms.unix;
  };
}
