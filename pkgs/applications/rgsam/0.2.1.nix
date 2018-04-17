{ stdenv, fetchFromGitHub }:

stdenv.mkDerivation rec {
  version = "0.2.1";
  name = "rgsam-${version}";

  src = fetchFromGitHub {
		owner = "djhshih";
		repo = "rgsam";
		rev = "v${version}";
		sha256 = "11aqsf3xdbiw93zbj3r5rmpc1r9h7p25vks1y6p8xg73ybrax0gq";
  };

	installPhase = ''
		mkdir -p $out/bin
		make install DESTDIR=$out
	'';

  meta = with stdenv.lib; {
    description = "Infer read-group information from read names in SAM or FASTQ file";
    license     = licenses.gpl3;
    homepage    = "https://github.com/djhshih/rgsam"; 
    platforms   = platforms.unix;
  };
}
