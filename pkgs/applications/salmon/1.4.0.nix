{ lib, stdenv, fetchFromGitHub, cmake, pkgconfig, curl, unzip, zlib, lzma, bzip2, tbb, jemalloc }:

stdenv.mkDerivation rec {
  version = "1.4.0";
  name = "salmon-${version}";

  src = fetchFromGitHub {
    owner = "COMBINE-lab";
    repo = "salmon";
    rev = "refs/tags/v${version}";
    sha256 = "1di7y2s8cjr9480lngcmaz3wcabc1lpkyanzbhir1nkhcjmj70h4";
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
