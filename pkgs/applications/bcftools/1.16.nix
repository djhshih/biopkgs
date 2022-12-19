{ lib, stdenv, fetchurl, htslib, zlib, bzip2, lzma, curl, perl, bash }:

stdenv.mkDerivation rec {
  version = "1.16";
  name = "bcftools-${version}";

  src = fetchurl {
    url = "https://github.com/samtools/bcftools/releases/download/${version}/${name}.tar.bz2";
    sha256 = "1mpcla3rg0vlcnpdal7229qgsmz07n3qq1dq8fi117npk9y69gwh";
  };

  preCheck = ''
    patchShebangs misc/
    patchShebangs test/
    sed -ie 's|/bin/bash|${bash}/bin/bash|' test/test.pl
  '';

  strictDeps = true;

  makeFlags = [
    "HSTDIR=${htslib}"
    "prefix=$(out)"
    "CC=${stdenv.cc.targetPrefix}cc"
  ];

  nativeBuildInputs = [ perl curl ];

  buildInputs = [ htslib zlib bzip2 lzma ];

  buildPhase = ''
    make
  '';

  installPhase = ''
    make prefix=$out install
    BCFTOOLS_PLUGINS=$out/lib/bcftools/
    mkdir -p $BCFTOOLS_PLUGINS
    install -D plugins/*.so $BCFTOOLS_PLUGINS
  '';

  meta = with lib; {
    description = "Tools for reading/writing BCF2/VCF/gVCF files and calling/filtering/summarising SNP and short indel sequence variants";
    license     = licenses.free;
    homepage    = "http://www.htslib.org"; 
  };
}
