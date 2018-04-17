{ stdenv, fetchFromGitHub }:

stdenv.mkDerivation rec {
  version = "0.2.1";
  name = "rgsam-${version}";

  src = fetchFromGitHub {
		owner = "djhshih";
		repo = "rgsam";
		rev = "v${version}";
		sha256 = "";
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
