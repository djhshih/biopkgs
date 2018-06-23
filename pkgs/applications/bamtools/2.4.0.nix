{ stdenv, fetchurl, cmake, zlib }:

stdenv.mkDerivation rec {
  version = "2.4.0";
  name = "bamtools-${version}";

  src = fetchurl {
    url = "https://github.com/pezmaster31/bamtools/archive/v${version}.tar.gz";
    sha256 = "0gp1c7lsqrwgplrywxvjbkfia22xby477gnpkvxy068phyw85zpi";
  };

  prePatch = ''
    # set the lib destination as 'lib' instead of 'lib/bamtools'
    sed 's|lib/bamtools|lib|g' -i src/api/CMakeLists.txt
    # remove 'bamtools/' from include path because include statements within
    # bamtools header files themselves lack 'bamtools/'
    # ideally, upstream should add 'bamtools/' to all internal include statements
    sed 's|include/bamtools|include|g' -i src/ExportHeader.cmake
  '';

  nativeBuildInputs = [ cmake ];
  buildInputs = [ zlib ];

  meta = with stdenv.lib; {
    description = "C++ API and command-line toolkit for working with BAM data";
    license     = licenses.mit;
    homepage    = "https://github.com/pezmaster31/bamtools"; 
    platforms   = platforms.unix;
  };
}
