{ lib, stdenv, fetchFromGitHub, conkycli }:

stdenv.mkDerivation rec {
  version = "0.2.1";
  name = "conkymon-${version}";

  src = fetchFromGitHub {
    owner = "djhshih";
    repo = "conkymon";
    rev = "v${version}";
    sha256 = "0nzgm7shmsipv3gnis713ky7z8v9a4d1rzarr6qv5945mqfp190k";
  };

  buildInputs = [ conkycli ];

  postPatch = ''
    sed -i -e 's/conky -c/@conky@ -c/' conkymon
    substituteInPlace conkymon \
      --subst-var-by conky "${conkycli}/bin/conky"
  '';

  installPhase = ''
    mkdir -p $out/bin/
    install conkymon $out/bin
  '';

  meta = with lib; {
    description = "System monitoring with conky";
    license     = licenses.gpl3;
    homepage    = "https://github.com/djhshih/conkymon"; 
    platforms   = platforms.unix;
  };
}
