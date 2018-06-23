{ stdenv, fetchFromGitHub }:

stdenv.mkDerivation rec {
  version = "0.2";
  name = "pairfq-${version}";

  src = fetchFromGitHub {
    owner = "djhshih";
    repo = "salmon";
    rev = "v${version}";
    sha256 = "a605771d14b804cfd85bc3796890ba9afee0857518e2e52ae09b6c28c58e72f6";
  };

  meta = with stdenv.lib; {
    description = "Highly-accurate & wicked fast transcript-level quantification from RNA-seq reads using lightweight alignments";
    license     = licenses.gpl3;
    homepage    = "https://github.com/COMBINE-lab/salmon"; 
    platforms   = platforms.unix;
  };
}
