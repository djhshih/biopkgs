{ stdenv, fetchFromGitHub, cmake, pkgconfig, curl, unzip, zlib, lzma, bzip2, tbb, jemalloc }:

stdenv.mkDerivation rec {
  version = "0.10.2";
  name = "salmon-${version}";

  src = fetchFromGitHub {
    owner = "COMBINE-lab";
    repo = "salmon";
    rev = "v${version}";
    sha256 = "18s2q7hwa6l8q9czdalpln3mra0afvw2c042q8259zy19yc1rhbg";
  };

#  configurePhase = ''
#    cmake \
#      -DFETCH_BOOST=TRUE
    #  -DBOOST_INCLUDEDIR=${boost.dev}/include \
    #  -DBOOST_LIBRARYDIR=${boost.out}/lib
#  '';

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
