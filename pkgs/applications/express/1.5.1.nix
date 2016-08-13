{ stdenv, fetchurl, boost, cmake, zlib, protobuf, gperftools, bamtools }:

stdenv.mkDerivation rec {
  version = "1.5.1";
  name = "express-${version}";

  src = fetchurl {
    url = "http://bio.math.berkeley.edu/eXpress/downloads/${name}/${name}-src.tgz";
    sha256 = "03rczxd0gjp2l1jxcmjfmf5j94j77zqyxa6x063zsc585nj40n0c";
  };

  # allow a more recent version of boost and enable dynamic linking
  patches = [ ./boost.patch ./dynamic-lib.patch ];

  buildInputs = [ boost cmake zlib protobuf gperftools bamtools ];

  meta = with stdenv.lib; {
    description = "Streaming quantification for RNA-seq";
    license     = licenses.artistic2;
    homepage    = "http://bio.math.berkeley.edu/eXpress/"; 
    platforms   = platforms.unix;
  };
}
