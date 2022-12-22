{ lib, stdenv, fetchFromGitHub, nasm }:

stdenv.mkDerivation rec {
  version = "2.30.0";
  name = "libisal-${version}";

  src = fetchFromGitHub {
    owner = "intel";
    repo = "isa-l";
    rev = "v${version}";
    sha256 = "06ymkrf3hkkd94i59ahm79545rk709y8rd0v2l86w38z6is942q0";
  };

  nativeBuildInputs = [ nasm ];

  buildPhase = ''
    make -f Makefile.unx
    mv bin lib
  '';

  installPhase = ''
    mkdir -p $out/lib/
    install lib/libisal.so* $out/lib/
    install lib/isa-l.a $out/lib/libisal.a
  '';

  meta = with lib; {
    description = "Intelligent Storage Acceleration Library";
    license     = licenses.bsd3;
    platforms   = platforms.unix;
    homepage    = "https://github.com/intel/isa-l"; 
  };
}
