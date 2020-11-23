{ stdenv, fetchFromGitHub }:

stdenv.mkDerivation rec {
  version = "0.1";
  name = "fem-${version}";

  src = fetchFromGitHub {
    owner = "haowenz";
    repo = "FEM";
    rev = "v${version}";
    sha256 = "12sm8qc6560yqygcnzxbwvrik18gbza5glqildj8x043xwb8cgai";
  };

  preBuild = ''
    sed -i 's/-march=native/-march=native -msse4.1/' Makefile
  '';

  installPhase = ''
    mkdir -p $out/bin/
    install $(find . -maxdepth 1 -type f -perm -u+x) $out/bin/
  '';

  meta = with stdenv.lib; {
    description = "A fast and efficient short read mapper";
    license     = licenses.gpl3;
    homepage    = "http://github.com/haowenz/FEM"; 
    platforms   = platforms.unix;
  };
}
