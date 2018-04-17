{ stdenv, fetchFromGitHub, pkgconfig, cmake, gcc48, lua }:

with stdenv.lib;

stdenv.mkDerivation rec {
  name = "conkycli-${version}";
  version = "1.10.8";

  src = fetchFromGitHub {
    owner = "brndnmtthws";
    repo = "conky";
    rev = "v${version}";
    sha256 = "15j8h251v9jpdg6h6wn1vb45pkk806pf9s5n3rdrps9r185w8hn8";
  };

  postPatch = ''
    sed -i -e '/include.*CheckIncludeFile)/i include(CheckIncludeFiles)' \
      cmake/ConkyPlatformChecks.cmake
		sed -i -e 's/.set.RELEASE true./set(RELEASE true)/' cmake/Conky.cmake
  '';

  NIX_LDFLAGS = "-lgcc_s";

  nativeBuildInputs = [ pkgconfig cmake lua gcc48 ];

  cmakeFlags = ""
    + "-DBUILD_X11=OFF "
    + "-DBUILD_IBM=OFF "
    + "-DBUILD_MPD=OFF "
    + "-DBUILD_NCURSES=OFF "
    + "-DBUILD_CURL=OFF "
    + "-DBUILD_IBM=OFF "
    + "-DBUILD_IMLIB2=OFF "
    + "-DBUILD_LUA_CAIRO=OFF "
    + "-DBUILD_LUA_IMLIB2=OFF "
    + "-DBUILD_MPD=OFF"
    + "-DBUILD_NCURSES=OFF"
    + "-DBUILD_RSS=OFF"
    + "-DBUILD_X11=OFF"
    + "-DBUILD_XDAMAGE=OFF"
    + "-DBUILD_XDBE=OFF"
    + "-DBUILD_WEATHER_METAR=OFF"
    + "-DBUILD_WEATHER_XOAP=OFF"
    + "-DBUILD_WLAN=OFF"
    + "-DBUILD_NVIDIA=OFF"
    ;

  meta = with stdenv.lib; {
    homepage = http://conky.sourceforge.net/;
    description = "Advanced, highly configurable system monitor based on torsmo";
    maintainers = [ maintainers.guibert ];
    license = licenses.gpl3Plus;
    platforms = platforms.linux;
  };
}
