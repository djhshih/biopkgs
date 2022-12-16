{ stdenv, fetchFromGitHub, cmake, pkgconfig, curl, unzip, zlib, lzma, bzip2, tbb, jemalloc }:

stdenv.mkDerivation rec {
  version = "1.8.0";
  name = "salmon-${version}";

  src = fetchFromGitHub {
    owner = "COMBINE-lab";
    repo = "salmon";
    rev = "refs/tags/v${version}";
    sha256 = "0bzr8p24wqw81ydjf4699d19n40qwmzhqz5ikssi551vqy0zazlp";
  };

  nativeBuildInputs = [ cmake pkgconfig curl unzip ];
  buildInputs = [ zlib lzma bzip2 tbb jemalloc ];

  cmakeFlags = [ "-DFETCH_BOOST=TRUE" ];

  meta = with stdenv.lib; {
    description = "Highly-accurate & wicked fast transcript-level quantification from RNA-seq reads using lightweight alignments";
    license     = licenses.gpl3;
    homepage    = "https://github.com/COMBINE-lab/salmon";
    platforms   = platforms.unix;
  };
}
