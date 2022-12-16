{ lib, stdenv, fetchFromGitHub, cmake, pkgconfig, curl, unzip, zlib, lzma, bzip2, tbb, jemalloc }:

stdenv.mkDerivation rec {
  version = "0.11.2";
  name = "salmon-${version}";

  src = fetchFromGitHub {
    owner = "COMBINE-lab";
    repo = "salmon";
    rev = "refs/tags/v${version}";
    sha256 = "188m8s7s1j5xbdv9gbg6qra059diba54p6rvxp1v836l7bqv802z";
  };

  nativeBuildInputs = [ cmake pkgconfig curl unzip ];
  buildInputs = [ zlib lzma bzip2 tbb jemalloc ];

  cmakeFlags = [ "-DFETCH_BOOST=TRUE" ];

  meta = with lib; {
    description = "Highly-accurate & wicked fast transcript-level quantification from RNA-seq reads using lightweight alignments";
    license     = licenses.gpl3;
    homepage    = "https://github.com/COMBINE-lab/salmon";
    platforms   = platforms.unix;
  };
}
