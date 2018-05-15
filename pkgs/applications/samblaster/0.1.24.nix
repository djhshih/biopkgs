{ stdenv, fetchFromGitHub }:

stdenv.mkDerivation rec {
  version = "0.1.24";
  name = "samblaster-${version}";

  src = fetchFromGitHub {
		owner = "GregoryFaust";
		repo = "samblaster";
		rev = "v.${version}";
		sha256 = "0iv2ddfw8363vb2x8gr3p8g88whb6mb9m0pf71i2cqsbv6jghap7";
  };

  installPhase = ''
    mkdir -p $out/bin/
    install $(find . -maxdepth 1 -type f -perm -u+x) $out/bin/
  '';

  meta = with stdenv.lib; {
    description = "A tool to mark duplicates and extract discordant and split reads from sam files";
    license     = licenses.mit;
    homepage    = "https://github.com/GregoryFaust/samblaster"; 
    platforms   = platforms.unix;
  };
}
