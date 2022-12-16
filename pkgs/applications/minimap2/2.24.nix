{ lib, stdenv, fetchurl, zlib }:

stdenv.mkDerivation rec {
  version = "2.24";
  name = "minimap2-${version}";

  src = fetchurl {
    url = "https://github.com/lh3/minimap2/releases/download/v${version}/${name}.tar.bz2";
    sha256 = "05d6h2c1h95s5vblf1fijn9g0r4g69nsvkabji42j642y0gw7m4x";
  };

  buildInputs = [ zlib ];

  installPhase = ''
    mkdir -p $out/bin/
    install minimap2 $out/bin/
    install -Dm644 minimap2.1 $out/share/man/man1/minimap2.1
  '';

  meta = with lib; {
    description = "A versatile pairwise aligner for genomic and spliced nucleotide sequences";
    license = licenses.mit;
    homepage = "https://github.com/lh3/minimap2";
    platforms = platforms.unix;
  };
}
