{ stdenv, fetchFromGitHub }:

stdenv.mkDerivation rec {
  version = "0.1";
  name = "rgsam-${version}";

  src = fetchFromGitHub {
		owner = "djhshih";
		repo = "rgsam";
		rev = "v${version}";
		sha256 = "0f306vy94zhv6jjc1q81dqj6hsnin2izrdwbxnd0l7zl8sx7lsjw";
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
